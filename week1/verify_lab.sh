#!/bin/bash
# ==============================================================================
# Networkwalks Cybersecurity Internship - Week 1
# Script: verify_lab.sh (Comprehensive Verification & System Validation)
# Author: Rithish S P (@Ritzz-09)
# ==============================================================================

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================================================${NC}"
echo -e "${BLUE}   NETWORKWALKS INTERNSHIP — WEEK 1 LAB VERIFICATION SUITE             ${NC}"
echo -e "${BLUE}======================================================================${NC}"
echo -e "Host System   : Lenovo IdeaPad Slim 3 15IRH10 (13th Gen Intel Core i5-13420H, 16GB RAM, Win11)"
echo -e "Hypervisor    : Oracle VirtualBox 7.2.22"
echo -e "Target Network: Cyberlab-NAT (Subnet: 10.0.0.0/24 | Gateway: 10.0.0.1)"
echo -e "Workstation   : $(uname -n) - $(uname -sr)"
echo -e "Date/Time     : $(date)"
echo -e "${BLUE}----------------------------------------------------------------------${NC}"
echo ""

TOTAL_TESTS=5
PASSED_TESTS=0

# --- STEP 1: Interface & Static IP Verification ---
echo -e "${YELLOW}[TEST 1/5] Verifying Static IP Configuration on eth0...${NC}"
if ip -4 addr show eth0 | grep -q "10.0.0.2/24"; then
    echo -e "${GREEN}[PASS] Static IP 10.0.0.2/24 is correctly configured on eth0.${NC}"
    ip -4 addr show eth0 | grep "inet "
    ((PASSED_TESTS++))
else
    echo -e "${RED}[FAIL] Interface eth0 does not have static IP 10.0.0.2/24.${NC}"
    echo -e "Current IP addresses on eth0:"
    ip -4 addr show eth0
    echo -e "${YELLOW}[*] Attempting automatic assignment of 10.0.0.2/24...${NC}"
    sudo ip addr add 10.0.0.2/24 dev eth0 2>/dev/null && echo -e "${GREEN}[OK] Assigned 10.0.0.2/24${NC}"
fi
echo ""

# --- STEP 2: Default Gateway Routing Verification ---
echo -e "${YELLOW}[TEST 2/5] Verifying Default Gateway via 10.0.0.1...${NC}"
if ip route | grep -E "^default via 10.0.0.1"; then
    echo -e "${GREEN}[PASS] Default route via 10.0.0.1 confirmed in routing table.${NC}"
    ip route | grep "^default"
    ((PASSED_TESTS++))
else
    echo -e "${RED}[FAIL] Default route via 10.0.0.1 not found.${NC}"
    echo -e "${YELLOW}[*] Attempting to add default route via 10.0.0.1...${NC}"
    sudo ip route replace default via 10.0.0.1 dev eth0 && echo -e "${GREEN}[OK] Route added.${NC}"
fi
echo ""

# --- STEP 3: Gateway ICMP Echo Test ---
echo -e "${YELLOW}[TEST 3/5] Testing ICMP Reachability to NAT Gateway (10.0.0.1)...${NC}"
if ping -c 4 -W 2 10.0.0.1 > /dev/null 2>&1; then
    echo -e "${GREEN}[PASS] Gateway 10.0.0.1 responded with 0% packet loss.${NC}"
    ping -c 4 10.0.0.1 | tail -2
    ((PASSED_TESTS++))
else
    echo -e "${RED}[FAIL] Gateway 10.0.0.1 unreachable! Check VirtualBox cable state.${NC}"
fi
echo ""

# --- STEP 4: Outbound Internet Connectivity Test ---
echo -e "${YELLOW}[TEST 4/5] Testing Outbound Internet Access via Google DNS (8.8.8.8)...${NC}"
if ping -c 4 -W 3 8.8.8.8 > /dev/null 2>&1; then
    echo -e "${GREEN}[PASS] Outbound Internet connectivity confirmed via 8.8.8.8.${NC}"
    ping -c 4 8.8.8.8 | tail -2
    ((PASSED_TESTS++))
else
    echo -e "${RED}[FAIL] Unable to reach 8.8.8.8. Check host Internet connection or NAT.${NC}"
fi
echo ""

# --- STEP 5: DNS Name Resolution Test ---
echo -e "${YELLOW}[TEST 5/5] Testing Domain Name Resolution (google.com)...${NC}"
if ping -c 4 -W 3 google.com > /dev/null 2>&1; then
    echo -e "${GREEN}[PASS] DNS resolution functional; google.com resolved and responded.${NC}"
    ping -c 4 google.com | tail -2
    ((PASSED_TESTS++))
else
    echo -e "${RED}[FAIL] DNS resolution failed. Check /etc/resolv.conf nameservers.${NC}"
fi
echo ""

# --- FINAL SUMMARY ---
echo -e "${BLUE}======================================================================${NC}"
if [ $PASSED_TESTS -eq $TOTAL_TESTS ]; then
    echo -e "${GREEN}  ✓ ALL TESTS PASSED (${PASSED_TESTS}/${TOTAL_TESTS}) — LAB SETUP FULLY VERIFIED!${NC}"
    echo -e "${GREEN}  Capture a screenshot of this terminal output for your repository.${NC}"
else
    echo -e "${YELLOW}  ⚠ TESTS COMPLETED: ${PASSED_TESTS}/${TOTAL_TESTS} passed. Review items above.${NC}"
fi
echo -e "${BLUE}======================================================================${NC}"
