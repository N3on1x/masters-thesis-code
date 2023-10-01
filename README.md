# masters-thesis-code
The code developed during my masters-thesis

## Contents

- [Download OSM data](#download-from-geofabrik)
  - [Download extract](#download-extract)
  - [Download updates](#download-updates-oms-change-files)
- [Inspect OSM files](#inspect-files-with-osmium-tool)
- [Run PostgreSQL with Docker](#run-postgresql-with-docker-optional)
  - [Preset parameters for PostgreSQL](#preset-parameters-for-postgresql)
  - [Preset parameters for pgAdmin](#preset-parameters-for-pgadmin)


---
## Download from Geofabrik
Data extracts from OpenStreetMap can be downloaded at https://download.geofabrik.de

A machine-readable index can be downloaded at https://download.geofabrik.de/index-v1-nogeom.json  
Example using `curl`: 

```sh
curl -fLO https://download.geofabrik.de/index-v1-nogeom.json
```

### Download extract
A snapshot map extract for a region can be downloaded like this:

```sh
curl -fLO https://download.geofabrik.de/europe/norway-latest.osm.pbf
```

The preceding command will download the latest snapshot map extract over Norway from Geofabrik.
You might want to change the URL to download your desired dataset depending on your needs.
Older files are also available; consult the index mentioned above.


### Download updates (OMS Change files)
Geofabrik also publishes change files in the OSM Change file format `.osc`. These can be downloaded in bulk like this:  

```sh
curl -fLO --no-progress-meter "https:/download.geofabrik.de/europe/norway-updates/000/003/[705-834].osc.gz"
```

> [!NOTE]
> **Consult the website to find out which change files are available.**
> The range `[705-834]` is just an example of what was available when writing this.

---

## Inspect files with `osmium` tool
Osmium is a multipurpose tool for working with OpenStreetMap data. Download and installation instructions can be found here: https://osmcode.org/osmium-tool/

To view information about an OSM file (e.g. `.osm` or `.osc`), you can use the following command:
```sh
osmium fileinfo --extended norway-latest.osm.pbf
```

<details>
  <summary>Example output</summary>
  
  ```txt
  File:
  Name: norway-latest.osm.pbf
  Format: PBF
  Compression: none
  Size: 1257910690
Header:
  Bounding boxes:
    (-11.36801,57.55323,35.52711,81.05195)
  With history: no
  Options:
    generator=osmium/1.14.0
    osmosis_replication_base_url=http://download.geofabrik.de/europe/norway-updates
    osmosis_replication_sequence_number=3834
    osmosis_replication_timestamp=2023-09-28T20:21:09Z
    pbf_dense_nodes=true
    pbf_optional_feature_0=Sort.Type_then_ID
    sorting=Type_then_ID
    timestamp=2023-09-28T20:21:09Z
[======================================================================] 100% 
Data:
  Bounding box: (-20.9172,53.324144,38,83.742582)
  Timestamps:
    First: 2005-05-21T21:03:22Z
    Last: 2023-09-28T20:02:34Z
  Objects ordered (by type and id): yes
  Multiple versions of same object: no
  CRC32: not calculated (use --crc/-c to enable)
  Number of changesets: 0
  Number of nodes: 189722973
  Number of ways: 11320196
  Number of relations: 699932
  Smallest changeset ID: 0
  Smallest node ID: 110
  Smallest way ID: 1227
  Smallest relation ID: 336
  Largest changeset ID: 0
  Largest node ID: 11225586815
  Largest way ID: 1211658404
  Largest relation ID: 16393499
  Number of buffers: 243412 (avg 828 objects per buffer)
  Sum of buffer sizes: 15540882848 (14.82 GB)
  Sum of buffer capacities: 15957032960 (15.217 GB, 97% full)
Metadata:
  All objects have following metadata attributes: version+timestamp
  Some objects have following metadata attributes: version+timestamp
```

</details>

> [!NOTE]
> Smaller extracts can be obtained by using the `osmium extract` command with a bounding box:
> ```sh
> osmium extract --bbox=LONG1,LAT1,LONG2,LAT2 OSM-FILE`
> ```
> This command works for both `.osm` and `.osc` files.



---

# Run PostgreSQL with Docker (optional)
In order to import OSM data to PostgreSQL, you need to have PostgreSQL installed.
You can install it locally, or you can run it in a Docker container.
The latter is recommended, as it is easier to manage and remove when you are done.

> Docker can be installed from the official website: https://docker.com

To run the [docker compose file](docker/compose.yaml) included in this repository you can run:  
```sh
docker compose -f docker/compose.yaml up -d
```
This will run the containers in the background. To stop the containers, run:
```sh
docker compose -f docker/compose.yaml down
```

This will create two containers: one for PostgreSQL and one for pgAdmin.

PostgreSQL will be available on `localhost:5432`, and pgAdmin on `localhost:5433`.

> [pqAdmin](https://www.pgadmin.org) is a web-based GUI for PostgreSQL.

## Preset parameters for PostgreSQL
These are some preset parameters in the Docker compose file.

| Property | Value |
| --- | --- | 
| username | `postgres` | 
| password | `postgres` |
| default database | `osm`  |

## Preset parameters for pgAdmin
These are some preset parameters in the Docker compose file.

| Property | Value |
| --- | --- | 
| username | masters@example.com | 
| password | password | 

> [!WARNING]
> *Security Notice:* These settings are only appropriate for local development, and should not be used in productions.
