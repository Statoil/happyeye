# happyeye
A simple happymeter solution which should capture information about employee happiness from various perspectives

Work has just started - we will evolve with the demand :)

### General architecture
* Happiness submitters frontend: Anything that can post a form to a web service. We provide a static html file/interface
* Middleware: A web service accepting request storing these into a elasticsearch database
* Happiness reviewers frontend: Kibana
* Happiness storage: Elasticsearch

### Document format
* happystatus: 'average'|'below'|'above', tags: '<string>'
* Minimum length for tags a 3 chars, tags can only be alphanumerics, illegal tags will be discarded, all tags will be converted to lower case.

### API

#### Store Happy Document

> Endpoint
> ```
> POST http://localhost:3000/api/storehappydocument
> ```
> POST Data:
> * happystatus: (string set: above|average|below)
> * tags: (string)
> * comment: (string)
> * sensorValues: (object: {"temperature": string|number, "barometricPress": string|number, "relativeHumidity": string|number, "lightLevel": string|number})
>
> Example
> ```
> CURL -X POST http://localhost:3000/api/storehappydocument -d {"happystatus": "above", "tags": "in the morning"}
> ```

#### Store Mood and Tag

> Endpoint
> ```
> GET http://localhost:3000/api/storemoodandtag/:mood/:tag
> ```
> GET Params:
> * mood: (string set: above|average|below)
> * tags: (string)
>
> Example
> ```
> CURL -X GET http://localhost:3000/api/storemoodandtag/above/ilovecoding
> ```

### Deployment
* Alter and then source 'docker-compose_env'
* Verify config files for kibana and nginx (happysensor/conf). The default values will often be enough.
* docker-compose up
* execute "elasticsearch/elastic_setup.sh" to create index and mapping

#### middleware: happyeyeserver ####

A server component that accepts post to a given url and store meeter documents in an elaticsearch database

* 'npm install' to initialise
* 'grunt' for development with linting, watch, server reload ...
