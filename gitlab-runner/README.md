# gitlab-runner: docker-compose script

To startup / shutdown the gitlab-runner Docker image.

Inspired by https://docs.gitlab.com/runner/install/docker.html

To use:
1. Install docker
```
curl -sSL https://get.docker.com/ | sh
```


2. Copy the docker-compose.yml script to a folder, then start the docker-compose script from that folder
```
sudo docker-compose up -d
```

3. Register gitlab-runner for your project
```
sudo docker exec -it gitlab-runner gitlab-runner register
```


4. Restart docker-compose script
```
sudo docker-compose down
sudo docker-compose up -d
```
