#!/bin/bash

#
# Delete happymeter index (if exists)
#
#curl -XDELETE 'http://localhost:9200/happymeter' 
#curl -XDELETE 'http://localhost:9200/datalake' 

#
# Define main index - happymeter
#
curl -XPUT localhost:9200/happymeter?pretty -d '{
    "settings" : {
        "number_of_shards" : 1
    },
    "mappings" : {
        "happymeter" : {
            "properties" : {
                "happystatus": { "type": "string", "index": "not_analyzed" },
                "timestamp": {"type": "date"},
                "tags": {"type": "string", "index": "not_analyzed"},
                "comment": {"type": "string", "index": "analyzed"},
                "sensorValues" : {
                    "properties": {
                        "temperature": {"type": "float", "index": "not_analyzed"},
                        "relativeHumidity": {"type": "float", "index": "not_analyzed"},
                        "barometricPressure": {"type": "float", "index": "not_analyzed"}, 
                        "lightLevel": {"type": "float", "index": "not_analyzed"}
                    }
                 }
                }
            }
    }
}'

#
# Define datalake 
#
curl -XPUT localhost:9200/datalake?pretty -d '{
    "settings" : {
        "number_of_shards" : 1
    },
    "mappings" : {
        "datalake" : {
            "properties" : {
                "timestamp": {"type": "date"},
                "location": {"type": "string", "index": "not_analyzed"},
                "sensorValues" : {
                    "properties": {
                        "temperature": {"type": "float", "index": "not_analyzed"},
                        "relativeHumidity": {"type": "float", "index": "not_analyzed"},
                        "barometricPressure": {"type": "float", "index": "not_analyzed"}, 
                        "lightLevel": {"type": "float", "index": "not_analyzed"},
                        "motions": {"type": "integer", "index": "not_analyzed"}
                    }
                 }
                }
            }
    }
}'




#
# Create a snapshot backups (named happy_backup)
#
curl -XPUT 'http://localhost:9200/_snapshot/happy_backup' -d '{
    "type": "fs",
    "settings": {
        "location": "backup",
        "compress": "true"
    }
}'

