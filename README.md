# Networkwalks Cybersecurity Internship

[![Internship](https://img.shields.io/badge/Internship-Networkwalks-blue?logo=cisco&logoColor=white)](https://github.com/Ritzz-09/Networkwalks-Internship)
[![Author](https://img.shields.io/badge/Author-Rithish_S_P-black?logo=github)](https://github.com/Ritzz-09)
[![Status](https://img.shields.io/badge/Status-Active-brightgreen)](#internship-modules)
[![Workstation](https://img.shields.io/badge/Workstation-Lenovo_IdeaPad_Slim_3_i5--13420H-blue)](week1/#1-host-machine-specifications)

This repository serves as the official portfolio and technical documentation for the **Networkwalks Cybersecurity Internship**. It contains hands-on laboratory setups, technical configurations, network topology models, verification tests, and security assessments completed across each weekly project module.

---

## 📚 Internship Modules

| Week | Project Module & Topic | Environment & Focus | Documentation Link | Status |
|:---:|---|---|:---:|:---:|
| **Week 1** | **Cybersecurity Laboratory Environment Setup** | Oracle VirtualBox, Kali Linux, NAT Network (`10.0.0.0/24`), Routing, ICMP & DNS Verification | [📁 Week 1 Documentation](week1/) | ✅ Completed |
| **Week 2** | *Upcoming Module* | *To be updated* | *TBD* | ⏳ Pending |
| **Week 3** | *Upcoming Module* | *To be updated* | *TBD* | ⏳ Pending |
| **Week 4** | *Upcoming Module* | *To be updated* | *TBD* | ⏳ Pending |

---

## 🚀 Week 1 Quick Navigation

### [Week 1: Cybersecurity Laboratory Environment Setup](week1/)

* **Host Machine:** Lenovo IdeaPad Slim 3 15IRH10 (Model 83K1), 13th Gen Intel Core i5-13420H (2.10 GHz), 16.0 GB RAM, Windows 11 Home Single Language
* **Virtualization:** Oracle VirtualBox 7.2.22
* **Security Workstation:** Kali Linux 2026.2 (amd64)
* **Network Mode:** Isolated NAT Network (`Cyberlab-NAT`) on `10.0.0.0/24`
* **Routing:** Virtual Gateway `10.0.0.1`, Initial dynamic DHCP baseline (`10.0.0.3`), Static addressing (`10.0.0.2/24`)
* **Automation Suite:** `verify_lab.sh`, `troubleshoot_network.sh`, `configure_static_ip.sh`
* **Verification Milestones:** Desktop deployment, adapter configuration, baseline routing, static IP configuration, gateway ICMP reachability, outbound Internet connectivity, and DNS resolution.

👉 **Read the full module runbook and evidence report:** [**week1/README.md**](week1/)

---

## 📂 Repository Structure

```
Networkwalks-Internship/
├── README.md                                     # Main repository overview & syllabus
└── week1/                                        # Week 1: Cybersecurity Lab Environment Setup
    ├── README.md                                 # Week 1 technical report & operational runbook
    ├── verify_lab.sh                             # Automated 5-point verification test suite
    ├── troubleshoot_network.sh                   # Network diagnostic & auto-remediation tool
    ├── configure_static_ip.sh                    # Static IP & persistent gateway configuration script
    └── images/                                   # Empirical screenshots & network diagrams
        ├── kali-linux-desktop.png                # Kali Linux desktop interface
        ├── network-topology.png                  # Lab network topology infographic
        ├── nat-network-configuration.png         # Cyberlab-NAT (10.0.0.0/24) configuration
        ├── virtualbox-adapter-configuration.png  # VM Adapter 1 attached to Cyberlab-NAT
        ├── initial-routing-table.png             # Initial routing table & DHCP baseline
        ├── kali-ip-address.png                   # Static IP configuration (10.0.0.2/24) on eth0
        ├── default-gateway.png                   # Default gateway (10.0.0.1) routing verification
        ├── ping-gateway.png                      # Gateway (10.0.0.1) & Internet (8.8.8.8) ping tests
        ├── ping-internet.png                     # Kernel route persistence & reachability
        └── virtualbox-default-nat.png            # Default NAT reference (troubleshooting)
```

---

## 👤 Author

**Rithish S P**  
* GitHub: [@Ritzz-09](https://github.com/Ritzz-09)
* Repository: [Networkwalks-Internship](https://github.com/Ritzz-09/Networkwalks-Internship)
