pkill vault
sleep 0.2

nohup vault server -dev  \
    >log/vault.log 2>log/vault.err &

sleep 0.5

#egrep 'Root Token:' log/vault.log | cut -f3 -d' ' > .root-token

vault login `egrep 'Root Token:' log/vault.log | cut -f3 -d' '`

vault audit enable file file_path=/home/jacob/environments/dev/log/audit

