
<#

ProcDump Script

#>


#give the process name without exe 
$processName = 'Notepad'

#will get the process id 
$procid=get-process $processName |select -expand id

#set the working directory location of the dump files
$workingDirectory = 'D:\powershell\test\'


#give the location of procdump as it per remote machine
$procdump =  'D:\powershell\procdump.exe'

#give the parameters for procdump then concat with process id 
$arguments = '-accepteula -ma -l  -n 5 ' +$procid

#starts procdump with arguments place the files in working directory 
Start-Process -FilePath $procdump -ArgumentList $arguments -WorkingDirectory $workingDirectory

