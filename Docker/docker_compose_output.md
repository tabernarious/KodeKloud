# docker-compose output

## First Attempt
`sudo docker-compose up`
```
Building with native build. Learn about native build in Compose here: https://docs.docker.com/go/compose-native-build/
Creating network "nginx_demo_default" with the default driver
Building app1
Sending build context to Docker daemon  5.632kB

Step 1/7 : FROM python:3
3: Pulling from library/python
0ecb575e629c: Pulling fs layer
7467d1831b69: Pulling fs layer
feab2c490a3c: Pulling fs layer
f15a0f46f8c3: Pulling fs layer
937782447ff6: Pulling fs layer
e78b7aaaab2c: Pulling fs layer
b68a1c52a41c: Pulling fs layer
ddcd772f47ec: Pulling fs layer
0753beeb7344: Pulling fs layer
f15a0f46f8c3: Waiting
937782447ff6: Waiting
e78b7aaaab2c: Waiting
b68a1c52a41c: Waiting
ddcd772f47ec: Waiting
0753beeb7344: Waiting
7467d1831b69: Verifying Checksum
7467d1831b69: Download complete
feab2c490a3c: Download complete
0ecb575e629c: Verifying Checksum
0ecb575e629c: Download complete
e78b7aaaab2c: Verifying Checksum
e78b7aaaab2c: Download complete
f15a0f46f8c3: Verifying Checksum
f15a0f46f8c3: Download complete
ddcd772f47ec: Verifying Checksum
ddcd772f47ec: Download complete
b68a1c52a41c: Verifying Checksum
b68a1c52a41c: Download complete
0753beeb7344: Verifying Checksum
0753beeb7344: Download complete
937782447ff6: Verifying Checksum
937782447ff6: Download complete
0ecb575e629c: Pull complete
7467d1831b69: Pull complete
feab2c490a3c: Pull complete
f15a0f46f8c3: Pull complete
937782447ff6: Pull complete
e78b7aaaab2c: Pull complete
b68a1c52a41c: Pull complete
ddcd772f47ec: Pull complete
0753beeb7344: Pull complete
Digest: sha256:942bc4201d0fe995d18dcf8ca50745cfe3d16c253f54366af10cae18a2bfe7f6
Status: Downloaded newer image for python:3
 ---> 619f31abac4b
Step 2/7 : COPY ./requirements.txt /requirements.txt
 ---> 338b8629ddc6
Step 3/7 : WORKDIR /
 ---> Running in be67997757df
Removing intermediate container be67997757df
 ---> 16696c5401c8
Step 4/7 : RUN pip install -r requirements.txt
 ---> Running in 892251debaf3
Collecting Flask==1.1.2
  Downloading Flask-1.1.2-py2.py3-none-any.whl (94 kB)
Collecting click>=5.1
  Downloading click-7.1.2-py2.py3-none-any.whl (82 kB)
Collecting itsdangerous>=0.24
  Downloading itsdangerous-1.1.0-py2.py3-none-any.whl (16 kB)
Collecting Jinja2>=2.10.1
  Downloading Jinja2-2.11.3-py2.py3-none-any.whl (125 kB)
Collecting Werkzeug>=0.15
  Downloading Werkzeug-1.0.1-py2.py3-none-any.whl (298 kB)
Collecting MarkupSafe>=0.23
  Downloading MarkupSafe-1.1.1-cp39-cp39-manylinux2010_x86_64.whl (32 kB)
Installing collected packages: MarkupSafe, Werkzeug, Jinja2, itsdangerous, click, Flask
Successfully installed Flask-1.1.2 Jinja2-2.11.3 MarkupSafe-1.1.1 Werkzeug-1.0.1 click-7.1.2 itsdangerous-1.1.0
Removing intermediate container 892251debaf3
 ---> ce7dcdde4617
Step 5/7 : COPY . /
 ---> bd67d38ff1a2
Step 6/7 : ENTRYPOINT [ "python3" ]
 ---> Running in 5ec34c15ac5c
Removing intermediate container 5ec34c15ac5c
 ---> e93795f48599
Step 7/7 : CMD [ "app1.py" ]
 ---> Running in 0bf1afd5d25f
Removing intermediate container 0bf1afd5d25f
 ---> 9c9a06d2da07
Successfully built 9c9a06d2da07
Successfully tagged nginx_demo_app1:latest
WARNING: Image for service app1 was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Building app2
Sending build context to Docker daemon  5.632kB

Step 1/7 : FROM python:3
 ---> 619f31abac4b
Step 2/7 : COPY ./requirements.txt /requirements.txt
 ---> Using cache
 ---> 338b8629ddc6
Step 3/7 : WORKDIR /
 ---> Using cache
 ---> 16696c5401c8
Step 4/7 : RUN pip install -r requirements.txt
 ---> Using cache
 ---> ce7dcdde4617
Step 5/7 : COPY . /
 ---> d2a23d6d78af
Step 6/7 : ENTRYPOINT [ "python3" ]
 ---> Running in d65b5e58cf3e
Removing intermediate container d65b5e58cf3e
 ---> 19dde77482d2
Step 7/7 : CMD [ "app1.py" ]
 ---> Running in 05eb53972390
Removing intermediate container 05eb53972390
 ---> dbb9db11d14b
Successfully built dbb9db11d14b
Successfully tagged nginx_demo_app2:latest
WARNING: Image for service app2 was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Building nginx
Sending build context to Docker daemon  2.048kB

Step 1/3 : FROM nginx
latest: Pulling from library/nginx
45b42c59be33: Pulling fs layer
8acc495f1d91: Pulling fs layer
ec3bd7de90d7: Pulling fs layer
19e2441aeeab: Pulling fs layer
f5a38c5f8d4e: Pulling fs layer
83500d851118: Pulling fs layer
f5a38c5f8d4e: Waiting
19e2441aeeab: Waiting
83500d851118: Waiting
ec3bd7de90d7: Verifying Checksum
ec3bd7de90d7: Download complete
19e2441aeeab: Verifying Checksum
19e2441aeeab: Download complete
45b42c59be33: Verifying Checksum
45b42c59be33: Download complete
8acc495f1d91: Verifying Checksum
8acc495f1d91: Download complete
f5a38c5f8d4e: Verifying Checksum
f5a38c5f8d4e: Download complete
83500d851118: Verifying Checksum
83500d851118: Download complete
45b42c59be33: Pull complete
8acc495f1d91: Pull complete
ec3bd7de90d7: Pull complete
19e2441aeeab: Pull complete
f5a38c5f8d4e: Pull complete
83500d851118: Pull complete
Digest: sha256:f3693fe50d5b1df1ecd315d54813a77afd56b0245a404055a946574deb6b34fc
Status: Downloaded newer image for nginx:latest
 ---> 35c43ace9216
Step 2/3 : RUN rm /etc/nginx/conf.d/default.conf
 ---> Running in a7a96488f1ba
Removing intermediate container a7a96488f1ba
 ---> bcf706718bba
Step 3/3 : COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY failed: file not found in build context or excluded by .dockerignore: stat nginx.conf: file does not exist
ERROR: Service 'nginx' failed to build
```

## Second Attempt
`sudo docker-compose up`
```
Building with native build. Learn about native build in Compose here: https://docs.docker.com/go/compose-native-build/
Building nginx
Sending build context to Docker daemon  3.072kB

Step 1/3 : FROM nginx
 ---> 35c43ace9216
Step 2/3 : RUN rm /etc/nginx/conf.d/default.conf
 ---> Using cache
 ---> bcf706718bba
Step 3/3 : COPY nginx.conf /etc/nginx/conf.d/default.conf
 ---> 82ab72883355
Successfully built 82ab72883355
Successfully tagged nginx_demo_nginx:latest
WARNING: Image for service nginx was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Creating nginx_demo_app1_1 ... done
Creating nginx_demo_app2_1 ... done
Creating nginx_demo_nginx_1 ... done
Attaching to nginx_demo_app2_1, nginx_demo_app1_1, nginx_demo_nginx_1
app1_1   | python3: can't open file '//app1.py': [Errno 2] No such file or directory
app2_1   | python3: can't open file '//app1.py': [Errno 2] No such file or directory
nginx_1  | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
nginx_1  | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
nginx_1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
nginx_demo_app1_1 exited with code 2
nginx_demo_app2_1 exited with code 2
nginx_1  | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
nginx_1  | 10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
nginx_1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
nginx_1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
nginx_1  | /docker-entrypoint.sh: Configuration complete; ready for start up
```