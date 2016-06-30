var elasticsearch = require('elasticsearch');

var elasticClient = new elasticsearch.Client({  
    host: (process.env.ELASTICURL || 'localhost:9200'),
    log: 'info'
});

var indexName = "happymeter";

/* check if the index exists */
function indexExists() {  
    return elasticClient.indices.exists({
        index: indexName
    });
}
exports.indexExists = indexExists;  

/* Add new document to index */
function addDocument(happystatus,tags) {  
    return elasticClient.index({
        index: indexName,
        type: "happymeter",
        body: {
            happystatus: happystatus,
            timestamp: Date.now(),
            tags: tags
        }
    });
}
exports.addDocument = addDocument;

/* List top 10 tags */
function listTop10Tags(callback) {
    var tagsListArray=[];

    elasticClient.search({
        index: "happymeter",
        body: {
            "aggs": {
                "aggs": {
                    "terms": {
                        "field": "tags",
                        "size": 10,
                        "min_doc_count": 2
                    }
                }
            }
        }
    }).then(function (body) {
      
        tagsListArray = body.aggregations.aggs.buckets;
        console.log("listTop10Tags: " + JSON.stringify(tagsListArray));
        
        callback(tagsListArray);

    }, function (error) {
        console.trace("listTop10Tags: " + error.message);
        callback(tagsListArray);
    });
}
exports.listTop10Tags = listTop10Tags;

