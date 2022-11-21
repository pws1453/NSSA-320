Set-NetIPInterface -InterfaceAlias Ethernet -Dhcp Disabled
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 10.0.3.104 -PrefixLength 24 -DefaultGateway 10.0.3.254