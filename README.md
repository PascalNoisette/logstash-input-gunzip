# Logstash Gunzip Input Plugin

[![Travis Build Status](https://travis-ci.org/logstash-plugins/logstash-input-gunzip.svg)](https://travis-ci.org/logstash-plugins/logstash-input-gunzip)

This is a plugin for [Logstash](https://github.com/elastic/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

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
```

# How to use it

Test on logstash-6.2.4.tar.gz

```
bin/logstash-plugin install logstash-input-gunzip-1.0.0.gem
bin/logstash -e 'input { gunzip { path => ["/var/log/syslog.2.gz", "/var/log/syslog.3.gz"] } } output {stdout { codec => rubydebug }}'
```