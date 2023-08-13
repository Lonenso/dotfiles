Write-Output "sync dotfiles..."
$ErrorActionPreference = "Stop"
git pull origin main
function doIt {
    foreach ( $file in ".ideavimrc", ".gitconfig", ".git-commit-template.txt", ".gitignore", ".gitconfig-windows") {
        New-Item -ItemType SymbolicLink -Path (Join-Path $home $file) -Target (Resolve-Path $file) -Force
    }
    New-Item -ItemType SymbolicLink -Path (Join-Path $home _vimrc) -Target (Resolve-Path .vimrc) -Force
    foreach ( $file in "profile.ps1", "functions.ps1", "env.ps1", "exports.ps1", "aliases.ps1") {
        New-Item -ItemType SymbolicLink -Path (Join-Path $PSHOME $file) -Target (Resolve-Path $file) -Force
    }
    Remove-Variable file 
    . (Join-Path $PSHOME profile.ps1)
}
doIt