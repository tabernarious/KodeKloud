# NGINX Demo

Based on:
* https://towardsdatascience.com/sample-load-balancing-solution-with-docker-and-nginx-cf1ffc60e644
* https://runnable.com/docker/python/docker-compose-with-flask-apps
* https://hackersandslackers.com/flask-jinja-templates/

### Create Flask apps:

`app1/app.py`
```
from flask import Flask

app = Flask(__name__)
@app.route('/')

def hello_world():
  return 'Hello! This is App1 :)'

if __name__ == '__main__':
  app.run(host='0.0.0.0', debug=True)
```

`app2/app.py`
```
from flask import request, Flask

app = Flask(__name__)
@app.route('/')

def hello_world():
  return 'Hello! This is App2 :)'

if __name__ == '__main__':
  app.run(host='0.0.0.0', debug=True)
```

`app3/app.py`
```
from flask import request, Flask

app = Flask(__name__)
@app.route('/')

def hello_world():
  return 'Hello! This is App3 :)'

if __name__ == '__main__':
  app.run(host='0.0.0.0', debug=True)
```

### Test Flask app by exporting and running externally:
```
export FLASK_APP=app.py
flask run --host=10.204.136.10
```

### Create app1 requirements.txt

`app1/requirements.txt` and `app2/requirements.txt`
```
Flask==1.1.2
```

### Create app1 Dockerfile

`app1/Dockerfile` and `app2/Dockerfile`
```
FROM python:3
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD python app.py
```

### Configure nginx.conf

`nginx/nginx.conf`
```
upstream loadbalancer {
  server 172.17.0.1:5001 weight=1;
  server 172.17.0.1:5002 weight=2;
  server 172.17.0.1:5003 weight=3;
}
#upstream loadbalancer {
#  server nginx_demo_app1:5001 weight=6;
#  server nginx_demo_app2:5002 weight=4;
#}

server {
  location / {
    proxy_pass http://loadbalancer;
  }
}
```

### Configure nginx Dockerfile

`nginx/Dockerfile`
```
FROM nginx
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
```

### Create docker-compose.yml

`docker-compose.yml`
version: '3'
services:
  app1:
    build: ./app1
    ports:
      - "5001:5000"

  app2:
    build: ./app2
    ports:
      - "5002:5000"

  app3:
    build: ./app3
    ports:
      - "5003:5000"

  nginx:
    build: ./nginx
    ports:
      - "8080:80"
    depends_on:
    - app1
    - app2
    - app3
```

### Build containers
```
sudo docker-compose build
```

### Run containers in the background
```
sudo docker-compose up -d
sudo docker-compose -f ~/nginx-demo/nginx-basic-lb/docker-compose.yml up -d
```

### List containers for this docker-compose context
```
sudo docker-compose ps
sudo docker-compose -f ~/Docker-compose-Nginx-Reverse-Proxy/docker-compose.yml ps
```

### List containers
```
sudo docker ps -a
```
```
CONTAINER ID   IMAGE              COMMAND                  CREATED          STATUS                          PORTS                  NAMES
1d355976d4dc   nginx_demo_nginx   "/docker-entrypoint.…"   5 minutes ago    Up About a minute               0.0.0.0:8080->80/tcp   nginx_demo_nginx_1
746a7a2ff28f   nginx_demo_app2    "python3 app1.py"        5 minutes ago    Exited (2) About a minute ago                          nginx_demo_app2_1
12e08061bd65   nginx_demo_app1    "python3 app1.py"        5 minutes ago    Exited (2) About a minute ago                          nginx_demo_app1_1
4e31f44857db   hello-world        "/hello"                 58 minutes ago   Exited (0) 58 minutes ago                              festive_visvesvaraya
```

### Inspect containers
```
sudo docker inspect nginx_demo_app1
```

### Review container networking
```
sudo docker network ls
```
```
NETWORK ID     NAME                 DRIVER    SCOPE
8f73f7f2d089   bridge               bridge    local
0135f77b58a1   host                 host      local
d98d1e36e13d   nginx_demo_default   bridge    local
b588a90dd4cd   none                 null      local
```
```
sudo docker network inspect nginx_demo_default
```

### Attach to process running in container
```
sudo docker container attach nginx-basic-lb-2_nginx_1
```

### Attach to bash 
```
sudo docker exec -it nginx-basic-lb-2_nginx_1 /bin/bash
```

## Development Process
VS Code: `Update and save files`

VS Code: `git commit`

VS Code: `git push`

Docker Host: `git pull`

Docker Host: `sudo docker-compose build`

Docker Host: `sudo docker-compose down`

Docker Host: `sudo docker-compose ps`

Docker Host: `sudo docker-compose up`

git pull
sudo docker-compose build
sudo docker-compose down
sudo docker-compose ps
#sudo docker-compose up
sudo docker-compose up -d
sudo docker-compose ps
