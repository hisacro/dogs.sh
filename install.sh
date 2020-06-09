#!/bin/bash

# Update and Install Packages
# ---------------------------
sudo apt update
sudo apt upgrade -y
sudo apt install apache2 php libapache2-mod-php apache2-utils libapache2-mod-evasive -y
sudo apt install unattended-upgrades apt-listchanges -y 
sudo apt install jp2a -y
sudo apt autoremove -y

# Set up .htaccess
# ----------------
echo 'Options -Indexes' > /var/www/html/.htaccess
echo 'FallbackResource /index.php' >>  /var/www/html/.htaccess
echo 'ErrorDocument 403 /error' >> /var/www/html/.htaccess
rm -f /var/www/html/index.html

# Download the Dog Image Dataset
# ------------------------------
mkdir /var/www/images
mkdir /var/www/images-download
wget http://vision.stanford.edu/aditya86/ImageNetDogs/images.tar -O /var/www/images-download/images.tar
tar -xvf /var/www/images-download/images.tar -C /var/www/
rm -rf /var/www/images-download/

# Remove Images that are blurred on default terminal
# --------------------------------------------------
wget https://raw.githubusercontent.com/fortwire/dogs.sh/master/del-img.txt -O del-img.txt
for x in $(cat del-img.txt);
    do
        echo "Deleting "$x;
        rm -f "/var/www/Images/$x";
    done;
   
# Remove Images that don't fit into terminal
imageList=$(find /var/www/Images/* -maxdepth 1 -not -type d)
imageCount=$(find /var/www/Images/* -maxdepth 1 -not -type d | wc -l)
count=1
for x in $(echo $imageList);
    do
        jp2a $x --background=light --color --color-depth=24 --fill --height=23 --output=test -v 2> log;
        width=$(cat log | grep "Output width" | cut -d" " -f3);
        echo "Checking - "$count"/"$imageCount" - Width: "$width;
        count=$((count+1))
        if [[ $width -gt 80 ]]; then echo "Deleting - "$x && rm -f $x; fi
    done;
    
# Convert Images to ASCII in multiple sizes
mkdir /var/www/images-formatted
sizes=(14 23 36 54 65) # xs, s, m, l, xl
for x in ${sizes[@]}; do mkdir /var/www/images-formatted/$x; done
imageList=$(find /var/www/Images/* -maxdepth 1 -not -type d)
imageCount=$(find /var/www/Images/* -maxdepth 1 -not -type d | wc -l)
for x in ${sizes[@]};
    do
        count=1
        for y in $(echo $imageList);
            do
                echo $y;
                jp2a $y --background=light --color --color-depth=24 --fill --height=$x --output=/var/www/images-formatted/$x/$count;
                echo $x"-"$count"/"$imageCount;
                count=$((count+1));
            done;
    done;
rm -rf /var/www/Images/
mv /var/www/images-formatted /var/www/Images
rm -f /var/www/index.html

# Import index.php
wget https://github.com/fortwire/dogs.sh/raw/master/index.php -O /var/www/html/index.php
sed -i '2s/.*/$IMG_COUNT='$imageCount';/' /var/www/html/index.php
echo "Too many requests... Please wait a moment..." > /var/www/html/error
chown -R www-data:www-data /var/www

# Setup basic DoS Protection
mkdir /var/log/mod_evasive
chown -R www-data:www-data /var/log/mod_evasive
echo "<IfModule mod_evasive20.c>" > /etc/apache2/mods-enabled/evasive.conf
echo "DOSHashTableSize    3097" >> /etc/apache2/mods-enabled/evasive.conf
echo "DOSPageCount        5" >> /etc/apache2/mods-enabled/evasive.conf
echo "DOSSiteCount        5" >> /etc/apache2/mods-enabled/evasive.conf
echo "DOSPageInterval     10" >> /etc/apache2/mods-enabled/evasive.conf
echo "DOSSiteInterval     10" >> /etc/apache2/mods-enabled/evasive.conf
echo "DOSBlockingPeriod   5" >> /etc/apache2/mods-enabled/evasive.conf
echo "DOSLogDir           /var/log/mod_evasive" >> /etc/apache2/mods-enabled/evasive.conf
echo "</IfModule>" >> /etc/apache2/mods-enabled/evasive.conf
sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
systemctl restart apache2

# Install Fail2Ban
apt install fail2ban -y
systemctl start fail2ban
systemctl enable fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.d/defaults-debian.conf
systemctl restart fail2ban

# Firewall
sudo apt install ufw
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
sudo ufw status
