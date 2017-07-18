# Clone
FROM php:7.1-cli
RUN apt-get update
RUN apt-get install -y git unzip
ARG BRANCH
RUN echo "On build la branche $BRANCH..."
RUN git clone https://github.com/jean-pasqualini/bridge-legacy-refonte -b $BRANCH /build
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	&& chmod +x /usr/local/bin/composer
WORKDIR /build/refonte
RUN COMPOSER_ALLOW_SUPERUSER=1 SYMFONY_ENV=prod composer install --prefer-dist --no-dev

# Init environment of execution
FROM php:7.1-fpm
RUN apt-get update
RUN apt-get install -y nginx supervisor

# Configure php
RUN docker-php-ext-install opcache \
	&& docker-php-ext-enable opcache
COPY php.ini /usr/local/etc/php/

# Copy supervisor config
COPY --from=0 /build/kubernetes/builder/refonte/supervisord.conf /etc/supervisord.conf
# Copy application
COPY --from=0 /build/refonte /app
# COPY nginx config
RUN cp /app/docker/default.conf /etc/nginx/sites-enabled/default
# Configure host-fpm
RUN sed -i -- 's/refonte-fpm/127.0.0.1/g' /etc/nginx/sites-enabled/default
# Configure host legacy
RUN sed -i -- 's|http://legacy|http://legacy.default.svc.cluster.local|g' /etc/nginx/sites-enabled/default
# Configure environment app
RUN sed -i -- 's/app_dev/app/g' /etc/nginx/sites-enabled/default
# Temporary apply writeable on logs
RUN chown -R 33:33 /app/var/logs
# Temporary apply writeable on sessions
RUN chown -R 33:33 /app/var/sessions
# Temporary apply writeable on cache
RUN chown -R 33:33 /app/var/cache

# Start
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]