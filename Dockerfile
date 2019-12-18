FROM php:7.4-cli-alpine

ENV PHPIZE_DEPS="libstdc++ php7-mbstring php7-gd openssl-dev"

RUN echo "依赖安装"; \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
	apk update; \
	apk add --update --no-cache $PHPIZE_DEPS ; \
	apk add --update --no-cache --virtual .build-deps autoconf gcc g++ make libzip-dev; \
	apk del --purge *-dev; \
	docker-php-ext-install iconv mysqli pdo pdo_mysql zip; \
	pecl install swoole; \
	echo "extension=swoole.so" >> /usr/local/etc/php/php.ini; \
	php --ri swoole; \
	# 清理
	apk del .build-deps; \
	rm -rf /var/cache/apk/*; \
	rm -rf /root/.cache; \
	rm -rf /tmp/*

			
WORKDIR /var/www/html
COPY src .
CMD [ "php -v", "/bin/sh" ]
