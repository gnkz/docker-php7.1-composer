FROM gnkz/php7.1-cli-alpine:0.1.4

ENV COMPOSER_VERSION 1.5.2

RUN apk --no-cache add git && \
	mkdir -p /tmp/composer && \
	cd /tmp/composer && \
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php --version=$COMPOSER_VERSION && \
	php -r "unlink('composer-setup.php');" && \
	mv composer.phar /usr/bin/composer

ENTRYPOINT ["/usr/bin/entry", "/usr/bin/composer"]

CMD ["--help"]
