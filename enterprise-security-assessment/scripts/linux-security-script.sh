#!/bin/bash

# Linux Security Data Collection Script
# Run as root or with sudo

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="/home/playerone/security_assessment_${TIMESTAMP}"
mkdir -p $OUTPUT_DIR

echo "================================================"
echo "Linux Security Data Collection Script"
echo "Timestamp: $TIMESTAMP"
echo "Output Directory: $OUTPUT_DIR"
echo "================================================"

# 1. Firewall Configurations
echo -e "\n1. Firewall Configurations"
systemctl status firewalld 2>/dev/null || systemctl status iptables 2>/dev/null || systemctl status ufw 2>/dev/null > $OUTPUT_DIR/firewall_status.txt
iptables -L -n -v 2>/dev/null > $OUTPUT_DIR/iptables_rules.txt
ufw status 2>/dev/null > $OUTPUT_DIR/ufw_status.txt

# 2. Authentication Settings
echo -e "\n2. Authentication Settings"
cat /etc/ssh/sshd_config | grep -i -E "PermitRootLogin|PasswordAuthentication|PermitEmptyPasswords|MaxAuthTries|Protocol" > $OUTPUT_DIR/ssh_config.txt
cat /etc/login.defs | grep -i -E "PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_MIN_LEN|PASS_WARN_AGE" > $OUTPUT_DIR/password_policy.txt
cat /etc/pam.d/system-auth 2>/dev/null || cat /etc/pam.d/common-password 2>/dev/null > $OUTPUT_DIR/pam_config.txt
awk -F: '($2 == "" || $2 == "!") {print $1}' /etc/shadow > $OUTPUT_DIR/empty_passwords.txt
cat /etc/passwd | grep -v nologin | grep -v /bin/false > $OUTPUT_DIR/user_accounts.txt
cat /etc/sudoers 2>/dev/null > $OUTPUT_DIR/sudoers.txt
cat /etc/sudoers.d/* 2>/dev/null > $OUTPUT_DIR/sudoers_d.txt

# 3. Service Configurations
echo -e "\n3. Service Configurations"
systemctl list-units --type=service --state=running > $OUTPUT_DIR/running_services.txt
ss -tlnp > $OUTPUT_DIR/listening_ports.txt
# or
netstat -tlnp > $OUTPUT_DIR/listening_ports_netstat.txt

# Check Apache/MySQL configurations if present
if [ -f /etc/apache2/apache2.conf ] || [ -f /etc/httpd/conf/httpd.conf ]; then
    echo "Apache configuration found"
    cat /etc/apache2/apache2.conf 2>/dev/null || cat /etc/httpd/conf/httpd.conf 2>/dev/null > $OUTPUT_DIR/apache_config.txt
    grep -r "Options" /etc/apache2/ 2>/dev/null || grep -r "Options" /etc/httpd/ 2>/dev/null > $OUTPUT_DIR/apache_options.txt
    grep -r -i "ServerTokens\|ServerSignature" /etc/apache2/ 2>/dev/null || grep -r -i "ServerTokens\|ServerSignature" /etc/httpd/ 2>/dev/null > $OUTPUT_DIR/apache_server_tokens.txt
    apache2ctl -M 2>/dev/null || httpd -M 2>/dev/null > $OUTPUT_DIR/apache_modules.txt
    apache2 -v 2>/dev/null || httpd -v 2>/dev/null > $OUTPUT_DIR/apache_version.txt
fi

if [ -f /etc/mysql/my.cnf ] || [ -f /etc/my.cnf ]; then
    echo "MySQL configuration found"
    cat /etc/mysql/my.cnf 2>/dev/null || cat /etc/my.cnf 2>/dev/null > $OUTPUT_DIR/mysql_config.txt
    grep -r "bind-address" /etc/mysql/ 2>/dev/null || grep -r "bind-address" /etc/my.cnf 2>/dev/null > $OUTPUT_DIR/mysql_bind_address.txt
    grep -r "character-set-server" /etc/mysql/ 2>/dev/null || grep -r "character-set-server" /etc/my.cnf 2>/dev/null > $OUTPUT_DIR/mysql_charset.txt
    grep -r "sql_mode" /etc/mysql/ 2>/dev/null || grep -r "sql_mode" /etc/my.cnf 2>/dev/null > $OUTPUT_DIR/mysql_sql_mode.txt
fi

# 4. Network Protocol Information
echo -e "\n4. Network Protocol Information"
ip a > $OUTPUT_DIR/network_interfaces.txt
route -n > $OUTPUT_DIR/routing_table.txt
cat /etc/resolv.conf > $OUTPUT_DIR/dns_config.txt

# 5. User Accounts and Permissions
echo -e "\n5. User Accounts and Permissions"
ls -la /etc/shadow > $OUTPUT_DIR/shadow_perms.txt
ls -la /etc/passwd > $OUTPUT_DIR/passwd_perms.txt
ls -la /etc/sudoers > $OUTPUT_DIR/sudoers_perms.txt
find / -perm -4000 -type f 2>/dev/null > $OUTPUT_DIR/suid_binaries.txt

# 6. Patch Levels
echo -e "\n6. Patch Levels"
apt list --installed 2>/dev/null || yum list installed 2>/dev/null > $OUTPUT_DIR/installed_packages.txt
apt update && apt list --upgradable 2>/dev/null || yum check-update 2>/dev/null > $OUTPUT_DIR/available_updates.txt
uname -a > $OUTPUT_DIR/kernel_version.txt
systemctl status unattended-upgrades 2>/dev/null > $OUTPUT_DIR/automatic_updates.txt
cat /etc/yum/yum-cron.conf 2>/dev/null > $OUTPUT_DIR/yum_cron_config.txt

echo -e "\n================================================"
echo "Data Collection Complete"
echo "All output saved to: $OUTPUT_DIR"
echo "================================================"
