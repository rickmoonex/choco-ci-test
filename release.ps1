[xml]$xmlDoc = Get-Content "./*.nuspec"

$nuspecVersion = $xmlDoc.package.metadata.version

Write-Host "Adding new Git tag"-ForegroundColor Magenta
git tag -a $nuspecVersion -m $nuspecVersion master

Write-Host "Pushing to GitHub" -ForegroundColor Magenta
git push origin master

Function BumpVersion ($current) {
    $integer = [int]$current;
    $newInteger = $integer + 1;
    $newString = [string]$newInteger;
    if ($newString.Length -lt 2) {
        return "0$newString"
    }
    return $newString
}

$packageVersion = $nuspecVersion.Substring($nuspecVersion.Length - 2, 2);
$newPackageVersion = BumpVersion -current $packageVersion
$newNuspecVersion = $nuspecVersion.Substring(0, $nuspecVersion.Length - 2) + $newPackageVersion

Write-Host "Bumping version from: " -NoNewline -ForegroundColor Magenta
Write-Host $nuspecVersion -NoNewline -ForegroundColor Green
Write-Host " to: " -NoNewline -ForegroundColor Magenta
Write-Host $newNuspecVersion  -NoNewline -ForegroundColor Green
Write-Host "!" -ForegroundColor Magenta

$fileName = $xmlDoc.package.metadata.id + ".nuspec"
$xmlDoc.Save("./$fileName");