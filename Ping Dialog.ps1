[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  #loading the necessary .net libraries (using void to suppress output)

$Form = New-Object System.Windows.Forms.Form    #creating the form (this will be the "primary" window)
$Form.Size = New-Object System.Drawing.Size(600,400)  #the size in px of the window length, height
$Form.StartPosition = "CenterScreen" #loads the window in the center of the screen
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow #modifies the window border
$Form.Text = "Ping GUI tool" #window description

function pingInfo {60
$wks=$InputBox.text; #we're taking the text from the input box into the variable $wks
$pingResult=ping $wks | fl | out-string;  #ping $wks
$outputBox.text=$outputBox.text+"`n"+$pingResult #send the ping results to the output box
                     } #end pingInfo

$InputBox = New-Object System.Windows.Forms.TextBox #creating the text box
$InputBox.Location = New-Object System.Drawing.Size(20,50) #location of the text box (px) in relation to the primary window's edges (length, height)
$InputBox.Size = New-Object System.Drawing.Size(150,20) #the size in px of the text box (length, height)
$Form.Controls.Add($InputBox) #activating the text box inside the primary window

$outputBox = New-Object System.Windows.Forms.TextBox #creating the text box
$outputBox.Location = New-Object System.Drawing.Size(10,150) #location of the text box (px) in relation to the primary window's edges (length, height)
$outputBox.Size = New-Object System.Drawing.Size(565,200) #the size in px of the text box (length, height)
$outputBox.MultiLine = $True #declaring the text box as multi-line
$outputBox.ScrollBars = "Vertical" #adding scroll bars if required
$outputBox.Font = New-Object System.Drawing.Font("Verdana",9,[Drawing.FontStyle]::Italic)
$Form.Controls.Add($outputBox) #activating the text box inside the primary window

$Button = New-Object System.Windows.Forms.Button #create the button
$Button.Location = New-Object System.Drawing.Size(400,30) #location of the button (px) in relation to the primary window's edges (length, height)
$Button.Size = New-Object System.Drawing.Size(110,80) #the size in px of the button (length, height)
$Button.Text = "Action" #labeling the button
$Button.Add_Click({pingInfo}) #the action triggered by the button
$Button.Cursor = [System.Windows.Forms.Cursors]::Hand
$Button.BackColor = [System.Drawing.Color]::LightGreen
$Button.Font = New-Object System.Drawing.Font("Verdana",14,[Drawing.FontStyle]::Bold)
$Form.Controls.Add($Button) #activating the button inside the primary window





$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()   #activating the form

