# firewalld
* https://www.linode.com/docs/guides/introduction-to-firewalld-on-centos/

## Setup Commands
```
sudo yum install -y firewalld

grep '^\s\s*listen' /etc/nginx/nginx.conf
grep '^Listen' /etc/httpd/conf/httpd.conf

sudo systemctl status httpd
sudo systemctl status nginx

sudo systemctl enable httpd
sudo systemctl enable nginx

sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo systemctl status firewalld
sudo firewall-cmd --state


sudo firewall-cmd --zone=public --add-port=8095/tcp --permanent
sudo firewall-cmd --zone=public --add-rich-rule 'rule family=ipv4 source address=172.16.238.14 port port=5004 protocol=tcp accept' --permanent

#sudo firewall-cmd --zone=public --add-service=http --permanent
#sudo firewall-cmd --zone=public --add-rich-rule 'rule family="ipv4" source address="192.0.2.0" port port=22 protocol=tcp reject'

sudo firewall-cmd --reload

sudo firewall-cmd --zone=public --list-all
```

## Test Commands
These should work from `stlb01` and `thor` (jumphost)
```
curl http://stapp01:8095/index.html
curl http://stapp02:8095/index.html
curl http://stapp03:8095/index.html
curl http://stapp01:5004/
curl http://stapp02:5004/
curl http://stapp03:5004/
```

These should not work from `thor` (jumphost)
```
curl http://stapp01:5004/
curl http://stapp02:5004/
curl http://stapp03:5004/
```