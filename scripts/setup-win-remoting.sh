#!/bin/bash
scp Setup-AnsibleRemote.ps1 Administrator@10.0.3.106:/C:/Users/Administrator
scp Set-StaticIP.ps1 Administrator@10.0.3.106:/C:/Users/Administrator
ssh Administrator@10.0.3.106 powershell.exe C:/Users/Administrator/Setup-AnsibleRemote.ps1
ssh Administrator@10.0.3.106 powershell.exe C:/Users/Administrator/Set-StaticIP.ps1