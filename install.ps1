$ConfigPath = "$env:USERPROFILE\AppData\Local\nvim"

if (Test-Path $ConfigPath) {
    Remove-Item -Recurse -Force $ConfigPath
}

git clone https://github.com/Mopsgamer/neovim-init.git $ConfigPath
