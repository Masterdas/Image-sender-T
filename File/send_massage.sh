#!/bin/bash

# --------- COLOR DEFINITIONS ------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

# --------- USER INPUT SECTION ------------
echo -e "${CYAN}Enter your Telegram Bot Token:${RESET}"
read -p "> " BOT_TOKEN

echo -e "${CYAN}Enter your Telegram Chat ID:${RESET}"
read -p "> " CHAT_ID

# --------- MESSAGE INPUT ------------
echo -e "${CYAN}Enter the message to send via Telegram:${RESET}"
read -p "> " MESSAGE

# --------- SEND MESSAGE VIA TELEGRAM API ------------
echo -e "${CYAN}Sending message...${RESET}"
response=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHAT_ID}" \
    -d text="${MESSAGE}")

# --------- RESULT ------------
if [[ $response == *'"ok":true'* ]]; then
    echo -e "${GREEN}✅ Message sent successfully!${RESET}"
else
    echo -e "${RED}❌ Failed to send message. Please check your token or chat ID.${RESET}"
fi