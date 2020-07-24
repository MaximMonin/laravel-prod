# Create Production Image from latest file tar.gz file created by autobuild

FROM maximmonin/laravel-base

ADD image/laravel-prod-latest.tar.gz /app
WORKDIR /app

RUN echo "# Laravel scheduler" >> /etc/crontab \
 && echo "* * * * * root cd /app && php artisan schedule:run >> /dev/null 2>&1" >> /etc/crontab \
 && chown www-data:www-data -R bootstrap storage \
 && chmod -R a+rw bootstrap storage \
 && composer dump-autoload -o \
 && mkdir /app/storage/app/public \
 && php artisan storage:link \
 && php artisan view:cache

# no route and config optimization bacause some projects cannot work with this options
# see Laravel documentation
# && php artisan config:cache && php artisan route:cache
