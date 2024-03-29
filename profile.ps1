# oh-my-posh init pwsh | Invoke-Expression
# Dracula readline configuration. Requires version 2.0, if you have 1.2 convert to `Set-PSReadlineOption -TokenType`
# Set-PSReadlineOption -Color @{
#     "Command" = [ConsoleColor]::Green
#     "Parameter" = [ConsoleColor]::Gray
#     "Operator" = [ConsoleColor]::Magenta
#     "Variable" = [ConsoleColor]::White
#     "String" = [ConsoleColor]::Yellow
#     "Number" = [ConsoleColor]::Blue
#     "Type" = [ConsoleColor]::Cyan
#     "Comment" = [ConsoleColor]::DarkCyan
# }
# Dracula Prompt Configuration
# Import-Module posh-git
# $GitPromptSettings.DefaultPromptPrefix.Text = "$([char]0x2192) " # arrow unicode symbol
# $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
# $GitPromptSettings.DefaultPromptPath.ForegroundColor =[ConsoleColor]::Cyan
# $GitPromptSettings.DefaultPromptSuffix.Text = "$([char]0x203A) " # chevron unicode symbol
# $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::Magenta
# # Dracula Git Status Configuration
# $GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::Blue
# $GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::Blue
# $GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::Blue
Push-Location $PSHOME
"env","functions","aliases","exports","extra" | Where-Object {Test-Path "$_.ps1"} | ForEach-Object -process {Invoke-Expression ". .\$_.ps1"}
Pop-Location
