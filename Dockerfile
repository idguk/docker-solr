FROM ubuntu:14.04
MAINTAINER Adrian Black "adrian_black@idg.co.uk"

# Install java
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -yq openjdk-7-jre-headless tar wget

# Install Solr 333.
ENV SOLR_VERSION 3.6.2
RUN mkdir -p /opt
RUN wget -nv http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/apache-solr-$SOLR_VERSION.tgz -O /opt/solr-$SOLR_VERSION.tgz
RUN tar -C /opt --extract --file /opt/solr-$SOLR_VERSION.tgz
RUN mv /opt/apache-solr-$SOLR_VERSION/example /opt/solr
RUN rm -rf /opt/solr-$SOLR_VERSION.tgz /opt/solr-$SOLR_VERSION

# Start solr
WORKDIR /opt/solr
EXPOSE 8983
CMD [ "/usr/bin/java", "-Dsolr.solr.home=/opt/solr/idgukmulticore", "-jar", "start.jar" ]
