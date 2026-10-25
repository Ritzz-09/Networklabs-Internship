#!/bin/bash
# ==============================================================================
# Networkwalks Cybersecurity Internship - Week 1
# Script: troubleshoot_network.sh (Automated Network Diagnostics & Fixer)
# Author: Rithish S P (@Ritzz-09)
# ==============================================================================

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}======================================================================${NC}"
echo -e "${CYAN}    CYBERLAB-NAT NETWORK DIAGNOSTIC & TROUBLESHOOTING TOOL            ${NC}"
echo -e "${CYAN}======================================================================${NC}"
echo ""

# 1. Interface State Check
echo -e "${YELLOW}[1/6] Checking Interface State (eth0)...${NC}"
LINK_STATE=$(ip link show eth0 2>/dev/null | grep -o "state [A-Z]*" | awk '{print $2}')
if [ "$LINK_STATE" = "UP" ]; then
    echo -e "${GREEN}[OK] eth0 link state is UP.${NC}"
else
    echo -e "${RED}[WARNING] eth0 is DOWN or disconnected.${NC}"
    echo -e "Attempting remediation: sudo ip link set eth0 up"
    sudo ip link set eth0 up
fi
echo ""

# 2. IP Addressing Check
echo -e "${YELLOW}[2/6] Checking IP Assignment on eth0...${NC}"
CURRENT_IP=$(ip -4 addr show eth0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
if [ "$CURRENT_IP" = "10.0.0.2" ]; then
    echo -e "${GREEN}[OK] Correct static IP 10.0.0.2 assigned.${NC}"
elif [ "$CURRENT_IP" = "10.0.0.3" ]; then
    echo -e "${YELLOW}[NOTE] Interface currently holds dynamic DHCP lease 10.0.0.3.${NC}"
    echo -e "To transition to static IP 10.0.0.2/24:"
    echo -e "  sudo ip addr add 10.0.0.2/24 dev eth0"
elif [ -z "$CURRENT_IP" ]; then
    echo -e "${RED}[FAIL] No IPv4 address assigned to eth0!${NC}"
else
    echo -e "${YELLOW}[INFO] eth0 has address: $CURRENT_IP${NC}"
fi
echo ""

# 3. Default Route Check
echo -e "${YELLOW}[3/6] Checking Routing Table & Default Gateway...${NC}"
DEFAULT_GW=$(ip route | grep "^default" | awk '{print $3}')
if [ "$DEFAULT_GW" = "10.0.0.1" ]; then
    echo -e "${GREEN}[OK] Default route points to NAT Gateway 10.0.0.1.${NC}"
else
    echo -e "${RED}[WARNING] Default route is missing or points to wrong gateway: '$DEFAULT_GW'${NC}"
    echo -e "Attempting remediation: sudo ip route replace default via 10.0.0.1 dev eth0"
    sudo ip route replace default via 10.0.0.1 dev eth0 2>/dev/null && echo -e "${GREEN}[FIXED] Default route restored.${NC}"
fi
echo ""

# 4. Gateway Reachability Check
echo -e "${YELLOW}[4/6] Pinging NAT Router Gateway (10.0.0.1)...${NC}"
if ping -c 2 -W 2 10.0.0.1 > /dev/null 2>&1; then
    echo -e "${GREEN}[OK] Gateway 10.0.0.1 is responsive.${NC}"
else
    echo -e "${RED}[FAIL] Gateway 10.0.0.1 is unreachable.${NC}"
    echo -e "Troubleshooting steps:"
    echo -e "  - Open VirtualBox VM Settings -> Network."
    echo -e "  - Ensure 'Attached to' is set to 'NAT Network' (NOT standard 'NAT')."
    echo -e "  - Confirm network name is 'Cyberlab-NAT'."
    echo -e "  - Ensure 'Virtual Cable Connected' is checked."
fi
echo ""

# 5. Outbound Internet Connectivity Check
echo -e "${YELLOW}[5/6] Testing Outbound Internet Access (8.8.8.8)...${NC}"
if ping -c 2 -W 3 8.8.8.8 > /dev/null 2>&1; then
    echo -e "${GREEN}[OK] Internet access via NAT is active.${NC}"
else
    echo -e "${RED}[FAIL] Internet ping to 8.8.8.8 failed.${NC}"
    echo -e "Verify host machine has an active Internet connection."
fi
echo ""

# 6. DNS Resolver Configuration Check
echo -e "${YELLOW}[6/6] Checking DNS Resolution & /etc/resolv.conf...${NC}"
if grep -q "nameserver" /etc/resolv.conf 2>/dev/null; then
    echo -e "${GREEN}[OK] Active nameservers found:${NC}"
    grep "nameserver" /etc/resolv.conf
else
    echo -e "${RED}[WARNING] No nameserver found in /etc/resolv.conf!${NC}"
    echo -e "Applying remediation: adding Google Public DNS 8.8.8.8..."
    echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
    echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf > /dev/null
fi

if ping -c 2 -W 3 google.com > /dev/null 2>&1; then
    echo -e "${GREEN}[OK] Domain resolution test (google.com) succeeded.${NC}"
else
    echo -e "${RED}[FAIL] Could not resolve google.com. Check DNS configuration.${NC}"
fi
echo ""

echo -e "${CYAN}======================================================================${NC}"
echo -e "${CYAN}                DIAGNOSTIC SCAN COMPLETE                              ${NC}"
echo -e "${CYAN}======================================================================${NC}"
