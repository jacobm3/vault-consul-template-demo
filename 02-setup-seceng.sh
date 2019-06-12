echo "Enabling database secrets engine"
vault secrets enable database

echo "Writing DVWA DB secrets engine config"
mysqlpass=`cat .mysql-vault-passwd`
vault write database/config/dvwa \
    plugin_name=mysql-database-plugin \
    connection_url="{{username}}:{{password}}@tcp(127.0.0.1:3306)/" \
    allowed_roles="dvwa" \
    username="vault" \
    password="$mysqlpass"

echo "Writing DVWA engine role" 
vault write database/roles/dvwa \
    db_name=dvwa \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL ON dvwa.* TO '{{name}}'@'%';" \
    default_ttl="10s" \
    max_ttl="20s"

