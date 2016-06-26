    #==================| Satnaam Waheguru Ji |=============================== 
    #            
    #            Author  :  Aman Dhally  
    #            E-Mail  :  amandhally@gmail.com  
    #            website :  www.amandhally.net  
    #            twitter :   @AmanDhally  
    #            facebook: http://www.facebook.com/groups/254997707860848/  
    #            Linkedin: http://www.linkedin.com/profile/view?id=23651495  
    #  
    #            Creation Date    : 19/09/2013 
    #            File    :  
    #            Purpose :  
    #            Version : 1  
    # 
    #            My Pet Spider :          /^(o.o)^\   
    #======================================================================== 
 
 
 
#======================================================================== 
#---------------------------------------------- 
#region Application Functions 
#---------------------------------------------- 
 
function OnApplicationLoad { 
    #Note: This function is not called in Projects 
    #Note: This function runs before the form is created 
    #Note: To get the script directory in the Packager use: Split-Path $hostinvocation.MyCommand.path 
    #Note: To get the console output in the Packager (Windows Mode) use: $ConsoleOutput (Type: System.Collections.ArrayList) 
    #Important: Form controls cannot be accessed in this function 
    #TODO: Add snapins and custom code to validate the application load 
     
    return $true #return true for success or false for failure 
} 
 
function OnApplicationExit { 
    #Note: This function is not called in Projects 
    #Note: This function runs after the form is closed 
    #TODO: Add custom code to clean up and unload snapins when the application exits 
     
    $script:ExitCode = 0 #Set the exit code for the Packager 
} 
 
#endregion Application Functions 
 
#---------------------------------------------- 
# Generated Form Function 
#---------------------------------------------- 
function Call-LoginScreenChanger_pff { 
 
    #---------------------------------------------- 
    #region Import the Assemblies 
    #---------------------------------------------- 
    [void][reflection.assembly]::Load("mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089") 
    [void][reflection.assembly]::Load("System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089") 
    [void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089") 
    [void][reflection.assembly]::Load("System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089") 
    [void][reflection.assembly]::Load("System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a") 
    [void][reflection.assembly]::Load("System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089") 
    [void][reflection.assembly]::Load("System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a") 
    [void][reflection.assembly]::Load("System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089") 
    [void][reflection.assembly]::Load("System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a") 
    #endregion Import Assemblies 
 
    #---------------------------------------------- 
    #region Generated Form Objects 
    #---------------------------------------------- 
    [System.Windows.Forms.Application]::EnableVisualStyles() 
    $form1 = New-Object 'System.Windows.Forms.Form' 
    $labelYourChoose = New-Object 'System.Windows.Forms.Label' 
    $picturebox2 = New-Object 'System.Windows.Forms.PictureBox' 
    $buttonChangeLoginScreen = New-Object 'System.Windows.Forms.Button' 
    $buttonSetToDefault = New-Object 'System.Windows.Forms.Button' 
    $buttonTest = New-Object 'System.Windows.Forms.Button' 
    $openfiledialog1 = New-Object 'System.Windows.Forms.OpenFileDialog' 
    $InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState' 
    #endregion Generated Form Objects 
 
    #---------------------------------------------- 
    # User Generated Script 
    #---------------------------------------------- 
 
     
     
     
     
     
     
     
    $form1_Load={ 
        #TODO: Initialize Form Controls here 
         
         
         
            $testPath = Test-Path "$env:windir\Temp\LoginChanger" 
     
            if ( $testPath -eq $false ) {  
                 
                New-Item -Path "$env:windir\Temp" -Name LoginChanger -Type Directory  -Force  
                #New-Item -Path "$env:windir\Temp\LoginChanger" -Name OldBack -Type Directory  -Force  
                 
            } 
             
            else {  
                Write-Host "LoginChanger Exists" 
                Remove-Item  "$env:windir\Temp\LoginChanger\*"     -Force  
             
            } 
         
         
        $registryValue = Get-ItemProperty -Path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background -Name OEMBackground 
         
     
         
         
         
         
        ### 
         
         
     
         
    } 
     
    $openfiledialog1_FileOk=[System.ComponentModel.CancelEventHandler]{ 
    #Event Argument: $_ = [System.ComponentModel.CancelEventArgs] 
        #TODO: Place custom script here 
         
    } 
     
    $folderbrowserdialog1_HelpRequest={ 
        #TODO: Place custom script here 
         
    } 
     
    $button1_Click={ 
        #TODO: Place custom script here 
         
        $openfiledialog1.ShowDialog() 
         
        $openfiledialog1.FileName 
    } 
     
    $picturebox1_Click={ 
        #TODO: Place custom script here 
         
    } 
     
     
     
     
    $buttonTest_Click={ 
        #TODO: Place custom script here 
        $myshell = New-Object -com "Wscript.Shell" 
        $myshell.Run("%windir%\System32\rundll32.exe user32.dll,LockWorkStation") 
         
    } 
     
    $buttonAbout_Click={ 
        #TODO: Place custom script here 
     
    } 
     
    $buttonSetToDefault_Click={ 
        #TODO: Place custom script here 
        Set-ItemProperty -Path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background -Name OEMBackground -Value 0 -Force 
    } 
     
    $buttonChangeLoginScreen_Click={ 
        #TODO: Place custom script here 
         
        Remove-Item "$env:windir\Temp\LoginChanger\*" -Force 
     
        $openfiledialog1.AddExtension = $true 
        $openfiledialog1.DefaultExt = ".jpg" 
         
         
         
        $openfiledialog1.ShowDialog() 
        $openfiledialog1.OpenFile() 
         
         
         
         
         
         
             
        $picture2 = [System.Drawing.Image]::FromFile($openfiledialog1.FileName) 
        $picturebox2.Image = $picture2 
         
        $form1.Refresh() 
         
         
         
        $file = $openfiledialog1.FileName 
        Copy-Item $file -Destination "$env:windir\Temp\loginChanger\" 
     
         
        $a = Get-ChildItem "$env:windir\Temp\LoginChanger " 
     
     
     
        Rename-Item $a.FullName -NewName "backgroundDefault.jpg" 
     
         
        Set-ItemProperty -Path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background -Name OEMBackground -Value 1 -Force 
        Copy-Item "$env:windir\temp\LoginChanger\backgroundDefault.jpg" -Destination "$env:windir\System32\oobe\info\backgrounds\ " -Force 
         
        Remove-Item "$env:windir\temp\LoginChanger\backgroundDefault.jpg" -Force 
         
            $form1.Refresh() 
         
         
         
         
         
    } 
     
    # --End User Generated Script-- 
    #---------------------------------------------- 
    #region Generated Events 
    #---------------------------------------------- 
     
    $Form_StateCorrection_Load= 
    { 
        #Correct the initial state of the form to prevent the .Net maximized form issue 
        $form1.WindowState = $InitialFormWindowState 
    } 
     
    $Form_Cleanup_FormClosed= 
    { 
        #Remove all event handlers from the controls 
        try 
        { 
            $buttonChangeLoginScreen.remove_Click($buttonChangeLoginScreen_Click) 
            $buttonSetToDefault.remove_Click($buttonSetToDefault_Click) 
            $buttonTest.remove_Click($buttonTest_Click) 
            $form1.remove_Load($form1_Load) 
            $form1.remove_Load($Form_StateCorrection_Load) 
            $form1.remove_FormClosed($Form_Cleanup_FormClosed) 
        } 
        catch [Exception] 
        { } 
    } 
    #endregion Generated Events 
 
    #---------------------------------------------- 
    #region Generated Form Code 
    #---------------------------------------------- 
    # 
    # form1 
    # 
    $form1.Controls.Add($labelYourChoose) 
    $form1.Controls.Add($picturebox2) 
    $form1.Controls.Add($buttonChangeLoginScreen) 
    $form1.Controls.Add($buttonSetToDefault) 
    $form1.Controls.Add($buttonTest) 
    $form1.ClientSize = '477, 469' 
    $form1.Name = "form1" 
    $form1.Text = "Form" 
    $form1.add_Load($form1_Load) 
    # 
    # labelYourChoose 
    # 
    $labelYourChoose.Location = '28, 18' 
    $labelYourChoose.Name = "labelYourChoose" 
    $labelYourChoose.Size = '100, 23' 
    $labelYourChoose.TabIndex = 7 
    $labelYourChoose.Text = "Your Choose!" 
    # 
    # picturebox2 
    # 
    $picturebox2.Location = '30, 44' 
    $picturebox2.Name = "picturebox2" 
    $picturebox2.Size = '391, 321' 
    $picturebox2.SizeMode = 'Zoom' 
    $picturebox2.TabIndex = 6 
    $picturebox2.TabStop = $False 
    # 
    # buttonChangeLoginScreen 
    # 
    $buttonChangeLoginScreen.Location = '54, 390' 
    $buttonChangeLoginScreen.Name = "buttonChangeLoginScreen" 
    $buttonChangeLoginScreen.Size = '127, 23' 
    $buttonChangeLoginScreen.TabIndex = 3 
    $buttonChangeLoginScreen.Text = "Change Login Screen" 
    $buttonChangeLoginScreen.UseVisualStyleBackColor = $True 
    $buttonChangeLoginScreen.add_Click($buttonChangeLoginScreen_Click) 
    # 
    # buttonSetToDefault 
    # 
    $buttonSetToDefault.Location = '308, 390' 
    $buttonSetToDefault.Name = "buttonSetToDefault" 
    $buttonSetToDefault.Size = '113, 23' 
    $buttonSetToDefault.TabIndex = 1 
    $buttonSetToDefault.Text = "Set to Default" 
    $buttonSetToDefault.UseVisualStyleBackColor = $True 
    $buttonSetToDefault.add_Click($buttonSetToDefault_Click) 
    # 
    # buttonTest 
    # 
    $buttonTest.Location = '198, 390' 
    $buttonTest.Name = "buttonTest" 
    $buttonTest.Size = '75, 23' 
    $buttonTest.TabIndex = 0 
    $buttonTest.Text = "Test" 
    $buttonTest.UseVisualStyleBackColor = $True 
    $buttonTest.add_Click($buttonTest_Click) 
    # 
    # openfiledialog1 
    # 
    $openfiledialog1.DefaultExt = "jpg" 
    $openfiledialog1.FileName = "openfiledialog1" 
    #endregion Generated Form Code 
 
    #---------------------------------------------- 
 
    #Save the initial state of the form 
    $InitialFormWindowState = $form1.WindowState 
    #Init the OnLoad event to correct the initial state of the form 
    $form1.add_Load($Form_StateCorrection_Load) 
    #Clean up the control events 
    $form1.add_FormClosed($Form_Cleanup_FormClosed) 
    #Show the Form 
    return $form1.ShowDialog() 
 
} #End Function 
 
#Call OnApplicationLoad to initialize 
if((OnApplicationLoad) -eq $true) 
{ 
    #Call the form 
    Call-LoginScreenChanger_pff | Out-Null 
    #Perform cleanup 
    OnApplicationExit 
} 