FROM centos:centos7

MAINTAINER Alberto Galimberti

#Prerequisites
RUN yum install gcc gcc-c++ kernel-devel libxml2-devel libxslt-devel openssl-devel libcurl-devel libicu-devel readline-devel bzip2-devel tar wget make autoconf -y

# Download PHP and extract
RUN wget -nv -O - http://uk1.php.net/distributions/php-5.6.10.tar.gz | tar zx

WORKDIR php-5.6.10

RUN rm configure

RUN ./buildconf --force

RUN ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc/ --disable-cgi --without-pear --without-sqlite3 --with-zlib --without-pdo-sqlite --with-curl=/usr/bin/curl --with-openssl --libdir=/usr/lib64 --with-libdir=lib64 --enable-opcache --enable-fileinfo --enable-mbstring --with-readline --enable-fpm --enable-intl --enable-zip --with-pdo-mysql --with-mysqli --enable-pcntl

RUN make
RUN make install
RUN make test

RUN useradd fpm

RUN ln -s /usr/local/php/bin/* /usr/local/bin
WORKDIR /tmp

# XDEBUG
RUN wget -nv -O - http://xdebug.org/files/xdebug-2.3.1.tgz | tar zx
WORKDIR xdebug-2.3.1
RUN phpize
RUN ./configure
RUN make -j
RUN make install

WORKDIR /tmp

# XDEBUG
RUN wget -nv -O - http://pecl.php.net/get/redis-2.2.7.tgz | tar zx
WORKDIR redis-2.2.7
RUN phpize
RUN ./configure
RUN make -j
RUN make install

WORKDIR /tmp

# COMPOSER
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

WORKDIR /var/www

# Xhprof
RUN wget -nv -O - http://pecl.php.net/get/xhprof-0.9.4.tgz | tar zx
RUN mv xhprof-0.9.4 xhprof
WORKDIR xhprof/extension
RUN phpize
RUN ./configure
RUN make -j
RUN make install

WORKDIR /var/www

# Igbinary
RUN wget -nv -O - http://pecl.php.net/get/igbinary-1.2.1.tgz | tar zx
RUN mv igbinary-1.2.1 igbinary
WORKDIR igbinary
RUN phpize
RUN ./configure
RUN make -j
RUN make install

# PHPUnit
RUN wget https://phar.phpunit.de/phpunit.phar
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit

WORKDIR /var/www

WORKDIR /
VOLUME ["/usr/local/php/etc"]
ENTRYPOINT ["/usr/local/php/sbin/php-fpm"]
CMD ["-F"]