# APT Threat Intelligence Analysis & Plan of Action and Milestones (POA&M)

## Project Overview

Conducted comprehensive threat intelligence research on three nation-state Advanced Persistent Threat (APT) groups targeting U.S. critical infrastructure, government, and defense sectors. Analyzed adversary tactics, techniques, and procedures (TTPs) using the MITRE ATT&CK framework, created custom threat landscape visualizations with MITRE ATT&CK Navigator, and developed a prioritized Plan of Action & Milestones (POA&M) with defensive countermeasures mapped to MITRE D3FEND.

This analysis identifies **APT29 (Russia/Cozy Bear)**, **Volt Typhoon (China)**, and **APT33 (Iran/Elfin)** as high-priority adversaries based on their confirmed targeting of U.S. defense industrial base, critical infrastructure, and government networks between 2022-2025.

---

## Assessment Scope

**APT Groups Analyzed:**

1. **APT29 / Cozy Bear / Midnight Blizzard (Russia)** - Attributed to Russia's Foreign Intelligence Service (SVR)
   - **Primary Targets:** U.S. government agencies, diplomatic entities, technology service providers, cloud infrastructure
   - **Notable Operations:** SolarWinds supply chain attack (2020), Midnight Blizzard campaign (2023-2024)
   - **Strategic Objective:** High-level intelligence gathering on U.S. foreign policy, sanctions, and defense planning

2. **Volt Typhoon / Bronze Silhouette (China)** - Attributed to People's Republic of China (PRC) state-sponsored actors
   - **Primary Targets:** U.S. critical infrastructure (communications, manufacturing, utilities, transportation), military mobilization capabilities in CONUS and Guam
   - **Notable Operations:** KV-botnet infrastructure (disrupted 2024, rebuilt), Living off the Land (LOTL) campaigns
   - **Strategic Objective:** Pre-positioning for infrastructure disruption during potential military conflict

3. **APT33 / Elfin / Peach Sandstorm (Iran)** - Attributed to Iran's Islamic Revolutionary Guard Corps (IRGC)
   - **Primary Targets:** U.S. aerospace and defense industries, energy sector, satellite communications
   - **Notable Operations:** Password spraying against Microsoft 365/Azure AD, spear-phishing with fake job recruitment lures
   - **Strategic Objective:** Intellectual property theft (aviation/drone technologies) and cyber deterrent through destructive capability

**Analysis Timeframe:** 2022-2025 operational activity  
**Framework:** MITRE ATT&CK for Enterprise  
**Methodology:** Prevalence-based risk categorization (High/Moderate/Low based on technique usage across all three groups)

---

## Objectives

1. Identify and categorize adversary TTPs using MITRE ATT&CK framework
2. Determine high-risk techniques based on prevalence across all three APT groups
3. Create custom MITRE ATT&CK Navigator layer visualizing consolidated threat landscape
4. Develop prioritized Plan of Action & Milestones (POA&M) with defensive countermeasures
5. Map mitigations to MITRE D3FEND defensive techniques
6. Provide actionable recommendations for enterprise security operations

---

## Methodology

### **Threat Intelligence Collection**

Analyzed threat intelligence from authoritative sources:
- **CISA Cybersecurity Advisories** (AA21-116A, AA23-144A)
- **Microsoft Threat Intelligence** (Midnight Blizzard, Volt Typhoon, Peach Sandstorm reports)
- **Mandiant Threat Intelligence** (APT29, APT33 analysis)
- **Verizon Data Breach Investigations Report (DBIR) 2024**
- **MITRE Engenuity ATT&CK Evaluations 2023**
- **DOJ/FBI Press Releases** (Volt Typhoon KV-botnet disruption)

### **Risk Categorization Methodology**

Techniques were classified using prevalence-based scoring:

- **High-Risk (3/3 groups):** Techniques used by all three APT groups - represent critical defense gaps requiring immediate mitigation
- **Moderate-Risk (2/3 groups):** Techniques used by two APT groups - important but secondary priority
- **Low-Risk (1/3 groups):** Techniques used by only one APT group - group-specific tactics

### **MITRE ATT&CK Mapping**

- Mapped adversary TTPs to MITRE ATT&CK Enterprise framework (v14)
- Created custom MITRE ATT&CK Navigator layer with color-coded risk levels:
  - **High-Risk:** Pastel Red (#ff6666ff)
  - **Moderate-Risk:** Medium-Light Yellow (#ffe766ff)
  - **Low-Risk:** Light Green (default)

### **Defensive Countermeasure Mapping**

- Mapped mitigations to MITRE D3FEND defensive techniques
- Prioritized countermeasures based on risk score and implementation feasibility
- Aligned recommendations with NIST Cybersecurity Framework and CISA guidance

---

## Key Findings

### **Top 5 High-Risk Techniques (Used by All 3 APT Groups)**

#### **1. T1078 - Valid Accounts**
**Risk Level:** High (3/3 groups)

- **Description:** All three APT groups prioritize stealing and using legitimate credentials to bypass detection systems and blend in with normal user activity
- **APT29 Usage:** Golden SAML token forgery, cloud identity exploitation, token theft to bypass MFA
- **Volt Typhoon Usage:** Living off the Land with valid credentials, maintaining long-term persistence without custom malware
- **APT33 Usage:** Large-scale password spraying against Microsoft 365 and Azure AD environments
- **Impact:** Enables initial access, persistence, privilege escalation, and lateral movement while evading detection
- **Prevalence:** Identified as leading attack vector in 2024 Verizon DBIR and MITRE Engenuity ATT&CK Evaluations

---

#### **2. T1059 - Command and Scripting Interpreter**
**Risk Level:** High (3/3 groups)

- **Description:** Extensive use of PowerShell, CMD, and Unix shell commands to execute malicious code while avoiding custom malware deployment
- **APT29 Usage:** PowerShell for reconnaissance, lateral movement, and data exfiltration
- **Volt Typhoon Usage:** Living off the Land techniques using built-in Windows tools (PowerShell, WMI, netsh)
- **APT33 Usage:** Scripting for reconnaissance and data exfiltration
- **Impact:** Enables execution of malicious code without deploying detectable malware binaries
- **Detection Challenge:** Legitimate administrative tools make behavioral detection difficult

---

#### **3. T1003 - OS Credential Dumping**
**Risk Level:** High (3/3 groups)

- **Description:** All three groups dump credentials from LSASS memory, SAM databases, and cached domain credentials to escalate privileges and enable lateral movement
- **APT29 Usage:** Custom tools to extract credentials while evading detection, maintaining persistence
- **Volt Typhoon Usage:** Credential dumping to support lateral movement across critical infrastructure
- **APT33 Usage:** LSASS memory and SAM database credential extraction
- **Impact:** Enables privilege escalation and lateral movement to high-value targets (domain controllers, file servers, cloud consoles)
- **Attack Path:** Initial access → credential dumping → privilege escalation → lateral movement → domain compromise

---

#### **4. T1027 - Obfuscated Files or Information**
**Risk Level:** High (3/3 groups)

- **Description:** Use of encoding (Base64), packing, and obfuscation techniques to hide malicious scripts and payloads from security tools
- **APT29 Usage:** Advanced obfuscation to evade endpoint detection and response (EDR) tools
- **Volt Typhoon Usage:** Obfuscation of PowerShell scripts and command-line arguments
- **APT33 Usage:** Encoding and packing to hide malicious payloads
- **Impact:** Evades signature-based detection and static analysis tools
- **Detection Challenge:** Requires behavioral analysis and deobfuscation capabilities

---

#### **5. T1105 - Ingress Tool Transfer**
**Risk Level:** High (3/3 groups)

- **Description:** After establishing initial access, all three APT groups download additional tools, scripts, and malware from external servers
- **APT29 Usage:** Deploy custom backdoors and persistence mechanisms following system compromise
- **Volt Typhoon Usage:** Transfer Living off the Land binaries and scripts to maintain operational capabilities
- **APT33 Usage:** Download additional malware families for espionage and destructive operations
- **Impact:** Allows adversaries to maintain minimal footprint while retaining ability to escalate attack operations
- **Detection Opportunity:** Network-based detection of unusual file transfers and outbound connections

---

### **Moderate-Risk Techniques (Used by 2/3 APT Groups)**

| Technique ID | Technique Name | APT Groups | Description |
|--------------|----------------|------------|-------------|
| **T1566** | Phishing | APT29, APT33 | Primary initial access vector via spear-phishing and fake job recruitment lures |
| **T1090** | Proxy | APT29, Volt Typhoon | Route C2 traffic through intermediary systems to hide attack origin |
| **T1110** | Brute Force | APT29, APT33 | Password spraying against cloud authentication portals and VPN gateways |
| **T1021** | Remote Services | APT29, APT33 | Abuse RDP and SMB protocols for lateral movement |
| **T1082** | System Information Discovery | Volt Typhoon, APT29 | Enumerate system configurations, installed software, network topology |

**Additional Moderate-Risk Techniques:** 14 techniques identified - see [MITRE ATT&CK Navigator Layer](./mitre-attack/consolidated-navigator-layer.json) for complete list

---

### **Low-Risk Techniques (Used by 1/3 APT Groups)**

| Technique ID | Technique Name | APT Group | Description |
|--------------|----------------|-----------|-------------|
| **T1485** | Data Destruction | APT33 | Disk-wiping malware for destructive operations |
| **T1195** | Supply Chain Compromise | APT29 | SolarWinds supply chain attack (2020) |
| **T1190** | Exploit Public-Facing Application | Volt Typhoon | Primary initial access method for critical infrastructure targeting |

---

## Plan of Action & Milestones (POA&M)

### **Priority 1: Valid Accounts (T1078) - IMMEDIATE ACTION**

**Mitigation Timeline:** 0-30 days

**Defensive Countermeasures (MITRE D3FEND):**
- **D3-MFA:** Deploy phishing-resistant multi-factor authentication (FIDO2 hardware security keys) for all access points
- **D3-AZPE:** Implement Azure AD Conditional Access policies with device compliance requirements
- **D3-LAM:** Enforce strict least-privilege access policies to limit impact of compromised credentials
- **D3-SAML:** Monitor for Golden SAML token forgery attempts in cloud environments

**Implementation Steps:**
1. Deploy FIDO2 hardware security keys to all privileged users (Week 1-2)
2. Enforce phishing-resistant MFA for all cloud authentication portals (Week 2-3)
3. Implement Conditional Access policies requiring compliant devices (Week 3-4)
4. Audit and reduce privileged account permissions (Ongoing)

**Success Metrics:**
- 100% of privileged accounts protected with FIDO2 MFA
- 90% reduction in successful credential-based attacks
- Zero Golden SAML token forgery attempts successful

---

### **Priority 2: Command and Scripting Interpreter (T1059) - IMMEDIATE ACTION**

**Mitigation Timeline:** 0-60 days

**Defensive Countermeasures (MITRE D3FEND):**
- **D3-PSA:** Enable PowerShell Constrained Language Mode to restrict dangerous cmdlets
- **D3-SBL:** Implement comprehensive PowerShell Script Block Logging
- **D3-EDR:** Deploy EDR with behavioral detection for anomalous script execution
- **D3-AL:** Implement application whitelisting (AppLocker/WDAC) to restrict script execution

**Implementation Steps:**
1. Enable PowerShell Script Block Logging across all Windows endpoints (Week 1)
2. Deploy PowerShell Constrained Language Mode on non-administrative systems (Week 2-3)
3. Configure EDR to detect suspicious PowerShell, WMI, and command-line activity (Week 3-4)
4. Implement application whitelisting policies (Week 4-8)

**Success Metrics:**
- 100% of PowerShell execution logged and monitored
- 80% reduction in unauthorized script execution
- EDR detection of Living off the Land techniques within 5 minutes

---

### **Priority 3: OS Credential Dumping (T1003) - HIGH PRIORITY**

**Mitigation Timeline:** 30-90 days

**Defensive Countermeasures (MITRE D3FEND):**
- **D3-CG:** Deploy Windows Credential Guard to protect LSASS memory
- **D3-LAPS:** Implement Local Administrator Password Solution (LAPS) for local admin accounts
- **D3-EDR:** Configure EDR to detect LSASS memory access and credential dumping tools
- **D3-PAM:** Deploy Privileged Access Management (PAM) solution for credential vaulting

**Implementation Steps:**
1. Enable Credential Guard on all Windows 10/11 and Server 2016+ systems (Week 1-4)
2. Deploy LAPS across all domain-joined workstations and servers (Week 2-6)
3. Configure EDR to alert on LSASS memory access (Week 4-8)
4. Implement PAM solution for privileged credential management (Week 8-12)

**Success Metrics:**
- 100% of endpoints protected with Credential Guard
- Zero successful LSASS credential dumps
- 100% of privileged credentials managed through PAM

---

### **Priority 4: Obfuscated Files or Information (T1027) - HIGH PRIORITY**

**Mitigation Timeline:** 30-90 days

**Defensive Countermeasures (MITRE D3FEND):**
- **D3-DA:** Deploy deobfuscation and dynamic analysis capabilities
- **D3-EDR:** Configure EDR with behavioral detection for obfuscated scripts
- **D3-NTA:** Implement network traffic analysis to detect encoded payloads
- **D3-SB:** Deploy sandbox environment for automated malware detonation

**Implementation Steps:**
1. Deploy EDR with behavioral analysis for obfuscated PowerShell (Week 1-4)
2. Implement automated sandbox for suspicious file analysis (Week 4-8)
3. Configure network traffic analysis for Base64-encoded payloads (Week 6-10)
4. Train SOC analysts on deobfuscation techniques (Week 8-12)

**Success Metrics:**
- 90% of obfuscated scripts detected before execution
- Automated sandbox analysis of 100% of suspicious files
- SOC analyst proficiency in manual deobfuscation

---

### **Priority 5: Ingress Tool Transfer (T1105) - MODERATE PRIORITY**

**Mitigation Timeline:** 60-120 days

**Defensive Countermeasures (MITRE D3FEND):**
- **D3-NF:** Implement egress filtering and proxy controls to restrict outbound connections
- **D3-IPS:** Deploy network-based intrusion prevention systems (IPS) to block tool downloads
- **D3-NTA:** Monitor for unusual file transfers using network traffic analysis
- **D3-TI:** Integrate threat intelligence feeds to block known malicious infrastructure

**Implementation Steps:**
1. Implement egress filtering to block connections to known malicious IPs (Week 1-4)
2. Deploy IPS signatures for common tool transfer patterns (Week 4-8)
3. Configure network traffic analysis for unusual file downloads (Week 6-10)
4. Integrate threat intelligence feeds into firewall and proxy (Week 8-12)

**Success Metrics:**
- 95% of tool transfer attempts blocked at network perimeter
- 100% of unusual file transfers detected and investigated
- Threat intelligence integration with <1 hour latency

---

## Project Artifacts

- **[Full APT Threat Analysis Report (PDF)](./reports/apt-threat-analysis_full-report.pdf)** - Comprehensive analysis of all three APT groups with detailed TTP mapping
- **[Executive Summary (PDF)](./reports/apt-threat-analysis_executive-summary.pdf)** - High-level overview for executive leadership and non-technical stakeholders
- **[MITRE ATT&CK Navigator Layer (JSON)](./mitre-attack/consolidated-navigator-layer.json)** - Import into [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) to visualize consolidated threat landscape
- **[Consolidated Techniques Spreadsheet (XLSX)](./mitre-attack/consolidated-navigator-layer.xlsx)** - Excel-compatible view of all techniques with risk categorization
- **[POA&M Summary (Markdown)](./findings/poam-summary.md)** - Prioritized mitigation roadmap with implementation timelines

---

## How to Use the MITRE ATT&CK Navigator Layer

1. Go to [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)
2. Click **"Open Existing Layer"** → **"Upload from local"**
3. Select `consolidated-navigator-layer.json` from this repository
4. View the consolidated threat landscape across all three APT groups:
   - **High-Risk techniques** (used by all 3 groups): Pastel Red (#ff6666ff)
   - **Moderate-Risk techniques** (used by 2 groups): Medium-Light Yellow (#ffe766ff)
   - **Low-Risk techniques** (used by 1 group): Default color
5. Right-click on any technique for additional information, references, and mitigation guidance

---

## Skills Demonstrated

✅ **Threat Intelligence Analysis**
- Collection and synthesis of intelligence from authoritative sources (CISA, Microsoft, Mandiant)
- Attribution analysis of nation-state APT groups
- Operational activity tracking and timeline analysis

✅ **MITRE ATT&CK Framework Application**
- Mapping adversary TTPs to MITRE ATT&CK Enterprise framework
- Custom Navigator layer creation with risk-based color coding
- Technique prevalence analysis across multiple threat actors

✅ **Risk Assessment & Prioritization**
- Prevalence-based risk categorization methodology
- Attack path analysis and impact assessment
- Prioritized mitigation roadmap development

✅ **Defensive Countermeasure Mapping**
- MITRE D3FEND defensive technique mapping
- Implementation timeline and resource planning
- Success metrics and measurement criteria

✅ **Technical Writing & Communication**
- Executive summary for non-technical stakeholders
- Detailed technical analysis for security operations teams
- Actionable recommendations with clear implementation steps

✅ **Cybersecurity Frameworks**
- MITRE ATT&CK for Enterprise
- MITRE D3FEND
- NIST Cybersecurity Framework alignment
- CISA cybersecurity guidance integration

---

## Threat Intelligence Sources

**Primary Sources:**
- CISA Cybersecurity Advisory AA21-116A: Russian SVR Targets U.S. and Allied Networks (APT29/SolarWinds)
- CISA/NSA Cybersecurity Advisory AA23-144A: Volt Typhoon Critical Infrastructure Targeting
- Microsoft Threat Intelligence: Midnight Blizzard Campaign (APT29, 2024)
- Microsoft Threat Intelligence: Volt Typhoon Analysis (May 2023)
- Microsoft Threat Intelligence: Peach Sandstorm (APT33, September 2023)
- Mandiant Threat Intelligence: APT33 Targeting Aerospace and Energy Sectors (2017-2024)
- Verizon Data Breach Investigations Report (DBIR) 2024
- MITRE Engenuity ATT&CK Evaluations 2023
- DOJ Press Release: FBI Disrupts Volt Typhoon KV-Botnet (January 2024)

**Frameworks:**
- MITRE ATT&CK for Enterprise (v14)
- MITRE D3FEND
- NIST SP 800-53 Rev. 5
- NIST Cybersecurity Framework

---

## About This Project

This APT threat intelligence analysis was completed as a capstone project for CNG 2057: Network Defense and Countermeasures at Pikes Peak State College (May 2026). The analysis demonstrates practical application of threat intelligence collection, MITRE ATT&CK framework mapping, risk assessment, and defensive countermeasure planning skills required for Security Analyst, Threat Intelligence Analyst, and SOC Analyst roles.

All analysis is based on publicly available threat intelligence from authoritative sources including CISA, Microsoft Threat Intelligence, Mandiant, and U.S. government agencies.

---

*Analysis Completed: May 2026*  
*Frameworks: MITRE ATT&CK, MITRE D3FEND, NIST CSF*  
*APT Groups: APT29 (Russia), Volt Typhoon (China), APT33 (Iran)*
