﻿<# 
    .NOTES 
    -------------------------------------------------------------------------------- 
     Code generated by: SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.136 
     Generated on: 3/28/2017 2:17 PM 
     Generated by: davisn1 
    -------------------------------------------------------------------------------- 
    .DESCRIPTION 
        Script generated by PowerShell Studio 2017 
#>


<#	
 =========================================================================== 
  Created with: SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.136 
  Created on: 3/28/2017 1:57 PM 
  Created by: Nathan Davis 
  Organization: 
  Filename: Get-Freq-User.psm1 
 ------------------------------------------------------------------------- 
  Module Name: Get-Freq-User 
 =========================================================================== 
#>



function Get-Freq-User
{

param (
[Parameter(Mandatory = $False, Position = 1)]
[alias("CN")]
[string]$computerName = $env:computername,

#Last number of logins to check
[Parameter(Mandatory = $False)]
[alias("new")]
[int]$newest = 20
)


#Translate User SID to readable string
$UserProperty = @{ n = "User"; e = { ((New-Object System.Security.Principal.SecurityIdentifier $_.ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])).ToString() } }
#Querry Event logs for last 20 login/outs
$logs = Get-EventLog System -Source Microsoft-Windows-Winlogon -ComputerName $ComputerName -newest $newest | select $UserProperty

#Sort users by number of logins/outs, grab the user with the most
$logs = $logs | Group-Object user | Sort Count | Select -First 1 | Select-Object -Property Name | Out-String
$index = $logs.indexOf("\") + 1

return $logs.substring($index) -replace '\s', ''
}

