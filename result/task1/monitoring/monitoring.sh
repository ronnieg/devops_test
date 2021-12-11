#!/bin/bash

###
#   Base monitoring in production:
#   WEB:
#   - Get up or down instance
#   - Get status code
#   - Get responce time
#   - Get count requests
#   - Get CPU  usage
#   - Get Memory usage
# 
#   REDIS:
#   - Get performance metrics
#   - Get memory metrics
#   - Persistence metrics
#   - Error metrics
# Simple example:
##

DUMMY_WEBSERVER_HOST=${DUMMY_WEBSERVER_HOST:-"127.0.0.1:8080"}
REDIS_HOST=${REDIS_HOST:-"127.0.0.1:6379"}

# Get service status

function get_status_code {
    DUMMY_WEBSERVER_UP=$(curl -o /dev/null -s -w "%{http_code}\n" $DUMMY_WEBSERVER_HOST)
    echo $DUMMY_WEBSERVER_UP | awk \
    -v date=$(date +%s) \
    -v instance=$(echo $DUMMY_WEBSERVER_HOST)\
    '{print "dummy_webserver_up{date="date",container=dummy_webservice,instance=" instance ",service=dummy_webservice}" " " $1}'
}

function main {
    get_status_code
}

main
