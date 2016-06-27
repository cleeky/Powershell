Function GetInPutForm{
    $Form = New-Object System.Windows.Forms.Form          #creating the form (this will be the "primary" window)
    $Form.Size = New-Object System.Drawing.Size(420,370)  #the size in px of the window length, height
    $Form.StartPosition = "CenterScreen"                  #loads the window in the center of the screen
    $Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow #modifies the window border
    $Form.Text = "Network Backup tool" #window description

    $groupBox1 = New-Object System.Windows.Forms.GroupBox
    $groupBox1.Location = New-Object System.Drawing.Size(10,10) 
    $groupBox1.size = New-Object System.Drawing.Size(300,50) 
    $groupBox1.text = "Backup Option" 
    $Form.Controls.Add($groupBox1)

    $groupBox2 = New-Object System.Windows.Forms.GroupBox
    $groupBox2.Location = New-Object System.Drawing.Size(10,70) 
    $groupBox2.size = New-Object System.Drawing.Size(300,85) 
    $groupBox2.text = "Select Required Backup Types"
    $groupBox2.Enabled=$false
    $Form.Controls.Add($groupBox2)

    $groupBox3 = New-Object System.Windows.Forms.GroupBox
    $groupBox3.Location = New-Object System.Drawing.Size(10,165)
    $groupBox3.Size = New-Object System.Drawing.Size(300,50)
    $groupBox3.text = "BackupLocation"
    $Form.Controls.Add($groupBox3) 

    $MasterPCRB = New-Object System.Windows.Forms.RadioButton 
    $MasterPCRB.Location = new-object System.Drawing.Size(150,20) 
    $MasterPCRB.size = New-Object System.Drawing.Size(100,20)
    $MasterPCRB.Add_Click({SetBackupPath}) 
    $MasterPCRB.Text = "Master PC"
    $MasterPCRB.Checked = $false 
    $groupBox3.Controls.Add($MasterPCRB)

    $NetworkRB = New-Object System.Windows.Forms.RadioButton 
    $NetworkRB.Location = new-object System.Drawing.Size(20,20) 
    $NetworkRB.size = New-Object System.Drawing.Size(100,20)
    $NetworkRB.Add_Click({SetBackupPath}) 
    $NetworkRB.Checked = $True
    $NetworkRB.Text = "Network Drive" 
    $groupBox3.Controls.Add($NetworkRB)

    $FullbackupRB = New-Object System.Windows.Forms.RadioButton 
    $FullbackupRB.Location = new-object System.Drawing.Size(20,20) 
    $FullbackupRB.size = New-Object System.Drawing.Size(100,20) 
    $FullbackupRB.Checked = $true 
    $FullbackupRB.Add_Click({$groupBox2.Enabled=$false})
    $FullbackupRB.Text = "Full Backup" 
    $groupBox1.Controls.Add($FullbackupRB)

    $FileBackupRB = New-Object System.Windows.Forms.RadioButton 
    $FileBackupRB.Location = new-object System.Drawing.Point(150,20) 
    $FileBackupRB.size = New-Object System.Drawing.Size(180,20) 
    $FileBackupRB.Add_Click({$groupBox2.Enabled=$true}) 
    $FileBackupRB.Text = "Selected Backup" 
    $groupBox1.Controls.Add($FileBackupRB)

    $docFiles = New-Object System.Windows.Forms.checkbox
    $docFiles.Location = New-Object System.Drawing.Size(10,20)
    $docFiles.Size = New-Object System.Drawing.Size(200,20)
    $docFiles.Text = "Word [.Doc(x)]"
    $groupBox2.Controls.Add($docFiles)

    $xlsFiles = New-Object System.Windows.Forms.checkbox
    $xlsFiles.Location = New-Object System.Drawing.Size(10,40)
    $xlsFiles.Size = New-Object System.Drawing.Size(200,20)
    $xlsFiles.Text = "Excel [.xls(x)]"
    $groupBox2.Controls.Add($xlsFiles)

    $pptFiles = New-Object System.Windows.Forms.checkbox
    $pptFiles.Location = New-Object System.Drawing.Size(10,60)
    $pptFiles.Size = New-Object System.Drawing.Size(200,20)
    $pptFiles.Text = "Power Point [.ppt(x)]"
    $groupBox2.Controls.Add($pptFiles)

    $SourceLabel = New-Object System.Windows.forms.Label
    $SourceLabel.Location = New-Object System.Drawing.Size(10,220)
    $SourceLabel.text = "Enter the Source Path below:"
    $SourceLabel.Autosize = $true
    $Form.Controls.Add($SourceLabel)

    $SourcePath = New-Object System.Windows.Forms.TextBox
    $SourcePath.Location = New-Object System.Drawing.Size(10,240)
    $SourcePath.Size = New-Object System.Drawing.Size(300,20)
    $SourcePath.Text =$SourceFolder
    $Form.Controls.Add($SourcePath)

    $DestentionLabel = New-Object System.Windows.forms.Label
    $DestentionLabel.Location = new-object System.Drawing.Size(10,270)
    $DestentionLabel.text = "Destention Path:"
    $DestentionLabel.Autosize = $true
    $Form.Controls.Add($DestentionLabel)

    $DestentionPath = New-Object System.Windows.Forms.TextBox
    $DestentionPath.Location = New-Object System.Drawing.Size(10,290)
    $DestentionPath.Size = New-Object System.Drawing.Size(300,20)
    $DestentionPath.Text =$DestentionFolder
    $Form.Controls.Add($DestentionPath)

    $BackupButton = New-Object System.Windows.Forms.Button
    $BackupButton.Location = New-Object System.Drawing.Size(320,80)
    $BackupButton.Size = New-Object System.Drawing.Size(75,23)
    $BackupButton.Text = "Backup"
    $BackupButton.Add_Click({ProcessInput})
    $Form.Controls.Add($BackupButton)

    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Size(320,110)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = "Cancel"
    $CancelButton.Add_Click({$Form.close(); $Form.Dispose();$global:CancelButton=$true})
    $Form.Controls.Add($CancelButton)

    $Form.Add_Shown({$Form.Activate()})
    [void] $Form.ShowDialog()   #activating the form
}
Function SetBackupPath{
   if($MasterPCRB.Checked -eq $true){
       if($env:USERNAME.ToUpper() -eq "COLIN") { $DestentionPath.Text = "Q:\ColinData Backup"}
       elseif ($env:USERNAME.ToUpper() -eq "ASIA") { $DestentionPath.Text = "Q:\AsiaData Backup"}
       else{$DestentionFolder=""}
   }
   if($NetworkRB.Checked -eq $true){
       if($env:USERNAME.ToUpper() -eq "COLIN") { $DestentionPath.Text = "F:\ColinData Backup"}
       elseif ($env:USERNAME.ToUpper() -eq "ASIA") { $DestentionPath.Text = "F:\AsiaData Backup"}
       else{$DestentionPath.Text =""}
   }
   $form.Update()
       $form.Refresh()
}
Function Show-MessageBox{
  <#
    .SYNOPSIS 
      Displays a MessageBox using Windows WinForms
	  
	.Description
	  	This function helps display a custom Message box with the options to set
	  	what Icons and buttons to use. By Default without using any of the optional
	  	parameters you will get a generic message box with the OK button.
	  
	.Parameter Msg
		Mandatory: This item is the message that will be displayed in the body
		of the message box form.
		Alias: M

	.Parameter Title
		Optional: This item is the message that will be displayed in the title
		field. By default this field is blank unless other text is specified.
		Alias: T

	.Parameter OkCancel
		Optional:This switch will display the Ok and Cancel buttons.
		Alias: OC

	.Parameter AbortRetryIgnore
		Optional:This switch will display the Abort Retry and Ignore buttons.
		Alias: ARI

	.Parameter YesNoCancel
		Optional: This switch will display the Yes No and Cancel buttons.
		Alias: YNC

	.Parameter YesNo
		Optional: This switch will display the Yes and No buttons.
		Alias: YN

	.Parameter RetryCancel
		Optional: This switch will display the Retry and Cancel buttons.
		Alias: RC

	.Parameter Critical
		Optional: This switch will display Windows Critical Icon.
		Alias: C

	.Parameter Question
		Optional: This switch will display Windows Question Icon.
		Alias: Q

	.Parameter Warning
		Optional: This switch will display Windows Warning Icon.
		Alias: W

	.Parameter Informational
		Optional: This switch will display Windows Informational Icon.
		Alias: I

	.Parameter TopMost
		Optional: This switch will make the form stay on top until the user answers it.
		Alias: TM	
		
	.Example
		Show-MessageBox -Msg "This is the default message box"
		
		This example creates a generic message box with no title and just the 
		OK button.
	
	.Example
		$A = Show-MessageBox -Msg "This is the default message box" -YN -Q
		
		if ($A -eq "YES" ) 
		{
			..do something 
		} 
		else 
		{ 
		 ..do something else 
		} 

		This example creates a msgbox with the Yes and No button and the
		Question Icon. Once the message box is displayed it creates the A varible
		with the message box selection choosen.Once the message box is done you 
		can use an if statement to finish the script.
		
	.Notes
		Created By Zachary Shupp
		Email zach.shupp@hp.com		

		Version: 1.0
		Date: 9/23/2013
		Purpose/Change:	Initial function development

		Version 1.1
		Date: 12/13/2013
		Purpose/Change: Added Switches for the form Type and Icon to make it easier to use.

		Version 1.2
		Date: 3/4/2015
		Purpose/Change: Added Switches to make the message box the top most form.
						Corrected Examples
		
	.Link
		http://msdn.microsoft.com/en-us/library/system.windows.forms.messagebox.aspx
		
  #>


	Param(
	[Parameter(Mandatory=$True)][Alias('M')][String]$Msg,
	[Parameter(Mandatory=$False)][Alias('T')][String]$Title = "",
	[Parameter(Mandatory=$False)][Alias('OC')][Switch]$OkCancel,
	[Parameter(Mandatory=$False)][Alias('OCI')][Switch]$AbortRetryIgnore,
	[Parameter(Mandatory=$False)][Alias('YNC')][Switch]$YesNoCancel,
	[Parameter(Mandatory=$False)][Alias('YN')][Switch]$YesNo,
	[Parameter(Mandatory=$False)][Alias('RC')][Switch]$RetryCancel,
	[Parameter(Mandatory=$False)][Alias('C')][Switch]$Critical,
	[Parameter(Mandatory=$False)][Alias('Q')][Switch]$Question,
	[Parameter(Mandatory=$False)][Alias('W')][Switch]$Warning,
	[Parameter(Mandatory=$False)][Alias('I')][Switch]$Informational,
    [Parameter(Mandatory=$False)][Alias('TM')][Switch]$TopMost)

	#Set Message Box Style
	IF($OkCancel){$Type = 1}
	Elseif($AbortRetryIgnore){$Type = 2}
	Elseif($YesNoCancel){$Type = 3}
	Elseif($YesNo){$Type = 4}
	Elseif($RetryCancel){$Type = 5}
	Else{$Type = 0}
	
	#Set Message box Icon
	If($Critical){$Icon = 16}
	ElseIf($Question){$Icon = 32}
	Elseif($Warning){$Icon = 48}
	Elseif($Informational){$Icon = 64}
	Else { $Icon = 0 }
	
	#Loads the WinForm Assembly, Out-Null hides the message while loading.
	[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
	
	If ($TopMost)
	{
		#Creates a Form to use as a parent
		$FrmMain = New-Object 'System.Windows.Forms.Form'
		$FrmMain.TopMost = $true
		
		#Display the message with input
		$Answer = [System.Windows.Forms.MessageBox]::Show($FrmMain, $MSG, $TITLE, $Type, $Icon)
		
		#Dispose of parent form
		$FrmMain.Close()
		$FrmMain.Dispose()
	}
	Else
	{
		#Display the message with input
		$Answer = [System.Windows.Forms.MessageBox]::Show($MSG , $TITLE, $Type, $Icon)			
	}
	
	#Return Answer
	Return $Answer
}
Function ProcessInput{
    #Check the Source & Destention Paths are available
    if ($(test-path -Path $SourcePath.Text) -eq $false) {
    Show-MessageBox -Critical -Msg "Source Path Does Not Exists`nPlease verify and try again" -TopMost
    $SourcePath.Focus() = $true
    $Form.TopMost= $True  
    return $False  
    }else{
        $SourceFolder=$SourcePath.Text
    }
    if ($(test-path -Path $DestentionPath.Text) -eq $false) {
    Show-MessageBox -Critical -Msg "Destention Path Does Not Exists`nPlease verify and try again" -TopMost
    $DestentionPath.Focus() = $true
    $Form.TopMost= $True  
    return $False  
    }else{
        $DestentionFolder =$DestentionPath.Text
    }

    # This is where I set the files which needs to be Backed up
    if ($FullbackupRB.Checked -eq $true){
        #All Files of the required type to be backed up
        if ($MasterPCRB.Checked -eq $true){
            $global:ExtnToBackup = '*.*'
        }else{
            $global:ExtnToBackup = '*.doc* *.xls* *.ppt*'
        }
    }
    else
    {
        #Only The selected File Tpes to be selected
        if ($docFiles.Checked){$global:ExtnToBackup =$ExtnToBackup + ' *.doc*'}
        if ($xlsFiles.Checked){$global:ExtnToBackup =$ExtnToBackup + ' *.xls*'}
        if ($pptFiles.Checked){$global:ExtnToBackup =$ExtnToBackup + ' *.ppt*'}
    }
    $form.close()
    $form.Dispose()
}
<#
Main Section of Code from this Point

#>

# Variables
[String] $BackType = ""
[string] $ExtnToBackup = ""
         $ExtnToBackupArray = ""
[String] $DestentionFolder = ""
[String] $SourceFolder = ""
#[Boolean] $GoodToGoFlag
[Boolean] $CancelButton = $false

$SourceFolder = "$env:USERPROFILE\Documents"
$ExtnToBackupArray = 
# Test to see if Powershell can see f: Drive if not mount F Drive for powershell
if($(test-path "f:\") -eq $false){
    New-PSDrive -Name F -PSProvider FileSystem -Root \\READYSHARE\Data | out-null
}
if($(test-path "q:\") -eq $false){
    New-PSDrive -Name Q -PSProvider FileSystem -Root \\MASTER-PC\BackupDrive | out-null
}

if($env:USERNAME.ToUpper() -eq "COLIN") { $DestentionFolder = "F:\ColinData Backup"}
elseif ($env:USERNAME.ToUpper() -eq "ASIA") { $DestentionFolder = "F:\AsiaData Backup"}
else{$DestentionFolder=""}

GetInPutForm
if ($CancelButton) {Exit 0}

$ExtnToBackupArray= ($ExtnToBackup).split(" ") | where-object {$_ -ne " "}


Write-Host "The Curretn Paramters"
Write-Host "Backup Extenstion"
$ExtnToBackupArray
Write-Host "Sourec Path : " $SourceFolder
Write-Host "Dest Path : "  $DestentionFolder
