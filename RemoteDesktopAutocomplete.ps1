 function rdp {
param([ValidateSet("old_www_box","dev.fpweb.net","ampdev.net","www1","www2", "mercury.fpweb.net")][string]$server)

$the_server = $server # $server can only be one of set values.

if($server -eq “www1”) { $the_server = “172.27.0.53” }
if($server -eq “www2”) { $the_server = “172.27.0.67” }
if($server -eq “old_www_box”) { $the_server = “204.144.122.42” }
Start-RDP $the_server 
}

 
Function Start-RDP ($computername)
{
    Start-Process "$env:windir\system32\mstsc.exe" -ArgumentList "/v:$computername"
}

