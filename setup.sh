#!/bin/bash

echo "----- system updates ------"
add-apt-repository universe
apt update && apt upgrade -y

echo "----- installing zsh ------"
apt install zsh -y

echo "----- installing sudo ------"
apt install sudo -y

echo "----- installing curl ------"
apt install curl -y

echo "----- installing openssh-server ------"
apt install openssh-server -y
service ssh start

echo "----- installing oh my zsh ------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ~/wsl-ubuntu-setup/calm.zsh-theme ~/.oh-my-zsh/themes/calm.zsh-theme 

echo "----- installing zsh auto suggestions ------"
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions

echo "----- installing zsh syntax highlighting ------"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

echo "----- installing neofetch ------"
apt install neofetch -y

echo "----- installing fira code ------"
apt install fonts-firacode -y

echo "----- installing azure cli ------"
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

echo "----- installing powershell ------"
apt-get install -y wget apt-transport-https software-properties-common
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt-get update
apt-get install -y powershell
rm packages-microsoft-prod.deb

echo "----- installing terraform ------"
apt install wget unzip -y
TER_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1')
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip -O ~/terraform_${TER_VER}_linux_amd64.zip
unzip ~/terraform_${TER_VER}_linux_amd64.zip
mv terraform /usr/local/bin/
rm ~/terraform_${TER_VER}_linux_amd64.zip

echo "----- installing sqlite ------"
apt install sqlite3 -y

echo "----- installing open jdk 11 ------"
apt-get install openjdk-11-jdk

echo "----- installing maven 3.8.4 ------"
# https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-20-04/#installing-the-latest-release-of-apache-maven
wget https://archive.apache.org/dist/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz -P /tmp
tar xf /tmp/apache-maven-*.tar.gz -C /opt 
ln -s /opt/apache-maven-3.8.4 /opt/maven # sym link When a new version is released, you can upgrade your Maven installation, by unpacking the newer version and change the symlink to point to it.
cp ./maven.sh /etc/profile.d/
chmod +x /etc/profile.d/maven.sh
. /etc/profile.d/maven.sh

echo "----- installing nvm (node version manager) ------"
export NVM_DIR="$HOME/.nvm"
rm -rf ~/.nvm
git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)` | bash
. "$NVM_DIR/nvm.sh"
. ./nvm.sh
cd ~/wsl-ubuntu-setup

echo "----- allowing legacy dependencies ------"
npm config set legacy-peer-deps true

echo "----- installing node lts ------"
nvm install --lts

echo "----- installing npm latest ------"
npm install -g npm

echo "----- installing eslint ------"
npm install -g eslint

echo "----- installing profiles ------"
cp ~/wsl-ubuntu-setup/.bashrc ~/.bashrc
cp ~/wsl-ubuntu-setup/.zshrc ~/.zshrc

echo "----- cleaning up ------"
apt autoremove -y

echo "----- finished ------"
