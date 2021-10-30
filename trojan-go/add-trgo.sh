#!/bin/bash

grey='\x1b[90m'
red='\x1b[91m'
green='\x1b[92m'
yellow='\x1b[93m'
blue='\x1b[94m'
purple='\x1b[95m'
cyan='\x1b[96m'
white='\x1b[37m'
bold='\033[1m'
off='\x1b[m'
flag='\x1b[47;41m'
NC='\x1b[m'
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
COUNTRY=$(curl -s ipinfo.io/country )

MYIP=$(wget -qO- ipinfo.io/ip);
clear
uuid=$(cat /etc/trojan-go/uuid.txt)
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
trgo="$(cat ~/log-install.txt | grep -w "TrojanGO" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXIST} && ${user_EXISTS} == '0' ]]; do
		read -rp "Masukan Key : " keyy
        read -rp "Remarks : " -e user
		user_EXIST=$(grep -w $user /etc/trojan-go/akun.conf | wc -l)
        user_EXISTS=$(grep -w $user /etc/trojan/akun.conf | wc -l)
		if [[ ${user_EXIST} == "1" ]] || [[ ${user_EXISTS}  == '1' ]]; then
			echo ""
			echo "Nama User Sudah Ada, Harap Masukkan Nama Lain!"
			exit 1
		fi
	done
users="Trojan-GO_$user"
read -p "Expired (hari) : " masaaktif
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
sed -i '/"'""$uuid1""'"$/a\,"'""$users""'"' /etc/trojan-go/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan-go/akun.conf
systemctl restart trojan-go
link="trojan-go://${user}@${domain}:${trgo}/?sni=${domain}&type=ws&host=${domain}&path=/geo&encryption=none#$user"
cat > client.json << END
{
    "run_type": "client",
    "local_addr": "127.0.0.1",
    "local_port": 1080,
    "remote_addr": "${domain}",
    "remote_port": "${TrojanGo}",

    "dns": [
        "1.1.1.1"
    ],
    "password": [
        "${users}"
    ],
    "ssl": {
        "sni": "${domain}"
    },
    "websocket": {
        "enabled": true,
        "path": "\/geo",
        "hostname": "${domain}"
    }
}
END
mv client.json /home/vps/public_html/${user}-IgniterGO.json
clear
echo -e ""
echo -e "${red}=================================${off}"
echo -e "${white}            TROJAN GO${off}"
echo -e "${red}=================================${off}"
echo -e " ${green}ISP                : ${ISP}"
echo -e " CITY               : ${CITY}"
echo -e " COUNTRY            : ${COUNTRY}"
echo -e " Remarks            : ${user}"
echo -e " Host               : ${domain}"
echo -e " Port Trojan-GO     : ${TrojanGo}"
echo -e " Key Trojan-GO    : ${keyy}"
echo -e " Password Igniter   : ${users}"
echo -e " Path WebSocket     : /geo${off}"
echo -e "${red}=================================${off}"
echo -e " Trojan-GO   : ${link}" | lolcat
echo -e "${red}=================================${off}"
echo -e " Igniter-GO  : http://${domain}:81/${user}-IgniterGO.json" | lolcat
echo -e "${red}=================================${off}"
echo -e " ${white}Aktif Selama   : $masaaktif Hari"
echo -e " Dibuat Pada    : $tnggl"
echo -e " Berakhir Pada  : $expe${off}"
echo -e "${red}=================================${off}"
