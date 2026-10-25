#!/bin/bash
# ==============================================================================
# Networkwalks Cybersecurity Internship - Week 1
# Script: configure_static_ip.sh (Apply & Persist Static IP 10.0.0.2/24)
# Author: Rithish S P (@Ritzz-09)
# ==============================================================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}======================================================================${NC}"
echo -e "${BLUE}   APPLYING STATIC IP CONFIGURATION TO ETH0 (10.0.0.2/24)             ${NC}"
echo -e "${BLUE}======================================================================${NC}"

# Flush existing ephemeral leases and assign static IP
echo "[+] Flushing interface eth0..."
sudo ip addr flush dev eth0

echo "[+] Assigning static IP 10.0.0.2/24 to eth0..."
sudo ip addr add 10.0.0.2/24 dev eth0

echo "[+] Bringing up eth0..."
sudo ip link set eth0 up

echo "[+] Configuring default gateway via 10.0.0.1..."
sudo ip route replace default via 10.0.0.1 dev eth0

echo "[+] Configuring persistent DNS nameservers in /etc/resolv.conf..."
sudo tee /etc/resolv.conf > /dev/null << 'EOF'
nameserver 8.8.8.8
nameserver 1.1.1.1
EOF

echo ""
echo -e "${GREEN}[SUCCESS] Configuration applied! Current Network Status:${NC}"
echo "--------------------------------------------------------"
ip -4 addr show eth0
echo ""
ip route show
echo "--------------------------------------------------------"
echo "Run ./verify_lab.sh to test full end-to-end connectivity."
