sudo netstat -ltnp

sudo vi /etc/mail/sendmail.mc
sudo systemctl status sendmail
sudo systemctl restart sendmail


sudo iptables -nvL
sudo iptables -I INPUT -p tcp -s 172.16.238.3 --dport 8084 -j ACCEPT
sudo iptables -nvL
sudo service iptables save