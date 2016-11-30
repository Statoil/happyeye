FROM elasticsearch:5

RUN rm /usr/share/elasticsearch/config/elasticsearch.yml
COPY config/elasticsearch.yml /usr/share/elasticsearch/config

RUN mkdir -p /usr/share/elasticsearch/backup

EXPOSE 9200
EXPOSE 9300