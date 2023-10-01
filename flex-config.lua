-- local inspect = require("inspect")

local srid = 4326
local tables = {}

tables.points = osm2pgsql.define_node_table("points", {
  { column = "tags",    type = "jsonb" },
  { column = "geom",    type = "point", projection = srid, not_null = true },
  { column = "version", type = "int" },
  { column = "created", type = "text" }
})

tables.linestrings = osm2pgsql.define_way_table("linestrings", {
  { column = "tags",    type = "jsonb" },
  { column = "geom",    type = "linestring", projection = srid, not_null = true },
  { column = "version", type = "int" },
  { column = "created", type = "text" }
})

tables.polygons = osm2pgsql.define_area_table("polygons", {
  { column = "type",    type = "text" },
  { column = "tags",    type = "jsonb" },
  { column = "geom",    type = "geometry", projection = srid, not_null = true },
  { column = "version", type = "int" },
  { column = "created", type = "text" }
})

local function format_date(ts)
  return os.date('!%Y-%m-%dT%H:%M:%SZ', ts)
end

function osm2pgsql.process_node(object)
  local geom = object:as_point()
  tables.points:insert({
    tags = object.tags,
    geom = geom,
    created = format_date(object.timestamp),
    version = object.version
  })
end

function osm2pgsql.process_way(object)
  if object.is_closed then
    local geom = object:as_polygon()
    tables.polygons:insert({
      type = object.type,
      tags = object.tags,
      geom = geom,
      created = format_date(object.timestamp),
      version = object.version
    })
  else
    local geom = object:as_linestring()
    tables.linestrings:insert({
      tags = object.tags,
      geom = geom,
      created = format_date(object.timestamp),
      version = object.version
    })
  end
end

function osm2pgsql.process_relation(object)
  local rel_type = object.tags.type
  if rel_type == "multipolygon" then
    local geom = object:as_multipolygon()
    tables.polygons:insert({
      type = object.type,
      tags = object.tags,
      geom = geom,
      created = format_date(object.timestamp),
      version = object.version
    })
  else
    local geom = object:as_multilinestring():line_merge()
    tables.polygons:insert({
      type = object.type,
      tags = object.tags,
      geom = geom,
      created = object.timestamp,
      version = object.version
    })
  end
end
