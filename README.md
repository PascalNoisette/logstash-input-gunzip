# Logstash Gunzip Input Plugin

## Awards

[![Travis Build Status](https://travis-ci.org/logstash-plugins/logstash-input-gunzip.svg)](https://travis-ci.org/logstash-plugins/logstash-input-gunzip)

[![Gem Version](https://badge.fury.io/rb/logstash-input-gunzip.svg)](https://badge.fury.io/rb/logstash-input-gunzip)


## Introduction

This is a plugin for [Logstash](https://github.com/elastic/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.


## Purpuse and use case

This input plugin read in place gziped file. I use this plugin to parse log file that has already been logrotated, and also to parse huge files that could not be decompressed easily.

# How to use it

```
bin/logstash-plugin install logstash-input-gunzip
bin/logstash -e 'input { gunzip { path => ["/var/log/syslog.2.gz", "/var/log/syslog.3.gz"] } } output {stdout { codec => rubydebug }}'
```


# Contribute

## Build the gem


```
docker run -it --rm -v "$PWD":/usr/src/app -w /usr/src/app jruby:9 /bin/bash
$ bundle install --system
$ bundle exec rspec
$ gem build logstash-input-gunzip.gemspec

```

## Publish

```
$ curl -uUsername:Password https://rubygems.org/api/v1/api_key.yaml > ~/.gem/credentials
$ chmod 0600 ~/.gem/credentials
$ bundle exec rake publish_gem
```

# How to use it

```
bin/logstash-plugin install logstash-input-gunzip
bin/logstash -e 'input { gunzip { path => ["/var/log/syslog.2.gz", "/var/log/syslog.3.gz"] } } output {stdout { codec => rubydebug }}'
```