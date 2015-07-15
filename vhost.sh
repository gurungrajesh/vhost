#!/bin/bash
# vhost.sh -- create virtual host of site

# Site with <sitename> will be created as sitename.gailabs.com
# Usage: vhost.sh <site-name>

# root_dir = "/var/www/"
#apache_default_file="/etc/apache2/sites-available/default"
#ap_sites_available="/etc/apache2/sites-available/"
root_dir="/tmp/test/"
apache_default_file="/etc/apache2/sites-available/default"
ap_sites_available="sites-available/"
host_file="hosts/host.txt"
host_ip="192.168.1.20"
access="access.log"
error="error.log"

#E=$(echo 192.168.1.10 $site_name >> /etc/hosts)
#echo Please Enter Website Name
    #if [ $(id -u) != 0 ]  TESTING
#    if [ $(id -u) == 0 ]
 #   then 
#	echo "Please Be root user to run this script" 
#	exit 1
 #   fi

    echo User Is root and going to next step
    read -p "WebsiteNAme in this order 'Sitename.gailabs.com':" site_name
    echo $site_name

    echo Adding sitename in host file
    # E=$(echo $host_ip $site_name >> $host_file)
    echo $host_ip $site_name >> $root_dir$host_file 
echo "$root_dir$host_file" 

    A=$(basename "$site_name" .gailabs.com)
    echo Basename: $A
    echo
    echo
    echo
    echo Making Site Directory
echo
echo
echo
   mkdir -p $root_dir$A
    echo  
    echo "Copying SiteName in $ap_sites_available "
echo
echo
echo

    #F=$(cp $apache_default_file $ap_sites_available$site_name.conf)
echo "Creating $site_name.conf file"
echo
echo
echo
 touch $ap_sites_available$site_name.conf
    #echo $F 

    if [ $? -eq 0 ]
    then 
	echo File Created Successfully
    else
	echo Failed to create file 
    fi
cat <<apache_default >> $root_dir$ap_sites_available$site_name.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost

   # -- nk. Name and alias added
    ServerName $site_name
   # ServerAlias localhost localhost.localdomain

    DocumentRoot $root_dir$A
    <Directory />
        Options FollowSymLinks
        AllowOverride None
    </Directory>
    <Directory $root_dir$A>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All 
        Order allow,deny
        allow from all
    </Directory>

    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
    <Directory "/usr/lib/cgi-bin">
        AllowOverride None
        Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
        Order allow,deny
        Allow from all
    </Directory>

    ErrorLog $root_dir$error

    # Possible values include: debug, info, notice, warn, error, crit,
    # alert, emerg.
    LogLevel warn

    CustomLog $root_dir$access combined

    Alias /doc/ "/usr/share/doc/"
    <Directory "/usr/share/doc/">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.0/255.0.0.0 ::1/128
    </Directory>

</VirtualHost>

apache_default
#Enabling Site

#G="/etc/apache2/sites-available/$F"
    #echo ap_sites_available=
    #echo
    #echo Enabling Site
    #echo
    #a2ensite $site_name.conf
    #echo
    #echo
    #echo Restarting Apache 
    #echo 
    #echo 
    #H=$(service apache2 restart)
    #echo-- -- -- --SITE IS UP-- -- -- -- -
#-------Database ------------

MYSQL_DB="CREATE DATABASE IF NOT EXISTS $A;"
MYSQL_PER="GRANT ALL ON $A.* TO 'root'@'localhost' IDENTIFIED BY 'admin123';"
MYSQL_FLUSH="FLUSH PRIVILIGES;"
MYSQL_RUN="${MYSQL_DB}${MYSQL_PER}${MYSQL_FLUSH}"
echo
#read -p "DatabaseName:" dbname
echo CREATING DATABASE
mysql -uroot -padmin123 -e "$MYSQL_RUN"


