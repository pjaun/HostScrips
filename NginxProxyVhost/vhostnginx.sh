#!/bin/bash

domain=$1
ip=$2

sitesEnabled='/etc/nginx/sites-enabled/'

while [ "$domain" == "" ]
do
        echo -e $"Please provide domain. e.g.dev,staging"
        read domain
done

while [ "$ip" == "" ]
do
        echo -e $"Please provide ip. e.g. 10.110.14.61"
        read ip
done

sitesitesAvailabledomain=$sitesEnabled$domain.conf

if ! echo "
server {
        listen 80;
        server_name $domain;
        location / {
                proxy_set_header Host \$http_host;
                proxy_set_header X-Real-IP \$remote_addr;
                proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                proxy_pass http://$ip;
        }
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/nginx/ssl/science_cmu_ac_th_pack.crt; #Load ssl certificate and ca root
    ssl_certificate_key /etc/nginx/ssl/science_cmu_ac_th.key; #load private key
}
server {
    if (\$host = $domain) {
        return 301 https://\$host\$request_uri;
    } # managed by ssl


        listen 80;
        server_name $domain;
    return 404; # managed by ssl

}" > $sitesitesAvailabledomain
then
        echo -e $"There is an ERROR creating $domain file"
                exit;
else
        echo -e $"\nNew Virtual Host Created\n"
fi

service nginx reload
