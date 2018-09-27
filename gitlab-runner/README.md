Inspired by https://docs.gitlab.com/runner/install/docker.html

To use:
1. Install docker
curl -sSL https://get.docker.com/ | sh

2. Start the docker-compose script
sudo docker-compose up -d

3. Register gitlab-runner for your project
sudo docker exec -it gitlab-runner gitlab-runner register

4. Restart docker-compose script
sudo docker-compose down
sudo docker-compose up -d
