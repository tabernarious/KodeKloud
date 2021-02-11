Before creating  the rule(s), do the following:
-------------------------------------

Login to backup server:
----------------------
ssh -l  clint  stbkp01  

sudo -i



1)install iptables:
--------------
yum install iptables\*  -y
Loaded plugins: fastestmirror
Determining fastest mirrors
epel/x86_64/metalink                                                          |  33 kB  00:00:00
 * base: centosmirror.netcup.net
 * epel: mirror.de.leaseweb.net
 * extras: mirror.checkdomain.de
 * updates: ftp.antilo.de
base                                                                          | 3.6 kB  00:00:00
epel                                                                          | 4.7 kB  00:00:00
extras                                                                        | 2.9 kB  00:00:00
updates                                                                       | 2.9 kB  00:00:00
(1/7): base/7/x86_64/group_gz                                                 | 153 kB  00:00:00
(2/7): extras/7/x86_64/primary_db                                             | 222 kB  00:00:00
(3/7): epel/x86_64/updateinfo                                                 | 1.0 MB  00:00:00
(4/7): epel/x86_64/group_gz                                                   |  95 kB  00:00:00
(5/7): base/7/x86_64/primary_db                                               | 6.1 MB  00:00:00
(6/7): updates/7/x86_64/primary_db                                            | 4.7 MB  00:00:00
(7/7): epel/x86_64/primary_db                                                 | 6.9 MB  00:00:00
Resolving Dependencies
--> Running transaction check
---> Package iptables.x86_64 0:1.4.21-24.1.el7_5 will be updated
---> Package iptables.x86_64 0:1.4.21-35.el7 will be an update
---> Package iptables-devel.x86_64 0:1.4.21-35.el7 will be installed
---> Package iptables-services.x86_64 0:1.4.21-35.el7 will be installed
---> Package iptables-utils.x86_64 0:1.4.21-35.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

==========================================================================================================
 Package                     Arch                 Version               Repository                 Size
==========================================================================================================
Installing:
 iptables-devel              x86_64            1.4.21-35.el7              base                       57 k
 iptables-services           x86_64            1.4.21-35.el7              base                       52 k
 iptables-utils              x86_64            1.4.21-35.el7              base                       62 k
Updating:
 iptables                    x86_64            1.4.21-35.el7              base                      432 k

Transaction Summary
===========================================================================================================
Install  3 Packages
Upgrade  1 Package

Total download size: 603 k
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/4): iptables-1.4.21-35.el7.x86_64.rpm                                     | 432 kB  00:00:00
(2/4): iptables-services-1.4.21-35.el7.x86_64.rpm                            |  52 kB  00:00:00
(3/4): iptables-utils-1.4.21-35.el7.x86_64.rpm                               |  62 kB  00:00:00
(4/4): iptables-devel-1.4.21-35.el7.x86_64.rpm                               |  57 kB  00:00:00
-------------------------------------------------------------------------------------------------
Total                                                                                                     2.5 MB/s | 603 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : iptables-1.4.21-35.el7.x86_64                            1/5
  Installing : iptables-devel-1.4.21-35.el7.x86_64                      2/5
  Installing : iptables-utils-1.4.21-35.el7.x86_64                      3/5
  Installing : iptables-services-1.4.21-35.el7.x86_64                   4/5
  Cleanup    : iptables-1.4.21-24.1.el7_5.x86_64                        5/5
  Verifying  : iptables-devel-1.4.21-35.el7.x86_64                      1/5
  Verifying  : iptables-utils-1.4.21-35.el7.x86_64                      2/5
  Verifying  : iptables-1.4.21-35.el7.x86_64                            3/5
  Verifying  : iptables-services-1.4.21-35.el7.x86_64                   4/5
  Verifying  : iptables-1.4.21-24.1.el7_5.x86_64                        5/5

Installed:
  iptables-devel.x86_64 0:1.4.21-35.el7       iptables-services.x86_64 0:1.4.21-35.el7       iptables-utils.x86_64 0:1.4.21-35.el7

Updated:
  iptables.x86_64 0:1.4.21-35.el7

Complete!


2) enable & start iptables:
--------------------
systemctl enable --now  iptables

Created symlink from /etc/systemd/system/basic.target.wants/iptables.service to /usr/lib/systemd/system/iptables.service



check iptables status:
-----------------
systemctl  status  iptables
● iptables.service - IPv4 firewall with iptables
   Loaded: loaded (/usr/lib/systemd/system/iptables.service; enabled; vendor preset: disabled)
   Active: active (exited) since Mon 2021-01-11 20:48:24 UTC; 7min ago
  Process: 1448 ExecStart=/usr/libexec/iptables/iptables.init start (code=exited, status=0/SUCCESS)
 Main PID: 1448 (code=exited, status=0/SUCCESS)

Jan 11 20:48:24 08673d66ce67 systemd[1]: Starting IPv4 firewall with iptables...
Jan 11 20:48:24 08673d66ce67 iptables.init[1448]: iptables: Applying firewall rules: [  OK  ]
Jan 11 20:48:24 08673d66ce67 systemd[1]: Started IPv4 firewall with iptables.

Allow all incoming traffic to Nginx 8091 port and Block to Apache 8082 port:
----------------------------------------------------------------

Add these two rules:

sudo iptables -I INPUT -p tcp --dport 8091 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT        

sudo iptables -A INPUT -p tcp --dport 8082 -m conntrack --ctstate NEW -j REJECT                

Then save it by typing following command:    
------------------------------------                            
sudo iptables-save > /etc/sysconfig/iptables

Now, check if the rules are added or not:
----------------------------------                                
cat /etc/sysconfig/iptables         


# Generated by iptables-save v1.4.21 on Mon Jan 11 21:16:46 2021
*nat
:PREROUTING ACCEPT [514:60896]
:INPUT ACCEPT [514:60896]
:OUTPUT ACCEPT [377:25054]
:POSTROUTING ACCEPT [377:25054]
:DOCKER - [0:0]
-A PREROUTING -m addrtype --dst-type LOCAL -j DOCKER
-A OUTPUT ! -d 127.0.0.0/8 -m addrtype --dst-type LOCAL -j DOCKER
-A POSTROUTING -s 172.20.0.0/16 ! -o docker0 -j MASQUERADE
-A DOCKER -i docker0 -j RETURN
COMMIT
# Completed on Mon Jan 11 21:16:46 2021
# Generated by iptables-save v1.4.21 on Mon Jan 11 21:16:46 2021
*filter
:INPUT ACCEPT [68:11210]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [57:10270]
:DOCKER - [0:0]
:DOCKER-ISOLATION - [0:0]
-A INPUT -p tcp -m tcp --dport 8091 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -m tcp --dport 8082 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -j DOCKER-ISOLATION
-A FORWARD -o docker0 -j DOCKER
-A FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i docker0 ! -o docker0 -j ACCEPT
-A FORWARD -i docker0 -o docker0 -j ACCEPT
-A DOCKER-ISOLATION -j RETURN
COMMIT
# Completed on Mon Jan 11 21:16:46 2021