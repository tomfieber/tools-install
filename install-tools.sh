#!/bin/bash

export PATH=$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/env:/usr/local/go/bin:/usr/sbin:$PATH

# Install the most recent version of GO
URL="https://go.dev/dl/go1.20.6.linux-arm64.tar.gz"

# Download and save
echo "[+] Downloading GO"
wget $URL -O /tmp/go.tar.gz

# Remove existing go install
echo "[+] Removing any existing installation"
eval sudo rm -rf /usr/local/go

# Install the new version
echo "[+] Installing the new version"
eval sudo tar -C /usr/local -xzf /tmp/go.tar.gz

# confirming the install version
VERSION=$(go version)
echo "[+] Successfully installed $VERSION"

# Remove the archive
rm -rf /tmp/go.tar.gz

# Get desktop environment
DESKTOP=$XDG_CURRENT_DESKTOP
echo "[+] $DESKTOP desktop environment detected"

# Do an update
sudo apt update && sudo apt full-upgrade

if [ $DESKTOP == "MATE" ]; then
    sudo apt install diodon
fi

if [ $DESKTOP != "KDE" ]; then
    sudo apt install terminator arc-theme papirus-icon-theme slick-greeter
fi

# Install some basic necessities
echo "[+] Installing some basic necessities"
sudo apt install -y git libssl-dev libffi-dev python-dev-is-python3 build-essential libbz2-dev libreadline-dev libsqlite3-dev curl zlib1g-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev zsh pipx direnv

# Install dependencies
echo "[+] Installing dependencies"
sudo apt install -y libpcap-dev

# Autoremove
sudo apt autoremove
echo "=========="
echo


# Install Go tools
echo "[+] Installing subfinder"
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
echo "[+] Installing nuclei"
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
echo "[+] Installing naabu"
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
echo "[+] Installing httpx"
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
echo "[+] Installing katana"
go install github.com/projectdiscovery/katana/cmd/katana@latest
echo "[+] Installing dnsx"
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
echo "[+] Installing tlsx"
go install github.com/projectdiscovery/tlsx/cmd/tlsx@latest
echo "[+] Installing uncover"
go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest
echo "[+] Installing amass"
go install -v github.com/owasp-amass/amass/v3/...@master
echo "[+] Installing blacksheepwall"
go install github.com/tomsteele/blacksheepwall@latest
echo "[+] Installing ffuf"
go install github.com/ffuf/ffuf/v2@latest
echo "[+] Installing kerbrute"
go install github.com/ropnop/kerbrute@latest
echo "=========="
echo

# Installing pipx tools
echo "[+] Installing some tools from pipx"
pipx install certipy-ad
pipx install bloodhound
pipx install git+https://github.com/blacklanternsecurity/MANSPIDER
echo "=========="
echo

# Install pyenv
echo "[+] Installing pyenv"
if [ ! -d $HOME/.pyenv ]; then
    curl https://pyenv.run | bash
fi

# Install poetry
echo "[+] Installing poetry"
curl -sSL https://install.python-poetry.org | python3 -

# Install rustup
echo "[+] Installing rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


# Change shell to zsh
GETSHELL=$(echo $SHELL | awk -F '/' '{print $NF}')
if [ $GETSHELL != "zsh" ]; then
    echo "[-] $GETSHELL detected. Changing SHELL to zsh."
    chsh -s $(which zsh)
fi

wget https://raw.githubusercontent.com/tomfieber/zsh/main/zsh_shortcuts -O $HOME/.zsh_shortcuts
wget https://raw.githubusercontent.com/tomfieber/zsh/main/zsh_aliases -O $HOME/.zsh_aliases
wget https://raw.githubusercontent.com/tomfieber/zsh/main/zshrc -O $HOME/.zshrc

echo
echo "Install complete. Be sure to run 'source $HOME/.zshrc' to launch the new shell in your current session."


