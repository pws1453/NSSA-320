
Set-NetIPInterface -InterfaceAlias Ethernet -Dhcp Disabled
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 10.0.3.104 -PrefixLength 24 -DefaultGateway 10.0.3.254
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses ("127.0.0.1","8.8.8.8")

Install-WindowsFeature DHCP -IncludeManagementTools
netsh dhcp add securitygroups | Out-Null
Restart-Service dhcpserver

Add-DhcpServerInDC -DnsName central.winnet.local -IPAddress 10.0.3.104
Get-DhcpServerInDC


Add-DhcpServerv4Scope -Name "winnet" -StartRange 10.0.3.240 -EndRange 10.0.3.245 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4OptionValue -ComputerName "central.winnet.local" -ScopeId 10.0.3.0 -DnsServer 127.0.0.1 -Router 10.0.3.254

Add-DhcpServerv4Scope -Name "linnet" -StartRange 10.0.4.240 -EndRange 10.0.4.245 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4OptionValue -ComputerName "central.winnet.local" -ScopeId 10.0.4.0 -DnsServer 10.0.4.104 -Router 10.0.4.254
