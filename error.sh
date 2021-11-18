#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
NC='\e[0m'
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

apt-get install curl -y
clear
echo -e "${yellow}======================================${off}"
echo -e "      Please Input Your License" | lolcat
echo -e "${yellow}======================================${off}"
echo -e "${green}"
read -p ' Input Licence : ' pw
echo -e "${off}"
pass=$( curl https://raw.githubusercontent.com/Sangarya/izin/main/izin | grep $pw )
if [ $pw = $pass ]; then
    clear
    sleep 0.5
    echo -e "${green} Sukses Verifikasi Lisensi!${off}"
    sleep 0.5
else 
    clear
    sleep 0.5
    echo -e "${red} Gagal Verifikasi Lisensi! ${off}"
    sleep 2
    exit 0
fi
clear
MYIP=$(wget -qO- icanhazip.com);
echo -e  "${RED}MENGECEK VPS${NC}"
sleep 2
IZIN=$( curl https://raw.githubusercontent.com/Sangarya/izin/main/ipvps | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${GREEN}PERMINTAAN DITERIMA...${NC}"
sleep 2 
else
clear
echo -e ""
echo -e "======================================="
echo -e ""
echo -e "${RED}Permission Denied...!!! ${NC}"
echo -e "IP VPS ANDA BELUM TERDAFTAR"
echo -e "Contact WA https//wa.me/+6282339191527"
echo -e "For Registration IP VPS"
echo -e ""
echo -e "======================================="
echo -e ""
rm setup.sh
exit 0
fi

echo -e  "${RED}Checking VPS Domain${NC}"
if [ -f "/etc/v2ray/domain" ]; then
echo "Script Already Installed!!"
exit 0
fi
mkdir /var/lib/premium-script;
echo "IP=" >> /var/lib/premium-script/ipvps.conf
wget https://vpnkuy.site/domain/cf.sh && chmod +x cf.sh && ./cf.sh
#install ssh ovpn
wget https://vpnkuy.site/ssh-vpn/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
wget https://vpnkuy.site/bahan/sstp.sh && chmod +x sstp.sh && screen -S sstp ./sstp.sh
#install ssr
wget https://vpnkuy.site/bahan/ssr.sh && chmod +x ssr.sh && screen -S ssr ./ssr.sh
wget https://vpnkuy.site/bahan/sodosok.sh && chmod +x sodosok.sh && screen -S ss ./sodosok.sh
#installwg
wget https://vpnkuy.site/bahan/wg.sh && chmod +x wg.sh && screen -S wg ./wg.sh
#install v2ray
wget http://vpnkuy.site/domain/ins-vt.sh && chmod +x ins-vt.sh && screen -S v2ray ./ins-vt.sh
#install L2TP
wget https://vpnkuy.site/bahan/ipsec.sh && chmod +x ipsec.sh && screen -S ipsec ./ipsec.sh
wget https://vpnkuy.site/backup/set-br.sh && chmod +x set-br.sh && ./set-br.sh

rm -f /root/ssh-vpn.sh
rm -f /root/sstp.sh
rm -f /root/wg.sh
rm -f /root/ss.sh
rm -f /root/ssr.sh
rm -f /root/ins-vt.sh
rm -f /root/ipsec.sh
rm -f /root/set-br.sh

cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://vpnkuy.site
[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
#wget -O /etc/set.sh "https://raw.githubusercontent.com/Sangarya/ntb/main/bahan/set.sh"
chmod +x /etc/set.sh
sleep 0.5
history -c
echo "1.1.1" > /home/ver
clear
figlet -f slant GEO GABUT | lolcat
echo " "
echo " "
echo "==================-[ AUTOSCRIPT PREMIUM ]-===================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> Service Port" | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 442"  | tee -a log-install.txt
echo "   - Stunnel4                : 443, 171"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - WebSocket Dropbear      : 2052"  | tee -a log-install.txt
echo "   - WebSocket OpenSSH       : 2095"  | tee -a log-install.txt
echo "   - WebSocket OpenVPN       : 2082"  | tee -a log-install.txt
echo "   - WebSocket TLS           : 443"  | tee -a log-install.txt
echo "   - SSLH Multiplexer        : 443"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080 (limit to IP SSH)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 3200"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - SSTP VPN                : 444"  | tee -a log-install.txt
echo "   - Shadowsocks-R           : 1443-1543"  | tee -a log-install.txt
echo "   - SS-OBFS TLS             : 2443-2543"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP            : 3443-3543"  | tee -a log-install.txt
echo "   - V2RAY Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - V2RAY Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - V2RAY Vless TLS         : 2083"  | tee -a log-install.txt
echo "   - V2RAY Vless None TLS    : 8880"  | tee -a log-install.txt
echo "   - TrojanGFW               : 2087"  | tee -a log-install.txt
echo "   - TrojanGO                : 2053"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 00.00-12.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "=================-[ AUTOSCRIPT PREMIUM ]-==============" | tee -a log-install.txt
echo "- Mod By GEO GABUT" | tee -a log-install.txt
echo ""
sleep 1
if [ ! -e /root/log-install.txt ]; then
  echo -e "Setup Install Bermasalah! Sistem Akan Membuat Direktori Pengulangan" | lolcat
  sleep 0.5
  wget https://vpnkuy.site/bahan/log.sh && chmod +x log.sh && ./log.sh
  else
  rm -f setup.sh
  echo -e "Setup Install Sukses!" | lolcat
fi
echo " Reboot 5 Detik"
sleep 5
rm -f error.sh
reboot
