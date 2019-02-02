##Create a WebHook for the Channel in your Discord Server Settings and fill in the URL
message="Pi-Hole Parser File updated"
msg_content=\"$message\"
## discord webhook
url='ENTER URL FROM DISCORD HERE'
URL=${URL%$'\r'}
curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
echo "* Message to Discord send. $timestamp" | tee --append $RECENTRUN &>/dev/null