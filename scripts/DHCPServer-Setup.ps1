Install-WindowsFeature DHCP -IncludeManagementTools
netsh dhcp add securitygroups | Out-Null
Restart-Service dhcpserver


Add-DhcpServerInDC -DnsName central.winnet.local -IPAddress 10.0.3.100
Get-DhcpServerInDC


Add-DhcpServerv4Scope -Name "winnet" -StartRange 10.0.3.240 -EndRange 10.0.3.245 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4OptionValue -ComputerName "central.winnet.local" -ScopeId 10.0.3.0 -DnsServer 8.8.8.8 -Router 10.0.3.1

Add-DhcpServerv4Scope -Name "linnet" -StartRange 10.0.4.240 -EndRange 10.0.4.245 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4OptionValue -ComputerName "central.winnet.local" -ScopeId 10.0.4.0 -DnsServer 8.8.8.8 -Router 10.0.4.1

Restart-Service dhcpserver