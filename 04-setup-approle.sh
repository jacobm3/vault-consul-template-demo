echo "Enabling approle"
vault auth enable approle    \
    2>/dev/null

echo "Writing approle role"
vault write auth/approle/role/dvwa \
    policies="dvwa" \
    secret_id_ttl=24h \
    token_num_uses=5000 \
    token_ttl=4s \
    token_max_ttl=10s \
    secret_id_num_uses=5000

echo "Saving role-id and secret-id"
vault read -format=json auth/approle/role/dvwa/role-id | \
    jq -r .data.role_id > .role-id

vault write -format=json -f auth/approle/role/dvwa/secret-id | \
    jq -r .data.secret_id > .secret-id
