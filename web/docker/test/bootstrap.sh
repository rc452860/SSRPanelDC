echo hello
cat << EOF > ssrpanel
* * * * * php ${APACHE_DOCUMENT_ROOT}/SSRPanel/artisan schedule:run >> /dev/null 2>&1
EOF
chmod 0644 ssrpanel
crontab SSRPanel
ls
pwd
php composer.phar install
php artisan key:generate
chmod -R 755 storage/

crond && php-fpm