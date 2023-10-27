$domain   = 'https://github.com'
$releases = "${domain}/Sigil-Ebook/Sigil/releases/latest"

$downloadPage = Invoke-WebRequest -Method Head -Uri $releases
$latestTag  = $downloadPage.BaseResponse.RequestMessage.RequestUri -split '\/' | Select-Object -Last 1
$assetsUri    = "{0}/expanded_assets/{1}" -f ($releases.Substring(0, $releases.LastIndexOf('/'))), $latestTag
$assetsPage   = Invoke-WebRequest -Uri $assetsUri

$url64 = $assetsPage.links | where-object href -match "Windows-x64-Setup.exe" | select-object -expand href | foreach-object { $domain + $_ }
$fileName64 = $url64Install -split '/' | select-object -last 1

$checksumUri = $assetsPage.links | where-object href -match "CHECKSUMS.sha256.txt" | select-object -expand href | foreach-object { $domain + $_ }
$downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $checksumUri 
$checksum64 = ($downloadPage.RawContent.Split([System.Environment]::NewLine)  | Select-String "Windows-x64-Setup.exe")[0].Line.Split(" ")[0]

(Get-Content ".\sigil.nuspec") -replace "(<version).*(</version>)", "`$1>$latestTag`$2" | Set-Content ".\sigil.nuspec"
(Get-Content ".\tools\chocolateyinstall.ps1") -replace "(url64bit\s+=\s*).*(')", "`$1'$url64`$2" -replace "(checksum64\s+=\s*).*(')", "`$1'$checksum64`$2" | Set-Content ".\tools\chocolateyinstall.ps1"

$answer = ""
while ($answer -ne "yes") {
    $answer = Read-Host -Prompt "enter 'yes' to choco pack, 'no' to exit:"
    if ($answer -eq "no") {exit 0}
}
choco pack

$answer = ""
while ($answer -ne "yes") {
    $answer = Read-Host -Prompt "enter 'yes' to test install package, 'no' to exit:"
    if ($answer -eq "no") {exit 0}
}
sudo choco install sigil --version="$latestTag" --source=".\"

$answer = ""
while ($answer -ne "yes") {
    $answer = Read-Host -Prompt "enter 'yes' to push package to repo, 'no' to exit:"
    if ($answer -eq "no") {exit 0}
}
choco push ".\sigil.$latestTag.nupkg"
