echo hello
cat << EOF > ssrpanel
* * * * * /usr/local/bin/php /var/www/artisan schedule:run >> /var/log/cron.log 2>&1
* * * * * echo "Hello" >> /var/log/cron.log 2>&1
EOF
chmod 0644 ssrpanel
crontab ssrpanel
php composer.phar install
php artisan key:generate
chmod -R 755 storage/

cron start&& php-fpm -R -c /usr/local/etc/php/php.ini -y /usr/local/etc/php-fpm.conf
