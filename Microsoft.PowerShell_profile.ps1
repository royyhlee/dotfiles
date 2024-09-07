$Env:BAT_THEME = "gruvbox-light"

function Eza-ls { eza --color=always --group-directories-first --icons -l --no-symlinks }
function Eza-lsa { eza --color=always --group-directories-first --icons -l -a --no-symlinks }
function Eza-ls. { eza -a  | findstr '^\.' }
function Eza-lsd { eza --color=always --group-directories-first --icons -l -a --no-symlinks -D }
function Eza-lsf { eza --color=always --icons -lfa }

Set-Alias -Name "ls" Eza-ls -option 'Constant','AllScope'
Set-Alias -Name "lsa" Eza-lsa -option 'Constant','AllScope'
New-Alias -Name "ls." Eza-ls.
New-Alias -Name "lsd" Eza-lsd
New-Alias -Name "lsf" Eza-lsf

Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineOption -BellStyle None
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Starship
Invoke-Expression (&starship init powershell)

# Posh Git
Import-Module posh-git

# Git Aliases
Import-Module git-aliases -DisableNameChecking
