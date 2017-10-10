
<#

Log collection script

#>

Set-StrictMode -Off

$os = Get-WmiObject win32_operatingsystem
$uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
$Display = "Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes" 
 

$CPUInfo = Get-WmiObject Win32_Processor 
$CPUInfoDisplay = "Caption " +$CPUInfo.Caption.ToString()+  " DeviceID " +$CPUInfo.DeviceID.ToString()+ " Manufacturer "+$CPUInfo.Manufacturer.ToString()+" MaxClockSpeed " +$CPUInfo.MaxClockSpeed.ToString()+ " Name " +$CPUInfo.Name.ToString()+ " SocketDesignation " +$CPUInfo.SocketDesignation.ToString()
Write-Output $CPUInfoDisplay
 


$OSInfo = Get-WmiObject Win32_OperatingSystem
$OSInfoDisplay = $OSInfo.SystemDirectory.ToString()+" Organization "+$OSInfo.Organization.toString()+ " BuildNumber " +$OSInfo.BuildNumber.ToString() + " RegisteredUser " +$OSInfo.RegisteredUser.ToString() + " SerialNumber " +$OSInfo.SerialNumber.ToString() + " Version " +$OSInfo.Version.ToString()
Write-Output $OSInfoDisplay
 

$InstalledRAM = Get-WmiObject -Class Win32_ComputerSystem
$inGB = [Math]::Round(($InstalledRAM.TotalPhysicalMemory/ 1GB),2)
Write-Output $inGB

#diskspace
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" |
Select-Object Size,FreeSpace

$disk.Size
$disk.FreeSpace



$excel = New-Object -ComObject excel.application 
$excel.visible = $True
$workbook = $excel.Workbooks.Add()
 


$basicInfo= $workbook.Worksheets.Add()
$basicInfo.Name = 'BasicInfo'

$worksheet = $workbook.WorkSheets.item("BasicInfo") 
$worksheet.activate()  

#sheet 1 
$excel.Range("A1").value = $Display
$excel.Range("A3").value = $CPUInfoDisplay
$excel.Range("A5").value = $OSInfoDisplay
$excel.Range("A7").value = "System Memory " +$inGB.ToString()
$excel.Range("A10").value = "Computer Name " +$env:computername
$excel.Range("A12").value = "Disk Size " +$disk.Size
$excel.Range("A15").value = "Disk Free Spaze " + $disk.FreeSpace

 
 
 $servicesInfo = $workbook.Worksheets.Add()
$servicesInfo.Name = 'Services'


$worksheet = $workbook.WorkSheets.item("Services") 
$worksheet.activate()  

#get service info
$services = Get-Service | select -property name,displayname,status,starttype 
Write-Output $services

$counterService = 1

foreach ( $ser in $services)

{
    
    $excel.Range("A"+$counterService).value = $ser.Name.ToString()
    $excel.Range("B"+$counterService).value = $ser.DisplayName.ToString()
    $excel.Range("C"+$counterService).value = $ser.Status.ToString()
    $excel.Range("D"+$counterService).value = $ser.StartType.ToString()


    $counterService = $counterService + 1

}





$envInfo = $workbook.Worksheets.Add()
$envInfo.Name = 'Enviroment Variables'

$worksheet = $workbook.WorkSheets.item('Enviroment Variables') 
$worksheet.activate()  


$envVars = Get-ChildItem Env:

$counterEnv = 1

foreach ($var in $envVars )
{  
  $excel.Range("A"+$counterEnv).value = $var.Name.ToString()
  $excel.Range("B"+$counterEnv).value = $var.Value.ToString()

  $counterEnv = $counterEnv + 1

}






$tempDirInfo = $workbook.Worksheets.Add()
$tempDirInfo.Name = "Temp Directory Information"

$worksheet = $workbook.WorkSheets.item("Temp Directory Information") 
$worksheet.activate()  


#get temp directory info
$tempSize ="{0:N2} MB" -f ((Get-ChildItem C:\Users\pravi\AppData\Local\Temp -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)



$excel.Range("A1").value = "C:\Users\pravi\AppData\Local\Temp "
$excel.Range("B1").value = "Size " 
$excel.Range("C1").value = $tempSize.ToString()



 




#profile folder
$userProfileDir = Get-ChildItem C:\Users | Select-Object Mode,CreationTime,Name
$counterUserProfile = 1

foreach ($userProfileInfo in $userProfileDir)
{
     $excel.Range("A"+$counterUserProfile).value = $userProfileInfo.Mode
     $excel.Range("B"+$counterUserProfile).value = $userProfileInfo.CreationTime
     $excel.Range("C"+$counterUserProfile).value = $userProfileInfo.Name

}



$processListInfo = $workbook.Worksheets.Add()
$processListInfo.Name = "Process List"


$msPatchesInfo = $workbook.Worksheets.Add()
$msPatchesInfo.Name = "MS Patches"

$defaultPrintersInfo = $workbook.Worksheets.Add()
$defaultPrintersInfo.Name = "Default Printers"

$eventLogAppplicationInfo = $workbook.Worksheets.Add()
$eventLogAppplicationInfo.Name = "EventLog Application"


$eventLogSystemInfo = $workbook.Worksheets.Add()
$eventLogSystemInfo.Name = "EventLog System"
 
$eventLogSetupInfo = $workbook.Worksheets.Add()
$eventLogSetupInfo.Name = "EventLog Setup"
  

$eventLogPortInfo = $workbook.Worksheets.Add()
$eventLogPortInfo.Name = "EventLog Port"










<#












#get process list
get-process



Function Get-MSHotfix 
{ 
    $outputs = Invoke-Expression "wmic qfe list" 
    $outputs = $outputs[1..($outputs.length)] 
     
     
    foreach ($output in $Outputs) { 
        if ($output) { 
            $output = $output -replace 'y U','y-U' 
            $output = $output -replace 'NT A','NT-A' 
            $output = $output -replace '\s+',' ' 
            $parts = $output -split ' ' 
            if ($parts[5] -like "*/*/*") { 
                $Dateis = [datetime]::ParseExact($parts[5], '%M/%d/yyyy',[Globalization.cultureinfo]::GetCultureInfo("en-US").DateTimeFormat) 
            } else { 
                $Dateis = get-date([DateTime][Convert]::ToInt64("$parts[5]", 16))-Format '%M/%d/yyyy' 
            } 
            New-Object -Type PSObject -Property @{ 
                KBArticle = [string]$parts[0] 
                Computername = [string]$parts[1] 
                Description = [string]$parts[2] 
                FixComments = [string]$parts[6] 
                HotFixID = [string]$parts[3] 
                InstalledOn = Get-Date($Dateis)-format "dddd d MMMM yyyy" 
                InstalledBy = [string]$parts[4] 
                InstallDate = [string]$parts[7] 
                Name = [string]$parts[8] 
                ServicePackInEffect = [string]$parts[9] 
                Status = [string]$parts[10] 
            } 
        } 
    } 
} 

Get-MSHotfix|Where-Object {$_.Installedon -gt ((Get-Date).Adddays(-2))}|Select-Object -Property Computername, KBArticle,InstalledOn, HotFixID, InstalledBy|Format-Table


Get-WmiObject -Query " SELECT * FROM Win32_Printer" | Select Name, Default, PortName,Location


#event logs
Get-EventLog  -LogName "Application"
Get-EventLog  -LogName "System"
 
Get-WinEvent -FilterHashtable @{logname = 'setup'; id = 4} | Format-Table timecreated, message -AutoSize -Wrap


 #Add BluePrism
 #Get-EventLog -LogName "BluePrism"


 #Port info
 Get-NetTCPConnection | ft state,l*port, l*address, r*port, r*address –Auto







#>

