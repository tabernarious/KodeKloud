# Install and Configure NFS

https://www.howtoforge.com/nfs-server-and-client-on-centos-7

sudo yum install nfs-utils

sudo mkdir /code

sudo chmod -R 755 /code
#chown nfsuser:nfsuser /code

sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl enable nfs-lock
sudo systemctl enable nfs-idmap
sudo systemctl start rpcbind
sudo systemctl start nfs-server
sudo systemctl start nfs-lock
sudo systemctl start nfs-idmap

sudo vi /etc/exports
# NOTE: I received permissions errors if I only used "(r)". Maybe the directory needed different permissions...
```
/code    172.16.238.10(rw) 172.16.238.11(rw) 172.16.238.12(rw)
#/home    192.168.0.101(rw,sync,no_root_squash,no_all_squash)
```

#exportfs
sudo systemctl restart nfs-server

#firewall-cmd --permanent --zone=public --add-service=nfs
#firewall-cmd --permanent --zone=public --add-service=mountd
#firewall-cmd --permanent --zone=public --add-service=rpc-bind
#firewall-cmd --reload

## Client
sudo yum install nfs-utils
sudo mkdir -p /var/www/data
sudo mount -t nfs ststor01:/code /var/www/data
ls -lah /var/www/data


## Kode Kloud Task

For our infrastructure in Stratos Datacenter, we need to serve our website code from a common/shared location that can be shared among all app nodes. To solve this, we came up with a solution to use the NFS (Network File System) server where we can store the data and mount the share among our app nodes. The dedicated NFS server will be our storage server. To accomplish this task, perform the following steps:


Install required NFS packages on storage server.

Configure storage server to act as an NFS server.

Make a NFS share /code on storage server.

Install and configure NFS client packages on all app nodes and configure them to act as NFS client.

Mount /code directory on all app nodes at /var/www/data directory (Create the directories if don't exist).

Start and enable required services.

There is an /tmp/index.html file on jump host. Copy this file on NFS server (storage server) under /code and make sure it gets replicated to all app servers in mounted location.