Function BallonMessage {
[cmdletbinding()]
Param (
[string] $msg,
[string] $title,
[string]$icon,
[int]$timeout
   )

Write-Host("Call")

[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | out-null
$Balloon = new-object System.Windows.Forms.NotifyIcon
$Balloon.Icon = [System.Drawing.SystemIcons]::Information
$Balloon.Visible = $true;
$Balloon.ShowBalloonTip($timeout, $title, $msg, $icon);
Invoke-Item D:\temp
$Balloon.Dispose()

 }

<#
Unregister-Event $changed.Id
Unregister-Event $created.Id
Unregister-Event $deleted.Id
Unregister-Event $renamed.Id

#>

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "D:\Temp"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$changed = Register-ObjectEvent $watcher "Changed" -Action {
   BallonMessage -msg "File was changed" -title "Changed" -icon "None" -timeout 1
   Write-Host("changed")
}
$created = Register-ObjectEvent $watcher "Created" -Action {
   BallonMessage -msg "File was created" -title "Created" -icon "None" -timeout 1
    Write-Host("created")
}
$deleted = Register-ObjectEvent $watcher "Deleted" -Action {
   BallonMessage -msg "File was Deleted" -title "Deleted" -icon "None" -timeout 1
    Write-Host("deleted")
}
$renamed = Register-ObjectEvent $watcher "Renamed" -Action {
   BallonMessage -msg "File was Renamed" -title "Renamed" -icon "None" -timeout 1
    Write-Host("renamed")
}