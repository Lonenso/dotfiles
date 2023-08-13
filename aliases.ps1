# Easier Navigation: .., ..., ...., ....., and ~
${function:~} = { Set-Location ~ }
# PoSh won't allow ${function:..} because of an invalid path error, so...
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }

#Set-Alias time Measure-Command

# Correct PowerShell Aliases if tools are available (aliases win if set)
# WGet: Use `wget.exe` if available
if (Get-Command wget.exe -ErrorAction SilentlyContinue | Test-Path) {
  Remove-Item alias:wget -ErrorAction SilentlyContinue
}

# Directory Listing: Use `ls.exe` if available
if (Get-Command ls.exe -ErrorAction SilentlyContinue | Test-Path) {
    Remove-Item alias:ls -ErrorAction SilentlyContinue
    # Set `ls` to call `ls.exe` and always use --color
    ${function:ls} = { Get-ChildItem --color @args }
    # List all files in long format
    ${function:l} = { Get-ChildItem -lF @args }
    # List all files in long format, including hidden files
    ${function:la} = { Get-ChildItem -laF @args }
    # List only directories
    ${function:lsd} = { Get-ChildItem -Directory -Force @args }
} else {
    # List all files, including hidden files
    ${function:la} = { Get-ChildItem -Force @args }
    # List only directories
    ${function:lsd} = { Get-ChildItem -Directory -Force @args }
}

Set-Alias which where.exe
Set-Alias vim gvim
function ez {
    . $profile
}
