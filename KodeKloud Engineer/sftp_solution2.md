## Install and configure SFTP

* https://github.com/alfred-jayaprakash/kke-solutions
* https://github.com/alfred-jayaprakash/kke-solutions/blob/master/linux/Install-and-configure-SFTP.md
* https://www.nbtechsupport.co.in/2021/01/install-and-configure-sftp-kodekloud.html
* https://youtu.be/_-lTk4lflEE

## Solution
* SSH to the required host and add the user e.g.
```
sudo useradd mariyam -s /sbin/nologin
#sudo useradd mariyam -m
#sudo groupadd sftp_users
#sudo useradd mariyam -G sftp_users -s /sbin/nologin
```

* Set the password to the user as given in the questino e.g.

```
sudo passwd mariyam
8FmzjvFU6S
```

* Create the landing directory (chroot directory in the question) and make the new user the owner:

```
sudo mkdir -p /tmp/sftp/upload
sudo chown -R root:root /tmp/sftp
#sudo chown -R root:sftp_users /tmp/sftp
sudo chmod -R 755 /tmp/sftp
```

* Modify permissions to the parent folder i.e. /var/www to grant access and ownership to root user

```
#sudo chown root:root /var/www/
#sudo chmod 755 /var/www
```

* Now modify the`/etc/ssh/sshd_config` as follows to force SFTP-only for the newly created (Make sure not to duplicate `Subsystem sftp` in the file):

 ```
Subsystem       sftp    internal-sftp

Match User mariyam
        X11Forwarding no
        AllowTcpForwarding no
        PermitTTY no
        ForceCommand internal-sftp
        PasswordAuthentication yes
        ChrootDirectory /tmp/sftp
        PermitTunnel no
        AllowAgentForwarding no
 ```

* Restart sshd
```
systemctl restart sshd
```
 
## Verification
* Try to do a SSH to the host using the newly created user. e.g. `ssh mariyam@stapp03`. It should fail.
* Try to do a SFTP to the host using the newly created user. e.g. `sftp mariyam@stapp03`. It should succeed.

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)