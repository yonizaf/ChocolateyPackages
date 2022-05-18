$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url64bit      = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.1/Sigil-1.9.1-Windows-Legacy-Setup.exe'
	
  softwareName  = 'sigil'

  checksum64    = '4b6dea315da87ebc0cca1c8c584550bfb1f9b7772ee400234b39f4d43bb2cc36'
  checksumType64= 'sha256'

  silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
