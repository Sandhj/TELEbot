#!/bin/bash
read -p " Masukkan Token Telegram : " TOKEN

mkdir -p /san/bot
cd /san/bot

cat << 'EOF' > akun.py
import telebot
import subprocess

bot = telebot.TeleBot("${TOKEN}")

@bot.message_handler(commands=['akun_ssh'])
def create_ssh(message):
    subprocess.run(['bash', 'bottrial'])

@bot.message_handler(commands=['akun_vmess'])
def create_vmess(message):
    subprocess.run(['bash', 'bottrialws'])

@bot.message_handler(commands=['akun_vless'])
def create_vless(message):
    subprocess.run(['bash', 'bottrialvless'])

@bot.message_handler(commands=['akun_trojan'])
def create_trojan(message):
    subprocess.run(['bash', 'bottrial-tr'])

bot.polling()
EOF

cat << 'EOF' > /etc/systemd/system/akun.service
[Unit]
Description=Telegram Bot
After=network.target

[Service]
User=root
WorkingDirectory=/root/san/bot
ExecStart=/usr/bin/python3 akun.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload 
sudo systemctl start akun
sudo systemctl enable akun

cd
rm akunfree.sh
