

[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") 


 


function ShellUtil { 





    $shell = new-object -com shell.application 

    $form = new-object System.Windows.Forms.form 
    $cm = new-object System.Windows.Forms.ContextMenu         
    $mi = new-object System.Windows.Forms.MenuItem         
    $ni = new-object System.Windows.Forms.NotifyIcon         



    # Display "Show Desktop" menu 
    $miToggle = new-object System.Windows.Forms.MenuItem 
    $miToggle.Index = 0 
    $miToggle.Text = "&Show Desktop" 
     
    # Display "Minimize All" menu 
    $miMinAll = new-object System.Windows.Forms.MenuItem 
    $miMinAll.Text = "&Minimize All Windows" 
    $miMinAll.Index = 1 
     
    # Display "Undo Minimize All" menu 
    $miUndoMinAll = new-object System.Windows.Forms.MenuItem 
    $miUndoMinAll.Index = 2 
    $miUndoMinAll.Text = "&Undo Minimize All Windows"; 
     
    # Display "Tray Properties" menu 
    $miTrayProps = new-object System.Windows.Forms.MenuItem 
    $miTrayProps.Index = 3 
    $miTrayProps.Text = "&Tray Properties..." 
     
    # Display "Cascade Windows" menu 
    $miCascade = new-object System.Windows.Forms.MenuItem 
    $miCascade.Index = 4 
    $miCascade.Text = "&Cascade Windows" 
     
    # Display "Tile Horizontally" menu 
    $miTileH = new-object System.Windows.Forms.MenuItem 
    $miTileH.Index = 5 
    $miTileH.Text = "Tile Windows &Horizontally" 
     
    # Display "Tile Vertically" menu 
    $miTileV = new-object System.Windows.Forms.MenuItem 
    $miTileV.Index = 6 
    $miTileV.Text = "Tile Windows &Vertically" 
     
    # Display "BaloonTip" menu 
    $ballontips= new-object System.windows.Forms.MenuItem 
    $ballontips.Index = 7
    $ballontips.Text = "BallonTip" 


    # Display "Exit" menu 
    $miExit = new-object System.windows.Forms.MenuItem 
    $miExit.Index = 10 
    $miExit.Text = "E&xit" 


    $form.contextMenu = $cm         
    $form.contextMenu.MenuItems.Add($miToggle) 
    $form.contextMenu.MenuItems.Add($miMinAll) 
    $form.contextMenu.MenuItems.Add($miUndoMinAll) 
    $form.contextMenu.MenuItems.Add($miTrayProps) 
    $form.contextMenu.MenuItems.Add($miCascade) 
    $form.contextMenu.MenuItems.Add($miTileH) 
    $form.contextMenu.MenuItems.Add($miTileV) 
    $form.contextMenu.MenuItems.Add($ballontips) 
    $form.contextMenu.MenuItems.Add($miExit) 
     
     
    $form.ShowInTaskbar = $False         
    $form.WindowState = "minimized"      
    $form.add_Closing({ $form.ShowInTaskBar = $False }) 

    $ni = $ni         
    $ni.Icon = New-object System.Drawing.Icon("D:\code\icon.ico") 
    $NI.ContextMenu = $cm         
    $NI.Text += "Shell Utility"; 

    $tipTitle = "Bah" 
    $tipText = "Bah" 

    $form.ma
  



    $miToggle.add_Click({  
        $shell.ToggleDesktop() 
        $tipTitle = "Show Desktop" 
        $tipText = "Toggle Desktop..." 
    }) 
    $miMinAll.add_Click({ 
        $shell.MinimizeAll() 
        $tipTitle = "Minimize All..." 
        $tipText = "Minimize All windows..." 
    }) 
    $miUndoMinAll.add_Click({  
        $shell.UndoMinimizeAll()  
        $tipTitle = "Undo minimize all" 
        $tipText = "Undo minimize all" 
    }) 
    $miTrayProps.add_Click({  
        $shell.TrayProperties() 
        $tipTitle = "Display Tray Properties" 
        $tipText = "Modify system tray properties..." 
    }) 
    $miCascade.add_Click({ 
        $shell.CascadeWindows() 
        $tipTitle = "Cascade windows" 
        $tipText = "Cascade all windows" 
    }) 
    $miTileH.add_Click({ 
        $shell.TileHorizontally() 
        $tipTitle = "Tile Horizontally" 
        $tipText = "Tile windows horizontally" 
    }) 
    $miTileV.add_Click({ 
        $shell.TileVertically() 
        $tipTitle = "Tile Vertically" 
        $tipText = "Tile windows vertically" 
    }) 
    $miExit.add_Click({ 
        $form.Close() 
        $NI.visible = $false 
    }) 
     
    

 

    $ni.ShowBalloonTip(0, $tipTitle, $tipText, [System.Windows.Forms.ToolTipIcon]"Info")   
    $NI.Visible = $True 
    $form.showDialog()   
    
  
} 
