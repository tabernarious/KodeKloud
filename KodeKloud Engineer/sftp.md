# SFTP Setup

https://www.vultr.com/docs/setup-sftp-only-user-accounts-on-centos-7

```
sudo mkdir -p /var/www/data
sudo chmod 701 /var/www/data

#groupadd sftpusers
#useradd -g sftpusers -s /sbin/nologin yousuf
useradd -s /sbin/nologin yousuf

sudo chown yousuf:yousuf /var/www/data
```

```
sudo vi /etc/ssh/sshd_config
```
Add this at the end of the file
```
Match User yousuf
        ChrootDirectory /var/www/data
        X11Forwarding no
        AllowTcpForwarding no
        ForceCommand internal-sftp
```
```
sudo systemctl restart sshd
sudo systemctl status sshd
```

sudo chown yousuf:yousuf /var/www/data