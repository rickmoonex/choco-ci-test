# Choco CI Test

This is a lab repo for testing the capibility of CI integration with Choco packages.

It uses Github Action to automatically test and release the code.

I also added a Powershell script called `release.ps1`. This script automatically pushes the ode to GitHub and increments versioning

## `release.ps1`

The script `release.ps1` can be used by the package developer to automatically version and push the code to GitHub. This makes release a package less of a hassle for the developer. This is achieved bij automaticlly pushing the code to GitHub using the appropriate Git tag. And then automatically bumping up the version in te nuspec file.

### Steps
The script executes the following steps

1. Read the .nuspec file from the filesystem.
2. Create a GitHub tag using the current version from the nuspec file
3. Push the code to GitHub with the appropriate tag.
4. Bump up the version from the nuspec file

## GitHub Workflow

The release wotkflow is automatically triggered when a new tag get's pushed to the GitHub repo. It then automatically tests the package and creates a GitHub release.

### Steps
The GitHub workflow executes the following steps

1. Copy the code from the repo into the new container
2. Spin up a second container running chocolatey
3. Test the code by running `choco pack`
4. Create a GitHub Release using the appropriate tag.