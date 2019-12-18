FROM php:7.4-cli-alpine

			
WORKDIR /var/www/html
COPY src .;
RUN ls
CMD [ "php -v", "/bin/sh" ]