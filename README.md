# masters-thesis-code
The code developed during my masters-thesis



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

The preceding command will download the latest snapshot map extract over Norway from Geofabrik. You might want to change the URL to download your desired dataset depending on your needs. Older files are also available; consult the index mentioned above.

### Download updates (OMS Change files)
Geofabrik also publishes change files in the OSM Change file format `.osc`. These can be downloaded in bulk like this:  

```sh
curl -fLO --no-progress-meter "https:/download.geofabrik.de/europe/norway-updates/000/003/[705-834].osc.gz"
```

⚠️ **Consult the website to find out which change files are available.** The range `[705-834]` is just an example of what was available when writing this.

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

