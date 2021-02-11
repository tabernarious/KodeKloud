https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/storage_administration_guide/s1-nfs-start

# Client
sudo mount -t nfs ststor01:/app /var/www/html

# Server
sudo systemctl status rpcbind
sudo systemctl start rpcbind

sudo systemctl status nfs-lock
sudo systemctl start nfs-lock

sudo systemctl status nfs
sudo systemctl start nfs

$ cat /etc/exports
/app 172.16.238.10(rw) 172.16.238.11(rw) 172.16.238.12(rw)

$ exportfs

$ exportfs -r

$ chmod 777 /app



