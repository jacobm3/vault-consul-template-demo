echo "Writing dvwa policy"

vault policy write dvwa -<<EOF
path "database/creds/dvwa" {
  capabilities = ["read"]
}
EOF

