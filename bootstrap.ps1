echo "sync dotfiles..."
git pull origin main
$profileDir = Split-Path -parent $profile

function doIt {
    foreach ( $file in ".ideavimrc", ".gitconfig", ".git-commit-template.txt", ".gitignore", ".gitconfig-windows") {
        sudo New-Item -ItemType SymbolicLink -Path "$home/$file" -Target "$file" -Force
    }
    sudo New-Item -ItemType SymbolicLink -Path "$home/_vimrc" -Target ".vimrc" -Force
    foreach ( $file in "profile.ps1", "functions.ps1", "env.ps1", "exports.ps1", "aliases.ps1") {
        sudo New-Item -ItemType SymbolicLink -Path "$profileDir/$file" -Target "$file" -Force
    }
    Remove-Variable file 
    & $profile
}
doIt
Remove-Variable profileDir
