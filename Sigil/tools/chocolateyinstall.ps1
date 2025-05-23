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
  url64bit      = 'https://github.com/Sigil-Ebook/Sigil/releases/download/2.5.0/Sigil-2.5.0-Windows-x64-Setup.exe'
	
  softwareName  = 'sigil'

  checksum64    = '8b3d5748be68cd8be256ac6ae026fa4ab2d1e1b59c7b63a80c7512827b0b5aba'
  checksumType64= 'sha256'

  silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
