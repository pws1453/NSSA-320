$validarg = $args.count -eq 3
if ($validarg)
{
    $ip = $args[0]
    $prefix = $args[1]
    $gateway = $args[2]
    Set-NetIPInterface -InterfaceAlias Ethernet -Dhcp Disabled
    New-NetIPAddress -InterfaceAlias Ethernet -IPAddress $ip -PrefixLength $prefix -DefaultGateway $gateway
    Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses ("127.0.0.1","8.8.8.8")
} else {
    Write-Host "ERROR: Invalid Number of Arguments"
    Write-Host "SYNTAX=================================================="
    Write-Host "Set-StaticIP.ps1 [ip_address] [net_prefix] [def_gateway]"
    throw "SYNTAX ERROR"
}