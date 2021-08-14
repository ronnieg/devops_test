# Devops Test

### Overview
This is an application that is a dummy webservice that returns the
last update time.  The last updated time is cached in redis and
resets every 5 seconds.  It has a single '/' endpoint.  The redis
address is passed in through the environment.

NOTE: The following tasks should take no more than 1 hour total.

### Tasks
1. create Dockerfile for this application
2. create docker-compose.yaml to replicate a full running environment 
so that a developer can run the entire application locally without having
to run any dependencies (i.e. redis) in a separate process.
3. explain how you would monitor this application in production.  Please 
write code to do the monitoring.

Please fork this repository and make a pull request with your changes.
