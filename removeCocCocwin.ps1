#Running a command as Administrator using PowerShell
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs  -ArgumentList $arguments
  Break
}

#Check if CC browser installed
$browser = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\browser.exe'

if($browser -eq $true){
   Write-Host "CocCoc is installed"
                   #Kill Untralview process
                #Check if Cốc Cốcc browser running
                if((get-process "UltraViewer_Service" -ea SilentlyContinue) -eq $Null){ 
                        echo "UltraViewer_Service Running" 
                }
                else{ 
                    echo "UltraViewer_Service running"
                    #Kill process UltraViewer_Service.exe if UltraViewer_Service running
                    Stop-Process -Force -processname "UltraViewer_Service"
                    Write-host "UltraViewer_Service process stoped" -f Green
                 }


                #Check if Cốc Cốcc browser running
                if((get-process "browser" -ea SilentlyContinue) -eq $Null){ 
                        echo "Cốc Cốc not Running" 
                }

                else{ 
                    echo "Cốc Cốc running"
                    #Kill process browser.exe if Cốc Cốc running
                    Stop-Process -processname "browser" 
                    Write-host "Cốc Cốc process stoped" -f Green
                    #Kill all Cốc Cốc process 
                    taskkill /F /IM CocCoc*
                 }



                #Get Version
                $CocCocVer = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall |
                    Get-ItemProperty |
                    Where-Object {$_.DisplayName -match "Cốc Cốc" } |
                    Select-Object -Property DisplayName, UninstallString

                #Uninstall
                ForEach ($ver in $CocCocVer) {

                    If ($ver.UninstallString) {

                        $uninst = $ver.UninstallString
                        & cmd /c $uninst --force-uninstall --multi-install --coccoc 
                    }
     
                }

                #Remove CC folder on C:\Program Files (x86)
                $pathx86 = "C:\Program Files (x86)"
                #Check if folder exists
                If (Test-Path $pathx86) {
                    # Folder exists, delete it!
                    Get-ChildItem -Path $pathx86 -Directory -Filter *CocCoc* |Remove-Item -Filter "CocCoc" -Force -Recurse
                    #Remove-Item -Path $pathx86 -Filter *CocCoc*  -Force
                    Write-host "Folder CocCoc deleted at '$pathx86'!" -f Green
                }
                Else {
                    Write-host "Folder CocCoc '$pathx86' does not exist!" -f Red
                }

                #Remove CC folder on C:\Program Files
                $pathx64 = "C:\Program Files"
                #Check if folder exists
                If (Test-Path $pathx64) {
                    # Folder exists, delete it!
                    Get-ChildItem -Path $pathx64 -Directory -Filter *CocCoc* |Remove-Item -Force -WhatIf -Filter "CocCoc"
                    #Remove-Item -Path $pathx86 -Filter *CocCoc*  -Force
                    Write-host "Folder CocCoc Deleted at '$pathx64'!" -f Green
                }
                Else {
                    Write-host "Folder CocCoc '$pathx64' does not exist!" -f Red
                }


                #Remove CC folder on %appdata%
                $pathlocal = "C:\Users\*\AppData\Local\CocCoc"
                Remove-Item -Recurse  -Force -Path $pathlocal
                Write-host "Folder CocCoc Deleted at '$pathlocal'!" -f Green

                $pathroaming = "C:\Users\*\AppData\Roaming\CocCoc"
                Remove-Item -Recurse  -Force -Path $pathroaming
                Write-host "Folder CocCoc Deleted at '$pathroaming'!" -f Green

                #remove registry key
                $key =  "Registry::HKEY_CURRENT_USER\Software\CocCoc"
                Remove-Item -Recurse -Force -Path $key 
                Write-host "Folder CocCoc Deleted at HKEY_CURRENT_USER\Software\CocCoc!" -f Green


                $key1 =  "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CocCoc"
                Remove-Item -Recurse -Force -Path $key1
                Write-host "Folder CocCoc Deleted at HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CocCoc" -f Green

                #Remove-Item -Path Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf -Force
                #Write-host "Folder .pdf deleted " -f Green

                Write-host "Cốc Cốc browser uninstalled completely " -f Green
}
else
{
   Write-Host "CocCoc is not installed"
}




Pause