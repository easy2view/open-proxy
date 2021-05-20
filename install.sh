#!/bin/bash
# auth : gfw-breaker

version=1.19.1
rpm -ihv http://installrepo.kaltura.org/releases/kaltura-release.noarch.rpm
yum install -y kaltura-nginx-$version

rm -fr /etc/nginx/conf.d/*
mkdir -p /usr/share/nginx/cache
mkdir -p /usr/share/nginx/html

source scripts/config

server_ip=$(/sbin/ifconfig eth0 | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)

if [ -z $server_ip ]; then
	server_ip=$(/sbin/ifconfig eth0 | grep "inet " | awk '{print $2}')
fi

if [ -z $data_server_ip ]; then
	data_server_ip=$server_ip
fi

if [ -z $local_server_ip ]; then
	local_server_ip=$server_ip
fi

cp common/* /etc/nginx/
cp pages/* /usr/share/nginx/html
cp sites/*.conf /etc/nginx/conf.d

for f in $(ls /usr/share/nginx/html/*.html); do
	sed -i "s/local_server_ip/$local_server_ip/g" $f
	sed -i "s/data_server_ip/$data_server_ip/g" $f
done


cat scripts/ports | grep -v "^$" | grep -v "^#" > ports.txt
for f in $(ls /etc/nginx/conf.d/*.conf); do
	sed -i "s/local_server_ip/$local_server_ip/g" $f
	sed -i "s/data_server_ip/$data_server_ip/g" $f
	while read line; do
		key=$(echo $line | cut -d'=' -f1)
		value=$(echo $line | cut -d'=' -f2)
		sed -i "s/$key/$value/g" $f
	done < ports.txt
done


# CentOS6
mv /etc/init.d/kaltura-nginx /etc/init.d/nginx
chkconfig nginx on

# CentOS7
mv /usr/lib/systemd/system/kaltura-nginx.service /usr/lib/systemd/system/nginx.service
systemctl enable nginx

service nginx restart

