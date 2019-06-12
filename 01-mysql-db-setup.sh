echo "Setting up vault's grant in mysql"

passwd=`openssl rand -base64 12 | base32 | cut -b -24`
echo $passwd > .mysql-vault-passwd

sudo mysql -uroot <<EOF
DROP DATABASE IF EXISTS dvwa;
CREATE DATABASE dvwa;
GRANT ALL ON *.* to 'vault'@'localhost' IDENTIFIED BY "$passwd";
GRANT GRANT OPTION ON *.* to 'vault'@'localhost';
FLUSH PRIVILEGES;
EOF
