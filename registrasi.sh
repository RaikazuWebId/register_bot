#!/bin/bash
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
#color
grenbo="\e[92;1m"
NC='\e[0m'
#install
cd /root
rm -rf regis
#install
apt update && apt upgrade
apt install python3 python3-pip git
wget https://github.com/RaikazuWebId/register_bot/raw/refs/heads/main/regis.zip
unzip regis.zip
rm -rf regis.zip
pip3 install -r regis/requirements.txt
pip3 install pillow

#isi data
echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          ADD BOT PANEL          \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo
echo
read -e -p "[*] Input your Bot Token : " bottoken
echo
echo
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/regis/var.txt
echo -e ADMIN='"'$admin'"' >> /root/regis/var.txt
echo -e DOMAIN='"'$domain'"' >> /root/regis/var.txt
echo -e PUB='"'$PUB'"' >> /root/regis/var.txt
echo -e HOST='"'$NS'"' >> /root/regis/var.txt
clear

cat > /etc/systemd/system/regis.service << END
[Unit]
Description=Simple register - @RAIKAZUSTORE
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/python3 -m regis
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start regis 
systemctl enable regis
cd /root
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Token Bot      : $bottoken"
echo "Admin          : $admin"
echo "Domain         : $domain"
echo -e "==============================="
echo "Setting done"
clear
echo
echo
echo
echo " Installations complete, type /menu /sayang .hencet  on your bot"
