# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Installation

- Detailed instructions for installing the software/application.
- Prerequisites, dependencies, and installation scripts.

### OpenPlato

**Basic requirements**
- working webserver (Apache or Nginx) [in our case Apache]

      apt install apache2 apache2-bin apache2-data apache2-utils libapache2-mod-php7.4 

- PHP and extensions for Moodle [in our case 7.4]

      apt install php7.4-json php7.4-intl php7.4-gd php7.4-zip php7.4-soap php7.4-xmlrpc php-tokenizer php7.4-curl php7.4-mbstring php7.4-xml php7.4-xml php7.4-imap php7.4-mysql php7.4-opcache php7.4-readline 

- Database ( MySQL, MariaDB or PostgreSQL) [in our case MySQL 8.0

       apt install mysql-server

- Enable apache modules:

      a2enmod autoindex info status expires imap include userdir cgi access_compat deflate php7.4 

- Enable php modules:

      imap.ini gd.ini mbstring.ini xmlrpc.ini xsl.ini xmlwriter.ini xmlreader.ini 15-xml.ini simplexml.ini dom.ini soap.ini zip.ini intl.ini curl.ini pdo_mysql.ini mysqli.ini 10-mysqlnd.ini json.ini 10-opcache.ini readline.ini tokenizer.ini sysvshm.ini sysvsem.ini sysvmsg.ini sockets.ini shmop.ini posix.ini phar.ini 10-pdo.ini iconv.ini gettext.ini ftp.ini ffi.ini fileinfo.ini exif.ini ctype.ini calendar.ini

Prepare directories for moodle:

    mkdir -p /srv/www/moodle
    mkdir /srv/www/php_tmp


**Create database** 

Using your chosen database server, create a new empty database. The default encoding must be UTF8. For example, using MySQL:

    mysql> CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    mysql> GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO 'moodleuser'@'localhost' IDENTIFIED BY 'yourpassword';
    mysql> CREATE USER 'moodleuser'@'localhost' IDENTIFIED BY 'yourpassword';
    mysql> GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO 'moodleuser'@'localhost';
    mysql> FLUSH PRIVILEGES;

Create an empty directory to hold Moodle data files. It must not be in the area served by the web server and must have permissions so that the web server user can write to it. 

    mkdir /srv/www/moodledata
    chown -R www-data:www-data /srv/www/moodledata


Create moodle program files directory

    mkdir -p /srv/www/moodle

Download moodle version using git:

    cd /srv/www/moodle
    git clone -b MOODLE_311_STABLE git://git.moodle.org/moodle.git  . 
    chown -R root:root /srv/www/moodle

In the Moodle code directory, find the file config-dist.php and copy it to a new file called config.php.
Edit config.php with your favourite editor and change the appropriate settings to point to your site, directories and database.

Go to the URL for your moodle site in a browser (installation will complete automatically).

After completing the install make sure your file permissions are ok for the Moodle program files (not writeable by web server) and the Moodle data files (writeable by web server).

Add cron job to run periodically.

    crontab -e

    */5 * * * * php /srv/www/moodle/admin/cli/cron.php 2>&1
