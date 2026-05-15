# Ryan Verrot - Cybersecurity Portfolio

## About Me

Recent Cybersecurity AAS graduate (4.0 GPA, Summa Cum Laude) from Pikes Peak State College with hands-on experience in vulnerability assessment, threat intelligence analysis, cloud security architecture, and PCI-DSS compliance. Demonstrated expertise in identifying critical vulnerabilities, designing remediated network architectures, and analyzing nation-state APT threats using the MITRE ATT&CK framework.

Currently pursuing CompTIA Security+ certification (expected June 2026) and Bachelor of Applied Science in Cybersecurity (expected 2028).

**Security Clearance:** Eligible (U.S. Citizen)

---

## Technical Skills

**Security Tools & Platforms:**  
Nmap, Wireshark, Splunk, Burp Suite, Caido, Nessus, Security Onion, Wazuh, Suricata, tcpdump, SCAP Compliance Checker, ModSecurity

**Cloud Security:**  
Microsoft Azure (Security Center, App Service, Monitor, Virtual Networks), AWS (VPC, IAM, Secrets Manager, RDS, Auto Scaling, Systems Manager)

**Operating Systems:**  
Windows Server (2012 R2, 2016, 2019), Linux (Kali, Ubuntu, AlmaLinux, Debian), pfSense, Windows 10/11

**Scripting & Automation:**  
PowerShell, Bash, Python, Azure CLI, Terraform

**Security Frameworks & Compliance:**  
MITRE ATT&CK, MITRE D3FEND, NIST SP 800-53, NIST SP 800-30, PCI-DSS, vulnerability management

**Networking:**  
TCP/IP, DNS, DHCP, VPN, firewall configuration (pfSense, Cisco), load balancers, network segmentation, IDS/IPS

---

## Featured Projects

### 1. Enterprise Security Assessment & Network Redesign
**[View Project →](./enterprise-security-assessment/)**

Conducted comprehensive security assessment of multi-subnet enterprise network (4 subnets, 12 hosts) using vulnerability scanning, traffic analysis, and compliance auditing against NIST SP 800-53 controls. Identified **critical vulnerabilities** including EternalBlue (CVE-2017-0143) on domain controller, outdated Windows Server 2012 R2 systems, and weak network segmentation exposing production database to internet.

**Key Accomplishments:**
- Developed and executed custom Bash and PowerShell security scanning scripts to automate host-level auditing across Linux and Windows systems
- Performed network traffic capture and analysis using tcpdump (10,000+ packets) and Wireshark to identify insecure protocols and unauthorized communications
- Utilized Nmap with NSE vulnerability scripts (vulners, vulscan, SMB exploits) to conduct active vulnerability scanning and OS fingerprinting
- Designed remediated network architecture implementing DMZ segmentation, jump host for administrative access, SIEM deployment (Wazuh), IDS/IPS (Suricata), and WAF (ModSecurity)
- Conducted risk assessment using NIST SP 800-30 methodology, prioritizing findings by likelihood and impact

**Tools Used:** Nmap, Wireshark, tcpdump, Bash, PowerShell, pfSense  
**Frameworks:** NIST SP 800-53, NIST SP 800-30

---

### 2. APT Threat Intelligence Analysis & Plan of Action and Milestones (POA&M)
**[View Project →](./apt-threat-intelligence/)**

Analyzed three nation-state APT groups (Volt Typhoon/China, APT29 Cozy Bear/Russia, APT33 Elfin/Iran) targeting U.S. critical infrastructure, government, and defense sectors. Mapped adversary tactics, techniques, and procedures (TTPs) to MITRE ATT&CK framework and developed prioritized Plan of Action & Milestones (POA&M) with defensive countermeasures.

**Key Accomplishments:**
- Mapped 15+ adversary techniques across initial access, execution, persistence, privilege escalation, and exfiltration phases
- Created custom MITRE ATT&CK Navigator layer visualizing threat landscape and technique overlap across all three APT groups
- Identified top 5 high-risk techniques (Valid Accounts T1078, Command/Scripting Interpreter T1059, OS Credential Dumping T1003, Obfuscated Files T1027, Ingress Tool Transfer T1105)
- Developed comprehensive POA&M with prioritized mitigations mapped to MITRE D3FEND countermeasures, including phishing-resistant MFA (FIDO2), PowerShell logging, Credential Guard deployment, and EDR implementation
- Incorporated threat intelligence from CISA advisories, Microsoft Threat Intelligence, Mandiant M-Trends, and Verizon DBIR

**Tools Used:** MITRE ATT&CK Navigator  
**Frameworks:** MITRE ATT&CK, MITRE D3FEND

---

### 3. AWS Cloud Security Architecture - Highly Available Multi-Tier Application
**[View Project →](./aws-cloud-architecture/)**

Architected and deployed production-ready, highly-available cloud infrastructure on AWS implementing security best practices for multi-tier web application with MySQL database backend. Transformed single-instance deployment into secure, scalable architecture with VPC segmentation, secrets management, and auto-scaling.

**Key Accomplishments:**
- Designed VPC with public/private subnet segmentation across multiple availability zones to isolate database tier from direct internet access
- Implemented AWS Secrets Manager integration with Amazon RDS to eliminate hardcoded database credentials and enforce secure credential rotation
- Configured Application Load Balancer with health checks and Auto Scaling Groups (2-4 instances) with target tracking policies
- Utilized AWS Systems Manager Session Manager for secure instance access, eliminating SSH key exposure
- Deployed security groups with least-privilege firewall rules for each tier (web, application, database)
- Leveraged AWS CLI for secrets retrieval and database operations, demonstrating Infrastructure as Code concepts

**Tools Used:** AWS (VPC, RDS, Secrets Manager, ALB, Auto Scaling, Systems Manager, CLI)  
**Skills Demonstrated:** Cloud security architecture, secrets management, high availability design, least-privilege access

---

## Professional Experience

**Teknowledge Ops USA** - Tier II Technical Support Engineer (Azure App Service)  
*Dec. 2024 – Jan. 2026 | Colorado Springs, CO*

- Analyzed Azure Security Center vulnerability reports and security recommendations to identify misconfigurations and compliance gaps
- Diagnosed web application security failures including SSL/TLS certificate errors and authentication misconfigurations
- Automated security diagnostics using PowerShell and Azure CLI scripts
- Collaborated with Azure product group to file high-impact security bugs resulting in production patches

---

## Education

**Pikes Peak State College** | Colorado Springs, CO  
**Associate of Applied Science (AAS) - Cybersecurity** | May 2026  
- Summa Cum Laude (4.0 GPA)  
- VICEROY Institute Scholar  
- 2026 VICEROY Institute Symposium Research Presenter

*Continuing Education: Bachelor of Applied Science (BAS) - Cybersecurity (Expected 2028)*

---

## Certifications

- **Cisco Certified Support Technician - Cybersecurity** (Active)
- **CompTIA Security+** (In Progress - Expected June 2026)

---

## Contact

📧 **Email:** ryan.verrot@protonmail.com  
📍 **Location:** Colorado Springs, CO  
💼 **LinkedIn:** www.linkedin.com/in/ryan-verrot-b21b1a6a 

---

## Repository Structure
