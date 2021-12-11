# Task 1 - Docker

1. Create Dockerfile for this application
2. Create docker-compose.yaml to replicate a full running environment 
so that a developer can run the entire application locally without having
to run any dependencies (i.e. redis) in a separate process.
3. Explain how you would monitor this application in production. 
Please write code/scripts to do the monitoring.

# Environment setup

## Tools
| Tool | Version | Description | URL |
| :--- | :------ | :---------- | :-- | 
| Docker| 20.10.8+ | Docker Desktop for local image build | TBD |
| docker-compose | 1.29.2+ | Docker-compose for run local environment | TBD |


### Build and Push image: 
1. Download repository
```bash
git clone https://github.com/ronnieg/devops_test.git
```
2. Build image
```bash
cd ~/devops_test/result/task1/
docker build -t dummy-webservice:0.0.1 .
```
3. Docker push
```bash
docker tag dummy-webservice:0.0.1 yahorbukatkin/dummy-webservice:0.0.1
docker push yahorbukatkin/dummy-webservice:0.0.1
```
4. Local run command
```bash
docker run -e REDIS_ADDR=redis_url:6379 --rm -d -p 8080:8080 yahorbukatkin/dummy-webservice:0.0.1
```

### Run docker-compose with Redis

1. Download repository
```bash
git clone https://github.com/ronnieg/devops_test.git
```

2. Run docker-compose file
```bash
cd ~/devops_test/result/task1/
docker-compose --env-file ./config/.env.dev up 
```

Results in log:
```bash
web_1    | {"level":"info","ts":1639219319.0676296,"caller":"app/main.go:53","msg":"got updated_time"}
```

### Monitoring
#### Base sh script with one function for demonstrate monitoring (e.g. Scripts was tested on docker-compose env)

Script result has been prepared for prometheus style. For run, please use:
```bash
cd ~/devops_test/result/task1/monitoring/
bash monitoring.sh
```

Result: 
```bash
dummy_webserver_up{date=1639222691,container=dummy_webservice,instance=127.0.0.1:8080,service=dummy_webservice} 200
```