FROM gnkz/php7.1-cli-alpine:0.1.1

ENV COMPOSER_VERSION 1.4.2

RUN apk --no-cache add git && \
	mkdir -p /tmp/composer && \
	cd /tmp/composer && \
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php --version=$COMPOSER_VERSION && \
	php -r "unlink('composer-setup.php');" && \
	mv composer.phar /usr/bin/composer

ENTRYPOINT ["/usr/bin/entry", "/usr/bin/composer"]

CMD ["--help"]
