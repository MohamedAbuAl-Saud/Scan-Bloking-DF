#!/bin/bash

TOOL_NAME="Scan Blocking"
DEVELOPER="@A_Y_TR"

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
BLUE="\033[1;34m"
MAGENTA="\033[0;35m"
RESET="\033[0m"

show_banner() {
    clear
    echo -e "${CYAN}"
    echo "   ██████╗ ███████╗ █████╗ ███╗   ██╗     ██████╗ ██╗      ██████╗  ██████╗ ██╗  ██╗"
    echo "  ██╔════╝ ██╔════╝██╔══██╗████╗  ██║    ██╔═══██╗██║     ██╔═══██╗██╔════╝ ██║ ██╔╝"
    echo "  ██║  ███╗█████╗  ███████║██╔██╗ ██║    ██║   ██║██║     ██║   ██║██║  ███╗█████╔╝ "
    echo "  ██║   ██║██╔══╝  ██╔══██║██║╚██╗██║    ██║   ██║██║     ██║   ██║██║   ██║██╔═██╗ "
    echo "  ╚██████╔╝███████╗██║  ██║██║ ╚████║    ╚██████╔╝███████╗╚██████╔╝╚██████╔╝██║  ██╗"
    echo "   ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝     ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝"
    echo "                                🌐 DF 🌐"
    echo -e "${RESET}"
    echo -e "${MAGENTA}Welcome to ${TOOL_NAME}${RESET}"
    echo -e "${YELLOW}Developed by: $DEVELOPER${RESET}"
    echo -e "${CYAN}=======================================================${RESET}"
}

check_website() {
    local url=$1
    domain=$(echo "$url" | sed 's|http[s]*://||' | cut -d "/" -f 1)
    ip_address=$(ping -c 1 "$domain" 2>/dev/null | head -1 | awk '{print $3}' | tr -d '()')
    start_time=$(date +%s%N)
    response=$(curl -o /dev/null -s -w "%{http_code}" "$url")
    end_time=$(date +%s%N)
    response_time=$(( (end_time - start_time) / 1000000 ))

    if [ "$response" -eq 200 ]; then
        echo -e "${GREEN}✅ Website is reachable!${RESET}"
        echo -e "${CYAN}⏱️ Response Time: ${response_time} ms${RESET}"
        echo -e "${CYAN}🌍 IP Address: ${ip_address}${RESET}"
    elif [ -z "$response" ]; then
        echo -e "${RED}❌ Website is unreachable.${RESET}"
    else
        echo -e "${YELLOW}⚠️ Website returned status code: ${response}${RESET}"
    fi
}

main() {
    show_banner

    while true; do
        read -p "Enter website URL (e.g., https://example.com): " url
        if [[ "$url" != http* ]]; then
            echo -e "${RED}❌ Please enter a valid URL starting with 'http' or 'https'.${RESET}"
            continue
        fi

        check_website "$url"

        read -p "Do you want to check another website? (yes/no): " choice
        if [[ "$choice" != "yes" ]]; then
            echo -e "${CYAN}👋 Thank you for using $TOOL_NAME!${RESET}"
            break
        fi
    done
}

main
