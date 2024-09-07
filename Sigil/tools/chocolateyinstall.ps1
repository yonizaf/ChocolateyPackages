$ErrorActionPreference = 'Stop';

if (Get-OSArchitectureWidth -Compare 32) {
  throw "Sigil is no longer available in 32-bit since version 2.0.0, pin the package version to 1.9.30 with command ``choco pin add --name=`"'sigil'`" --version=`"'1.9.30'`"``"
}

if ([System.Environment]::OSVersion.Version -lt (new-object 'Version' 10, 0, 17763)) {
  throw "Sigil is only available for Windows 10 Version 1809 or higher since version 2.0.0, pin the package version to 1.9.30 with command ``choco pin add --name=`"'sigil'`" --version=`"'1.9.30'`"``"
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url64bit      = 'https://github.com/Sigil-Ebook/Sigil/releases/download/2.3.1/Sigil-2.3.1-Windows-x64-Setup.exe'
	
  softwareName  = 'sigil'

  checksum64    = '1A8C3AFB3097FE9FC1D70F58A8695721DF221A6D447F28EBD650282C972F3910'
  checksumType64= 'sha256'

  silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
