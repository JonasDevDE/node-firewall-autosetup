sudo ufw --force reset

sudo ufw default deny incoming
sudo ufw default deny outgoing

read -p "Please enter auth key: " AUTH_KEY
read -p "Please enter node ips url: " URL

RESPONSE=$(curl -s -H "Auth: $AUTH_KEY" $URL)

IFS=',' read -r -a IPS <<< "$RESPONSE"

for IP in "${IPS[@]}"; do
  IP=$(echo "$IP" | tr -d ' ')
  sudo ufw allow from $IP
  sudo ufw allow to $IP
done

sudo ufw enable

echo "Completed ufw configuration."
