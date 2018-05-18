Get-ItemProperty -Path 'HKLM:\HARDWARE\DESCRIPTION\System\CentralProcessor\0'
Get-ItemProperty -Path 'HKLM:\HARDWARE\DESCRIPTION\System\CentralProcessor\1'
Get-ItemProperty -Path 'HKLM:\SAM\Domains\Account\Users'
Get-ItemProperty -Path 'HKLM:\SOFTWARE\RegisteredApplications'
Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\'
Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU'
Get-ItemProperty -Path 'HKLM:\System\Services\CurrentControlSet\services\Tcpip\Parameters\Interfaces'
Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services'

<#

Recent text files HKEY_USERS\S-1-5-21-[User Identifier]
\Software
\Microsoft\Windows\CurrentVersion\Explorer\Rece
ntDocs\.txt
Recent folders HKEY_USERS\S-1-5-21-[User Identifier]
\Software
\Microsoft\Windows\CurrentVersion\Explorer\Rece
ntDocs\Folder

Most recently
mapped network
HKEY_USERS\S-1-5-21-[User Identifier]
\Software \Microsoft
\Windows\CurrentVersion\Explorer\M

Typed URLs in
Microsoft Internet
Explorer
HKEY_USERS\S-1-5-21-[User Identifier]
\Software\Microsoft\Internet Explorer\TypedURLs
Most recently used
Microsoft Word
files
HKEY_USERS\S-1-5-21-[User Identifier]
\Software \Microsoft\Office \12.0\Word\File MRU
Most recently used
Microsoft Power
Point files
HKEY_USERS\S-1-5-21-[User Identifier]
\Software\Microsoft \Office \12.0\PowerPoint\File
MRU
Most recently used
Microsoft Excel
files
HKEY_USERS\S-1-5-21-[User Identifier]
\Software \Microsoft \Office \12.0\Excel\File MRU



#>