This is a Django 1.11 deploy configuration for a simplistic production deployment consisting of:
1. A sample Django web app
2. UWSGI server
3. Django Q Cluster (async task support)

The sample Django app is in the project/ folder, which will be included in the Docker build.

Sample docker-compose file included for deployment with NGINX
