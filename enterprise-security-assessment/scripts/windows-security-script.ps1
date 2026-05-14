# Windows Security Data Collection Script
# Run as Administrator

$TIMESTAMP = Get-Date -Format "yyyyMMdd_HHMMss"
$OUTPUT_DIR = "C:\security_assessment_$TIMESTAMP"
New-Item -ItemType Directory -Path $OUTPUT_DIR -Force

Write-Host "================================================"
Write-Host "Windows Security Data Collection Script"
Write-Host "Timestamp: $TIMESTAMP"
Write-Host "Output Directory: $OUTPUT_DIR"
Write-Host "================================================"

# 1. Firewall Configurations
Write-Host "`n1. Firewall Configurations"
Get-NetFirewallProfile | Format-Table Name, Enabled > "$OUTPUT_DIR\firewall_profiles.txt"
Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction > "$OUTPUT_DIR\firewall_profile_details.txt"
Get-NetFirewallRule -Direction Inbound -Enabled True | Format-Table DisplayName, Action, Profile > "$OUTPUT_DIR\inbound_firewall_rules.txt"
Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True | Format-Table DisplayName, Profile > "$OUTPUT_DIR\permissive_inbound_rules.txt"

# 2. Authentication Settings
Write-Host "`n2. Authentication Settings"
net accounts > "$OUTPUT_DIR\password_policy.txt"
net user > "$OUTPUT_DIR\local_users.txt"
net localgroup Administrators > "$OUTPUT_DIR\administrators_group.txt"
net user Guest > "$OUTPUT_DIR\guest_account.txt"
net accounts | Select-String "Lockout" > "$OUTPUT_DIR\account_lockout_policy.txt"

# 3. Service Configurations
Write-Host "`n3. Service Configurations"
Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table Name, DisplayName > "$OUTPUT_DIR\running_services.txt"
netstat -an | findstr LISTENING > "$OUTPUT_DIR\listening_ports.txt"

# Check IIS configurations if present
if (Test-Path "C:\inetpub\wwwroot") {
    Write-Host "IIS configuration found"
    Get-IISSite > "$OUTPUT_DIR\iis_sites.txt"
    Import-Module WebAdministration
    Get-ChildItem IIS:\AppPools | Select-Object Name, State, @{N='Identity';E={$_.processModel.identityType}} > "$OUTPUT_DIR\iis_app_pools.txt"
    Get-WebConfigurationProperty -Filter /system.webServer/directoryBrowse -PSPath "IIS:\Sites\Default Web Site" -Name enabled > "$OUTPUT_DIR\iis_directory_browsing.txt"
    Get-WebConfigurationProperty -Filter /system.webServer/httpProtocol/customHeaders -PSPath "IIS:\Sites\Default Web Site" -Name Collection > "$OUTPUT_DIR\iis_custom_headers.txt"
    Test-Path "C:\inetpub\wwwroot\iisstart.htm" > "$OUTPUT_DIR\iis_default_page.txt"
    Get-ChildItem IIS:\SslBindings > "$OUTPUT_DIR\iis_ssl_bindings.txt"
    Get-WebConfigurationProperty -Filter /system.webServer/security/authentication/anonymousAuthentication -PSPath "IIS:\Sites\Default Web Site" -Name enabled > "$OUTPUT_DIR\iis_anonymous_auth.txt"
    Get-WebConfigurationProperty -Filter /system.webServer/security/authentication/basicAuthentication -PSPath "IIS:\Sites\Default Web Site" -Name enabled > "$OUTPUT_DIR\iis_basic_auth.txt"
}

# Check Active Directory configurations if present
if (Get-Command Get-ADDomain -ErrorAction SilentlyContinue) {
    Write-Host "Active Directory configuration found"
    Get-ADDefaultDomainPasswordPolicy > "$OUTPUT_DIR\ad_password_policy.txt"
    Get-ADUser -Filter * -Properties * | Select-Object Name, SamAccountName, Enabled, PasswordNeverExpires, PasswordNotRequired, LastLogonDate, WhenCreated > "$OUTPUT_DIR\ad_users.txt"
    Get-ADUser -Filter {PasswordNeverExpires -eq $true} | Select-Object Name, SamAccountName > "$OUTPUT_DIR\ad_users_password_never_expires.txt"
    Get-ADUser -Filter {PasswordNotRequired -eq $true} | Select-Object Name, SamAccountName > "$OUTPUT_DIR\ad_users_password_not_required.txt"
    Get-ADUser -Filter {Enabled -eq $false} | Select-Object Name, SamAccountName > "$OUTPUT_DIR\ad_disabled_users.txt"
    Get-ADGroupMember "Domain Admins" | Select-Object Name, SamAccountName, objectClass > "$OUTPUT_DIR\domain_admins.txt"
    Get-ADGroupMember "Enterprise Admins" | Select-Object Name, SamAccountName, objectClass > "$OUTPUT_DIR\enterprise_admins.txt"
    Get-ADUser -Identity Guest -Properties Enabled | Select-Object Name, Enabled > "$OUTPUT_DIR\ad_guest_account.txt"
    Get-ADUser -Identity Administrator -Properties * | Select-Object Name, Enabled, PasswordLastSet, PasswordNeverExpires > "$OUTPUT_DIR\ad_administrator_account.txt"
    Get-ADDefaultDomainPasswordPolicy | Select-Object LockoutThreshold, LockoutDuration, LockoutObservationWindow > "$OUTPUT_DIR\ad_account_lockout_policy.txt"
    Get-DnsServerZone | Select-Object ZoneName, ZoneType, DynamicUpdate > "$OUTPUT_DIR\dns_zones.txt"
    Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" -Name "LDAPServerIntegrity" -ErrorAction SilentlyContinue > "$OUTPUT_DIR\ldap_signing.txt"
    Get-SmbServerConfiguration | Select-Object EnableSMBSigning, RequireSecuritySignature > "$OUTPUT_DIR\smb_signing.txt"
    Get-SmbShareAccess -Name SYSVOL > "$OUTPUT_DIR\sysvol_permissions.txt"
    Get-SmbShareAccess -Name NETLOGON > "$OUTPUT_DIR\netlogon_permissions.txt"
}

# 4. Network Protocol Information
Write-Host "`n4. Network Protocol Information"
Get-NetIPConfiguration | Select-Object InterfaceAlias, IPAddress, DefaultGateway, DNSServer > "$OUTPUT_DIR\network_interfaces.txt"
Get-NetRoute -AddressFamily IPv4 > "$OUTPUT_DIR\routing_table.txt"
Get-DnsClientCache > "$OUTPUT_DIR\dns_cache.txt"

# 5. User Accounts and Permissions
Write-Host "`n5. User Accounts and Permissions"
Get-Acl "C:\inetpub\wwwroot" | Format-List > "$OUTPUT_DIR\iis_directory_permissions.txt"
icacls "C:\inetpub\wwwroot" > "$OUTPUT_DIR\iis_directory_icacls.txt"
Get-ChildItem IIS:\AppPools | Select-Object Name, @{N='Identity';E={$_.processModel.identityType}} > "$OUTPUT_DIR\iis_app_pool_identities.txt"

# 6. Patch Levels
Write-Host "`n6. Patch Levels"
Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 5 > "$OUTPUT_DIR\installed_updates.txt"
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" > "$OUTPUT_DIR\os_version.txt"
if (Get-Command Get-ADDomainController -ErrorAction SilentlyContinue) {
    Get-ADDomainController -Filter * | Select-Object Name, OSVersion > "$OUTPUT_DIR\domain_controller_version.txt"
}

Write-Host "`n================================================"
Write-Host "Data Collection Complete"
Write-Host "All output saved to: $OUTPUT_DIR"
Write-Host "================================================"
