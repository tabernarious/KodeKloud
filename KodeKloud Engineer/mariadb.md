# MariaDB

https://linuxize.com/post/install-mariadb-on-centos-7/

## Copy db backup to stdb01
```
cd ~
sftp peter@stdb01
put db.sql
```

## Install and start mariadb
```
sudo yum install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl status mariadb

mysql --version
```

## Configuration

* mysql_root_pass: oosk_flai4SITH.gem
* database_name:   kodekloud_db9
* database_user:   kodekloud_sam
* mysql_user_pass: mant2UFF-floo7woor

## Configure mariadb
```
sudo mysql_secure_installation

#sudu su -
sudo mysql -u root -p

#CREATE DATABASE database_name;
#CREATE DATABASE kodekloud_db9;
#CREATE DATABASE IF NOT EXISTS database_name;
CREATE DATABASE IF NOT EXISTS kodekloud_db9;
SHOW DATABASES;

#DROP DATABASE IF EXISTS database_name;

#CREATE USER IF NOT EXISTS 'database_user'@'localhost' IDENTIFIED BY 'user_password';
CREATE USER IF NOT EXISTS 'kodekloud_sam'@'localhost' IDENTIFIED BY 'mant2UFF-floo7woor';
SELECT user, host FROM mysql.user;

#RENAME USER 'database_user'@'localhost' TO 'database_user'@'1.2.3.4';
RENAME USER 'kodekloud_sam'@'localhost' TO 'kodekloud_sam'@'%';
SELECT user, host FROM mysql.user;


#DROP USER IF EXISTS 'database_user@'localhost';

#GRANT ALL PRIVILEGES ON database_name.* TO 'database_user'@'localhost';
#GRANT ALL PRIVILEGES ON *.* TO 'database_user'@'localhost';
#GRANT ALL PRIVILEGES ON database_name.table_name TO 'database_user'@'localhost';
#GRANT SELECT, INSERT, DELETE ON database_name.* TO database_user@'localhost';
GRANT ALL PRIVILEGES ON kodekloud_db9.* TO 'kodekloud_sam'@'localhost';

#REVOKE ALL PRIVILEGES ON database_name.* TO 'database_user'@'localhost';
#SHOW GRANTS FOR 'database_user'@'localhost';
SHOW GRANTS FOR 'kodekloud_sam'@'localhost';
SHOW GRANTS FOR 'kodekloud_sam'@'%';

```

## Restore database
```
#mysqldump -u root -p database_name > database_name.sql
#mysqldump -u root -p --databases database_name_a database_name_b > databases_a_b.sql
#mysqldump -u root -p --all-databases > all_databases.sql

#mysql  database_name < file.sql
#mysql -u root -p database_name < database_name.sql
#mysql --one-database database_name < all_databases.sql
sudo mysql -u root -p kodekloud_db9 < /home/peter/db.sql

```

## Configure WordPress 

```
ssh natasha@ststor01
sudo vi /data/wp-config.php
```

```
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'kodekloud_db9' );

/** MySQL database username */
define( 'DB_USER', 'kodekloud_sam' );

/** MySQL database password */
define( 'DB_PASSWORD', 'mant2UFF-floo7woor' );

/** MySQL hostname */
define( 'DB_HOST', 'stdb01' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );
```