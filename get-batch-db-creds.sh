. .clear-token

for x in `seq 1 16`; do
  vault login `cat token-sink` >/dev/null
  vault read database/creds/dvwa  | egrep 'username|passw'
  sleep 0.2
done
