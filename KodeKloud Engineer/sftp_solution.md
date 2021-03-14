# SFTP Solution

create ChrootDirectory:
```
mkdir -p /var/www/nfsshare
chmod 755  /var/www/nfsshare
```

create sftp_users  group:
```
groupadd sftp_users
```

create  user 'yousuf':
```
useradd -g sftp_users -d /upload -s /sbin/nologin yousuf
passwd yousuf
```

set permission(s) & ownership:
```
chown -R root:sftp_users    /var/www/nfsshare/yousuf
chown -R yousuf:sftp_users  /var/www/nfsshare/yousuf/upload
```

configure  sshd_config:
```
vi /etc/ssh/sshd_config
```

Add these lines below,  if it doesn't exist:
```
Match Group  sftp_users
ChrootDirectory /var/www/nfsshare/%u
ForceCommand internal-sftp
```

save &  exit

restart sshd  service:
```
systemctl restart  sshd
```