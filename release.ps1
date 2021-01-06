# Release script for Choco Package CI
# Author: Rick Moonen

# Load the .nuspec file from the current working directory
[xml]$xmlDoc = Get-Content "./*.nuspec"

# Extract the current version of this file
$nuspecVersion = $xmlDoc.package.metadata.version

# Create a new Git tag corresponding to the Nuspec version
Write-Host "Adding new Git tag 🔖" -ForegroundColor Magenta
$tag = "v" $nuspecVersion
git tag -a $tag -m $nuspecVersion master

# Push the commits and corresponding tag to the GitHub repo
Write-Host "Pushing to GitHub 💾" -ForegroundColor Magenta
git push origin master --follow-tags

# Function to bump up the version number
Function BumpVersion ($current) {
    $integer = [int]$current;
    $newInteger = $integer + 1;
    $newString = [string]$newInteger;
    if ($newString.Length -lt 2) {
        return "0$newString"
    }
    return $newString
}

# Generate new Nuspeg version
$packageVersion = $nuspecVersion.Substring($nuspecVersion.Length - 2, 2);
$newPackageVersion = BumpVersion -current $packageVersion
$newNuspecVersion = $nuspecVersion.Substring(0, $nuspecVersion.Length - 2) + $newPackageVersion

Write-Host "Bumping version from: " -NoNewline -ForegroundColor Magenta
Write-Host $nuspecVersion -NoNewline -ForegroundColor Green
Write-Host " to: " -NoNewline -ForegroundColor Magenta
Write-Host $newNuspecVersion  -NoNewline -ForegroundColor Green
Write-Host "! 🔼" -ForegroundColor Magenta

# Insert the new version into the Nuspec file
$xmlDoc.package.metadata.version = $newNuspecVersion

Write-Host "Writing new version to nuspec file 📝" -ForegroundColor Magenta

# Write changes to the Nuspec file
$fileName = $xmlDoc.package.metadata.id + ".nuspec"
$xmlDoc.Save("./" + $fileName);

Write-Host "All Done ✅" -ForegroundColor Magenta;