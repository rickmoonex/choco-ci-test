$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName  = 'inp-customernameorcentral-softwarename' #fill in the name of the package
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'installer.msi' #fill in the name of the install file

$packageArgs = @{
  packageName   = $packageName
  file          = $fileLocation
  fileType      = 'MSI' #fill in the filetype. only one of these: exe, msi, msu

  #MSI
  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
   #OTHERS
  #silentArgs   ='/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"' # /s /S /q /Q /quiet /silent /SILENT /VERYSILENT -s - try any of these to get the silent installer
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

#Enable-InWorkspace -PackageName $env:ChocolateyPackageName -targetpath "c:\program files (x86)\vendor\applicationname.exe -appArgs "/start_very_fast"

#Important info:
#PackageName and targetpath are mandatory properties, AppArgs is optional
#Only use Enable-InWorkspace in conjuction with Disable-Inworkspace in the chocouninstall.ps1
#Only use $env:ChocolateyPackageName as value for the PackageName property to prevent unpridictable GUID's in the Instructions.xml