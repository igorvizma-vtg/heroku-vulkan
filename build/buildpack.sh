# Compiling Apache

mkdir -p /tmp/build
cd /tmp

curl -O http://apache.ip-connect.vn.ua/httpd/httpd-2.2.24.tar.gz
tar xvzf httpd-2.2.24.tar.gz
cd httpd-2.2.24
./configure --prefix=/tmp/apache --enable-rewrite --enable-so --enable-deflate --enable-expires --enable-headers
make
make install
cd ..



# Apache libraries
mkdir -p /tmp/php/ext
cp /usr/lib/libapr-1.so /tmp/php/ext
cp /usr/lib/libaprutil-1.so /tmp/php/ext
cp /usr/lib/libapr-1.so.0 /tmp/php/ext
cp /usr/lib/libaprutil-1.so.0 /tmp/php/ext

# Compiling PHP
curl -O http://us.php.net/get/php-5.4.11.tar.gz/from/us.php.net/mirror
#mv mirror php-5.4.11.tar.gz
tar xzvf php-5.4.11.tar.gz
cd php-5.4.11/
./configure --prefix=/tmp/php --with-apxs2=/tmp/apache/bin/apxs --with-mysql --with-pdo-mysql --with-pgsql --with-pdo-pgsql --with-iconv --with-gd --with-config-file-path=/tmp/php --enable-soap=shared --with-openssl --enable-mbstring --with-iconv --enable-zip --enable-libxml
make
make install
cd ..

# PHP Extensions
cp php-5.4.11/libs/libphp5.so /tmp/apache/modules/
cp /usr/lib/libmysqlclient.so /tmp/php/ext/
cp /usr/lib/libmysqlclient.so.18 /tmp/php/ext/
cp /usr/lib/libmcrypt.so /tmp/php/ext/
cp /usr/lib/libmcrypt.so.4 /tmp/php/ext/
curl -O http://pecl.php.net/get/APC
tar -zxvf APC
cd APC-3.1.13
/tmp/php/bin/phpize
./configure --enable-apc --enable-apc-mmap --with-php-config=/tmp/php/bin/php-config
make
make install


mkdir -p /tmp/build

cp -a /tmp/apache /tmp/build/
cp -a /tmp/php /tmp/build/

rm -rf /tmp/build/apache/manual/



# Create packages
#cd /tmp
#echo '2.2.24' > apache/VERSION
#tar -zcvf apache.tar.gz apache
#echo '5.4.11' > php/VERSION
#tar -zcvf php.tar.gz php