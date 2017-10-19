

# Load Assemblies
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

# Create new Objects
$objForm = New-Object System.Windows.Forms.Form
$objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon 
$objContextMenu = New-Object System.Windows.Forms.ContextMenu
$ExitMenuItem = New-Object System.Windows.Forms.MenuItem
$AddContentMenuItem = New-Object System.Windows.Forms.MenuItem
$PingMenuItem = New-Object System.Windows.Forms.MenuItem

# new Config file is created 
$ConfigFile = "NotifyApp.config"


function Read-Config
{
$objContextMenu.MenuItems.Clear()
If(Test-Path $ConfigFile)
{

$ConfigData = Get-Content $ConfigFile

$i = 0

Foreach($line in $ConfigData)
{

If($line.Length -gt 0)
{

$line = $line.Split(",")

$Name = $line[0]

$FilePath = $line[1]
# Add object from the Config file to the Context Menu with the Build-ContextMenu Function

$objContextMenu | Build-ContextMenu -index $i -text $Name -Action $FilePath

$i++

}

}

}

else

{

Add-ConfigContent

}




# Create the Add Config content Menu Item
$AddContentMenuItem.index = $i+1
$AddContentMenuItem.Text = "Add Shortcuts"
$AddContentMenuItem.add_Click( {Add-ConfigContent} )


# Create an Exit Menu Item
$PingMenuItem.Index = $i+2
$PingMenuItem.Text = "Ping Computers"
$PingMenuItem.add_Click({ 
[System.Windows.MessageBox]::Show('Hello')
}) 

# Create an Exit Menu Item
$ExitMenuItem.Index = $i+3
$ExitMenuItem.Text = "E&xit"
$ExitMenuItem.add_Click({ 
$objForm.Close() 
$objNotifyIcon.visible = $false 
}) 

# Add the Exit and Add Content Menu Items to the Context Menu
$objContextMenu.MenuItems.Add($AddContentMenuItem) | Out-Null
$objContextMenu.MenuItems.Add($PingMenuItem) | Out-Null
$objContextMenu.MenuItems.Add($ExitMenuItem) | Out-Null


}

function new-scriptblock([string]$textofscriptblock)
# Function that converts string to ScriptBlock
{
$executioncontext.InvokeCommand.NewScriptBlock($textofscriptblock)
}

Function Build-ContextMenu
# Function That Creates a ContexMenuItem and adds it to the Contex Menu
{
param ( $index = 0,
$Text,
$Action
)
begin
{
$MyMenuItem = New-Object System.Windows.Forms.MenuItem
}
process 
{
# Assign the Contex Menu Object from the pipeline to the ContexMenu var
$ContextMenu = $_
}
end 
{
# Create the Menu Item
$MyMenuItem.Index = $index
$MyMenuItem.Text = $Text
$scriptAction = $(new-scriptblock "Invoke-Item $Action")
$MyMenuItem.add_Click($scriptAction)
$ContextMenu.MenuItems.Add($MyMenuItem) | Out-Null
}
}

Function Add-ConfigContent
{
$objOpen = New-Object System.Windows.Forms.OpenFileDialog
$objOpen.Title = "Choose files to add"
$objOpen.Multiselect = $true
$objOpen.RestoreDirectory = $true
$objOpen.ShowDialog()
$addFiles = $objOpen.FileNames
foreach($File in $addFiles)
{
$FileName = (Split-Path $file -Leaf).Split(".")[0]
"$FileName,"+[char]34+$File+[char]34 | out-File -FilePath $ConfigFile -Append
}
Read-Config
}

Read-Config

# Assign an Icon to the Notify Icon object
$objNotifyIcon.Icon = "C:\Users\pravi\OneDrive\Pictures\powershell.ico"
$objNotifyIcon.Text = "Context Menu Test"
# Assign the Context Menu
$objNotifyIcon.ContextMenu = $objContextMenu
$objForm.ContextMenu = $objContextMenu

# Control Visibilaty and state of things
$objNotifyIcon.Visible = $true
$objForm.Visible = $false
$objForm.WindowState = "minimized"
$objForm.ShowInTaskbar = $false
$objForm.add_Closing({ $objForm.ShowInTaskBar = $False }) 
# Show the Form - Keep it open 
# This Line must be Last
$objForm.ShowDialog()

#network shares


#event viewer 
#services
#profile folder 
#program data 
#program files 
#common active directory groups 
#websites


#network tools 
#tracert url 
#tracert vdi 
#path ping 
#website ping 
#ipconfig 


#Reboot
#reboot the machine 