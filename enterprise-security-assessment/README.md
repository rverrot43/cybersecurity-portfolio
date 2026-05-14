# Enterprise Security Assessment & Network Redesign

## Project Overview

Conducted a comprehensive security assessment of a simulated enterprise network (DASWebs Inc.) spanning four subnets with 12 hosts across production, development, internal, and perimeter network segments. Identified critical vulnerabilities including EternalBlue (CVE-2017-0143) on the domain controller, ineffective firewall segmentation, and end-of-life operating systems. Performed risk analysis using NIST SP 800-30 methodology and designed a remediated network architecture implementing defense-in-depth principles with DMZ segmentation, SIEM deployment, IDS/IPS, and jump host access controls.

---

## Assessment Scope

**Network Segments Assessed:**
- **Production Subnet (172.16.10.0/24):** Prod-Web (AlmaLinux 9.3)
- **Development Subnet (172.16.20.0/24):** Database (Windows Server 2012 R2), Dev-Web (Ubuntu 20.04.2 LTS)
- **Internal Subnet (172.16.30.0/24):** Domain Controller (Windows Server 2012 R2), Mail, Fileshare, Backup, Security-Desk, Workstation-Desk
- **Network Perimeter:** Firewall (pfSense 2.5.0) with interfaces on all subnets

**Assessment Focus:**
- Network segmentation effectiveness
- Security appliance implementation
- Protocol security and communications
- Endpoint security posture
- Compliance with NIST SP 800-53 controls

---

## Objectives

1. Identify security vulnerabilities across production, development, and internal network segments
2. Assess compliance against NIST SP 800-53 security controls
3. Prioritize risks using NIST SP 800-30 risk assessment methodology
4. Design remediated architecture with DMZ segmentation, SIEM, IDS/IPS, and jump host access controls
5. Provide actionable remediation roadmap with prioritized security improvements

---

## Tools & Technologies Used

**Vulnerability Scanning:**
- Nmap 7.94SVN with NSE scripts (vulners, vulscan, smb-vuln-ms17-010, http-enum)
- Custom vulnerability scanning automation

**Traffic Analysis:**
- tcpdump (10,000+ packet capture)
- Wireshark for protocol analysis

**Scripting & Automation:**
- Custom Bash security audit script for Linux systems
- Custom PowerShell security audit script for Windows systems

**Firewall Analysis:**
- pfSense 2.5.0 configuration review
- Manual analysis of rc.firewall configuration script

**Frameworks:**
- NIST SP 800-53 (Security and Privacy Controls)
- NIST SP 800-30 (Risk Assessment)

---

## Assessment Methodology

The assessment employed a multi-phase approach:

1. **Automated Vulnerability Scanning:** Nmap with NSE vulnerability scripts across all subnets
2. **Network Mapping:** Host discovery with traceroute to map network topology
3. **Service Enumeration:** OS detection and service version scanning
4. **Full Port Scanning:** All-port TCP scan to identify non-standard services
5. **Traffic Capture:** Live network traffic analysis using tcpdump and Wireshark
6. **Firewall Configuration Review:** Manual analysis of pfSense rules and segmentation
7. **Host-Level Data Collection:** Custom security scripts executed on Prod-Web, Dev-Web, Database, and Domain Controller
8. **Manual Analysis:** Correlation of findings and risk prioritization

All assessment activities were conducted from the Security-Desk workstation (172.16.30.6) using authorized credentials.

---

## Key Findings

### **Critical Vulnerabilities (Risk Score: 25/25 - Very High)**

**1. EternalBlue (CVE-2017-0143) on Domain Controller**
- **Impact:** Remote code execution with SYSTEM privileges
- **Affected Host:** Domain Controller (172.16.30.5) - Windows Server 2012 R2
- **Attack Vector:** SMBv1 vulnerability allowing unauthenticated remote exploitation
- **Remediation:** Immediate patching (MS17-010), disable SMBv1, network segmentation

**2. Firewall Not Enforcing Effective Inter-Subnet Access Controls**
- **Impact:** Unrestricted lateral movement between all subnets
- **Affected System:** pfSense Firewall (172.16.10.2, 172.16.20.2, 172.16.30.2)
- **Finding:** Firewall rules allow "any-to-any" traffic between Production, Development, and Internal subnets
- **Remediation:** Implement least-privilege firewall rules, create DMZ, restrict administrative access to jump host

**3. SambaCry (CVE-2017-7494) on Fileshare**
- **Impact:** Remote code execution via malicious SMB share uploads
- **Affected Host:** Fileshare (172.16.30.32) - OpenMediaVault 7.1.1
- **Remediation:** Patch Samba to version 4.6.4+, disable unnecessary SMB/NFS services

### **High-Risk Findings (Risk Score: 20/25 - Very High)**

**4. Exposed Administrative Services on Critical Internal Hosts**
- **Affected Hosts:** Fileshare (JMX Console - no authentication), Domain Controller (RDP/WinRM), Database (RDP/WinRM)
- **Impact:** Direct administrative access from any subnet without jump host controls
- **Remediation:** Deploy jump host (bastion), restrict RDP/SSH/WinRM to management subnet only

**5. End-of-Life Operating Systems**
- **Affected Hosts:** 5 hosts + Firewall
  - Domain Controller: Windows Server 2012 R2 (EOL: October 2023)
  - Database: Windows Server 2012 R2 (EOL: October 2023)
  - Backup: Debian GNU/Linux 9 (EOL: June 2022)
  - Firewall: pfSense 2.5.0 (EOL: May 2023)
- **Impact:** No security patches available, known exploits publicly available
- **Remediation:** Upgrade to supported OS versions (Windows Server 2022, Debian 12, pfSense 2.7+)

**6. No SIEM, IDS/IPS, or EDR Deployed**
- **Impact:** No visibility into network attacks, lateral movement, or data exfiltration
- **Remediation:** Deploy Wazuh SIEM (172.16.30.200), Suricata IDS/IPS, EDR agents on all endpoints

### **Additional High-Risk Findings (Risk Score: 12/25 - High)**

- Outdated Apache httpd on Backup, Dev-Web, Prod-Web, Mail
- Outdated OpenSSH services on Domain Controller, Database, Workstation-Desk
- Cleartext protocols (Telnet, FTP, HTTP) observed in traffic capture
- Inadequate network segmentation within Internal subnet

---

## Risk Assessment Summary

| Rank | Risk | Host(s) | Likelihood | Impact | Risk Score | Level |
|------|------|---------|------------|--------|------------|-------|
| 1 | EternalBlue (CVE-2017-0143) | Domain Controller | 5 | 5 | 25 | Very High |
| 2 | Firewall Not Enforcing Effective Segmentation | Firewall | 5 | 5 | 25 | Very High |
| 3 | SambaCry (CVE-2017-7494) | Fileshare | 4 | 5 | 20 | Very High |
| 4 | Exposed Administrative Services | Fileshare, DC, Database | 4 | 5 | 20 | Very High |
| 5 | JMX Console Unauthenticated | Fileshare | 5 | 4 | 20 | Very High |
| 6 | End-of-Life Operating Systems | 5 hosts + Firewall | 4 | 5 | 20 | Very High |
| 7 | Outdated Apache httpd | Backup, Dev-Web, Prod-Web, Mail | 3 | 4 | 12 | High |
| 8 | Outdated OpenSSH Services | DC, Database, Workstation-Desk | 3 | 4 | 12 | High |
| 9 | Exposed RDP + WinRM | Workstation-Desk, DC, Database | 3 | 4 | 12 | High |
| 10 | Cleartext Protocols | Mail, Backup, DC, +5 | 3 | 4 | 12 | High |
| 11 | No IDS/IPS/SIEM/EDR | Entire network | 4 | 3 | 12 | High |
| 12 | Inadequate Segmentation | Internal Subnet | 4 | 3 | 12 | High |

**Risk Scoring Methodology:** NIST SP 800-30 (Likelihood × Impact = Risk Score)

---

## Remediation Architecture

Designed a comprehensive remediated network architecture implementing defense-in-depth principles:

### **Key Security Improvements:**

1. **NEW - DMZ Subnet (172.16.40.0/24)** for internet-facing services
   - Prod-Web relocated from Production subnet to DMZ
   - Mail Server relocated from Internal subnet to DMZ
   - WAF (ModSecurity 3.0 + OWASP CRS) deployed to protect web applications
   - Email Security Gateway (MailScanner) deployed

2. **NEW - Management Network (172.16.50.0/24)** for administrative access only
   - Jump Host (Bastion Server) at 172.16.50.10
   - Security-Desk relocated to Management subnet
   - ALL SSH(22), RDP(3389), and admin access MUST route through Jump Host ONLY

3. **NEW - SIEM Deployment**
   - Wazuh 4.x SIEM Server at 172.16.30.200
   - Wazuh agents deployed on ALL endpoints
   - Centralized log forwarding and correlation

4. **NEW - IDS/IPS Deployment**
   - Suricata 7.0 deployed for network-based threat detection
   - Signature-based and behavioral detection enabled

5. **Network Segmentation Enforcement**
   - Firewall rules rewritten to enforce least-privilege access
   - Production subnet isolated from direct internet access
   - Database tier (Development subnet) accessible only via Jump Host
   - Internal subnet protected with strict access controls

6. **Administrative Access Controls**
   - RDP/SSH disabled on Workstation-Desk, Fileshare, Backup
   - SMB/NFS disabled on Fileshare (replaced with secure protocols)
   - All administrative access audited and logged

7. **Protocol Security**
   - FTP replaced with SFTP on Backup server
   - Telnet disabled across all systems
   - HTTP replaced with HTTPS (443) on all web servers

8. **Endpoint Security**
   - EDR agents deployed on all Windows and Linux endpoints
   - Wazuh agents configured for file integrity monitoring (FIM)
   - Centralized patch management implemented

---

## Project Artifacts

- **[Full Security Assessment Report (PDF)](./reports/security-assessment-report.pdf)** - Complete vulnerability assessment with findings, risk analysis, and remediation recommendations
- **[Recommended Network Architecture Diagram](./diagrams/recommended-network-architecture.png)** - Visual representation of remediated architecture with DMZ, Management Network, and security controls
- **[Linux Security Audit Script](./scripts/linux_security_script.sh)** - Custom Bash script for automated security data collection on Linux systems
- **[Windows Security Audit Script](./scripts/windows_security_script.ps1)** - Custom PowerShell script for automated security data collection on Windows systems
- **[Findings Summary (Markdown)](./findings/findings-summary.md)** - Executive summary of key findings and recommendations

---

## Skills Demonstrated

✅ **Vulnerability Assessment & Penetration Testing**
- Nmap vulnerability scanning with NSE scripts
- Service enumeration and OS fingerprinting
- Exploitation path analysis

✅ **Risk Analysis & Prioritization**
- NIST SP 800-30 risk assessment methodology
- Likelihood and impact scoring
- Attack path analysis

✅ **Security Architecture Design**
- DMZ segmentation and network isolation
- Defense-in-depth principles
- Jump host (bastion) implementation
- SIEM and IDS/IPS deployment planning

✅ **Compliance Mapping**
- NIST SP 800-53 security control assessment
- Gap analysis and remediation planning

✅ **Scripting & Automation**
- Bash scripting for Linux security auditing
- PowerShell scripting for Windows security auditing
- Automated data collection and analysis

✅ **Network Traffic Analysis**
- tcpdump packet capture
- Wireshark protocol analysis
- Cleartext protocol identification

✅ **Technical Documentation & Reporting**
- Executive summary writing
- Technical finding documentation
- Remediation roadmap development
- Visual architecture diagrams

---

## Assessment Timeline

**Total Duration:** 21 hours over 2 days (May 6-7, 2026)

- **Phase 1:** Environment setup and initial vulnerability scanning (2 hours)
- **Phase 2:** Script development and deployment (3 hours)
- **Phase 3:** Host-level data collection (4 hours)
- **Phase 4:** Firewall and network analysis (3 hours)
- **Phase 5:** Data analysis and risk assessment (5 hours)
- **Phase 6:** Remediation architecture design (2 hours)
- **Phase 7:** Report writing and documentation (2 hours)

---

## About This Project

This security assessment was completed as the capstone project for CNG 2059: Enterprise Security at Pikes Peak State College (May 2026). The assessment was conducted in the XP Cyber Range simulated lab environment against a fictional organization (DASWebs Inc.) to demonstrate practical application of vulnerability assessment, risk analysis, and security architecture design skills.

All IP addresses, hostnames, and system identifiers reflect the simulated lab environment. Personal identifying information has been sanitized where appropriate.

---

*Assessment Completed: May 2026*  
*Frameworks: NIST SP 800-53, NIST SP 800-30*  
*Tools: Nmap, Wireshark, tcpdump, Bash, PowerShell, pfSense*
