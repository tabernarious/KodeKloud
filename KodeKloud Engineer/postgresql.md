# PostgreSQL

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-centos-7

## Install
sudo yum list postresql
sudo yum install -y postgresql-server postgresql-contrib

## Initialize and Start
sudo postgresql-setup initdb
sudo systemctl start postgresql
sudo systemctl enable postgresql

## Configure PosgreSQL

### Set Linux and PostgreSQL password for postgres user
sudo passwd postgres
    DOLT*fob0jouk-twag
sudo su - postgres
psql -c "ALTER USER postgres WITH PASSWORD 'plot*nad_flea6ZAS';"

### Switch to Linux postgres User
sudo su - postgres

### Create PostgreSQL User and set PostgreSQL password
createuser --interactive
    kodekloud_joy
    n
    n
    n

psql -c "ALTER USER kodekloud_joy WITH PASSWORD 'ksH85UJjhb';"

### Create PostgreSQL DB
createdb -O kodekloud_joy kodekloud_db1

### Grant Privileges to User
psql -c "GRANT ALL PRIVILEGES ON DATABASE kodekloud_db1 TO kodekloud_joy;"

### Configure MD5 authentication METHOD
sudo vi /var/lib/pgsql/data/pg_hba.conf

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
#local   all             all                                     peer
local   all             all                                     md5
# IPv4 local connections:
#host    all             all             127.0.0.1/32            ident
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 ident
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     postgres                                peer
#host    replication     postgres        127.0.0.1/32            ident
#host    replication     postgres        ::1/128                 ident
```

sudo systemctl restart postgresql

### Login to database from any linux user
psql -U kodekloud_joy -d kodekloud_db1 -W
psql -U kodekloud_joy -d kodekloud_db1 -h 127.0.0.1 -W


su - kodekloud_joy
psql -d kodekloud_db1


## Other Commands

### Show Database Permissions
kodekloud_db1=> \l
List of databases
-[ RECORD 1 ]-----+--------------------------------
Name              | kodekloud_db1
Owner             | kodekloud_joy
Encoding          | UTF8
Collate           | en_US.UTF-8
Ctype             | en_US.UTF-8
Access privileges | =Tc/kodekloud_joy
                  | kodekloud_joy=CTc/kodekloud_joy
-[ RECORD 2 ]-----+--------------------------------
Name              | postgres
Owner             | postgres
Encoding          | UTF8
Collate           | en_US.UTF-8
Ctype             | en_US.UTF-8
Access privileges | 
-[ RECORD 3 ]-----+--------------------------------
Name              | template0
Owner             | postgres
Encoding          | UTF8
Collate           | en_US.UTF-8
Ctype             | en_US.UTF-8
Access privileges | =c/postgres
                  | postgres=CTc/postgres
-[ RECORD 4 ]-----+--------------------------------
Name              | template1
Owner             | postgres
Encoding          | UTF8
Collate           | en_US.UTF-8
Ctype             | en_US.UTF-8
Access privileges | =c/postgres
                  | postgres=CTc/postgres

### View global permissions
postgres=> \du

### Connect to database
\c kodekloud_db1







## Switch to postres user
sudo -i -u postgres
psql
createuser --interactive
\q
exit

## Interact without switching user
sudo -u postgres psql
\q

sudo -u postgres createuser --interactive



## Kode Kloud Task
The Nautilus application development team has shared that they are planning to deploy one newly developed application on Nautilus infra in Stratos DC. The application uses PostgreSQL database, so as a pre-requisite we need to set up PostgreSQL database server as per requirements shared below:


a. Install and configure PostgreSQL database on Nautilus database server.

b. Create a database user kodekloud_joy and set its password to ksH85UJjhb.

c. Create a database kodekloud_db1 and grant full permissions to user kodekloud_joy on this database.

d. Make appropriate settings to allow all local clients (local socket connections) to connect to the kodekloud_db1 database through kodekloud_joy user using md5 method (Please do not try to encrypt password with md5sum).

e. At the end its good to test the db connection using these new credentials from root user or server's sudo user.