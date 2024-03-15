#Aliases
function Exit-PowerShell {
    Exit
}
Function Get-ChildItemWithForce {
    Get-ChildItem -Force $args
}

Set-Alias -Name lsa -Value Get-ChildItemWithForce
New-Alias -Name ex -Value Exit-PowerShell
Set-Alias tt tree
Set-Alias ll lsa
Set-Alias g git
Set-Alias vim nvim
Set-Alias c clear
Set-Alias n nvim
Set-Alias v nvim
Set-Alias e elivim
Set-Alias chad nvchad
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

#Pop up screen for neovim configs
function nvims {
    $items = @("elivim", "NvChad", "LazyNvim", "default", "NvimPY")
    $config = $items | Out-GridView -Title "Neovim Config" -PassThru
    if ([string]::IsNullOrEmpty($config)) {
        Write-Host "Nothing selected"
    }
    elseif ($config -eq "default") {
        Remove-Item env:NVIM_APPNAME -ErrorAction Ignore
        nvim $args
    }
    else {
        $env:NVIM_APPNAME = $config
        nvim $args
        Remove-Item env:NVIM_APPNAME
    }
}

# Set functions for Neovim configurations
function Invoke-NvimElivim {
    $env:NVIM_APPNAME = "elivim"
    nvim $args
    Remove-Item env:NVIM_APPNAME
}

function Invoke-NvimNvChad {
    $env:NVIM_APPNAME = "NvChad"
    nvim $args
    Remove-Item env:NVIM_APPNAME
}

function Invoke-NvimLazy {
    $env:NVIM_APPNAME = "LazyNvim" 
    nvim $args
    Remove-Item env:NVIM_APPNAME
}

function Invoke-NvimPy {
    $env:NVIM_APPNAME = "NvimPy" 
    nvim $args
    Remove-Item env:NVIM_APPNAME
}

function Invoke-AstroNvim {
    $env:NVIM_APPNAME = "AstroNvim" 
    nvim $args
    Remove-Item env:NVIM_APPNAME
}

function Invoke-kickstartnvim {
    $env:NVIM_APPNAME = "kickstart" 
    nvim $args
    Remove-Item env:NVIM_APPNAME
}

# Set aliases to point to the actual functions
Set-Alias -Name elivim -Value Invoke-NvimElivim
Set-Alias -Name nvchad -Value Invoke-NvimNvChad
Set-Alias -Name lazy -Value Invoke-NvimLazy
Set-Alias -Name npy -Value Invoke-NvimPy
Set-Alias -Name astro -Value Invoke-AstroNvim
Set-Alias -Name kick -Value Invoke-kickstartnvim


#Prompt
#oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config 'C:/Users/YB/Documents/powershell/myprofile.omp.json' | Invoke-Expression
#oh-my-posh init pwsh --config 'C:/Users/YB/Documents/powershell/myprofile1.omp.json' | Invoke-Expression 

#PSReadLine
Import-Module PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PsReadLineOption -PredictionViewStyle ListView

#fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadLineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'

#Icons
Import-Module Terminal-Icons

# Utilites
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

#Functions
function whereis ($item) {
    $commandPaths = Get-Command -Name $item -All -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue
    $itemPath = Get-Item $item -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName -ErrorAction SilentlyContinue
    $files = Get-ChildItem -Path $item -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName -ErrorAction SilentlyContinue
}
