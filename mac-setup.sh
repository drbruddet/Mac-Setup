#!/bin/sh

# INSTALL BASE
echo 'INSTALL BASE SOFTS'
if test ! $(which brew)
then
	echo 'Installing Homebrew'
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew upgrade
  brew doctor
fi
brew install curl wget ffmpeg coreutils

# DOWNLOAD MY A BASH PROFILE
echo 'INIT BASH_PROFILE'
wget "https://raw.githubusercontent.com/guillaumeko/bash_profile/master/.bash_profile" && echo "bash_profile installed" || echo "can't downlaod bash_profile"
mv ./.bash_profile ~/.bash_profile
source ~/.bash_profile

# INSTALL COMMON APPS : Cask and mas (Mac App Store)
echo 'mas installing, to init Mac App Store apps.'
brew install mas
echo "entrer iTunes account:"
read COMPTE
echo "enter password for : $COMPTE"
read -s PASSWORD
mas signin $COMPTE "$PASSWORD"

echo 'Cask installing, to install other apps.'
brew tap caskroom/cask

# Install apps with mas (source : https://github.com/argon/mas/issues/41#issuecomment-245846651)
function install () {
	mas list | grep -i "$1" > /dev/null
	if [ "$?" == 0 ]; then
		echo "==> $1 is already installed"
	else
		echo "==> Install $1..."
		mas search "$1" | { read app_ident app_name ; mas install $app_ident ; }
	fi
}

echo "INSTALL DESKTOP APPS FROM APP STORE"
brew cask install --appdir="/Applications" google-drive
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" opera
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" atom
brew cask install --appdir="/Applications" vlc
brew cask install --appdir="/Applications" transmission
brew cask install --appdir="/Applications" evernote
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" spotify
brew cask install --appdir="/Applications" spotify-notifications
brew cask install --appdir="/Applications" the-unarchiver

# INSTALL X-CODE DEV TOOLS
echo 'INSTALL XCODE DEV TOOLS'
#xcode-select --install;

# INSTALL DEVELOPMENT APPLICATIONS (JS / RUBY / PREPROCESSORS / DATABASES ...)
echo 'INSTALL DEV APPS'
brew install node watchman yarn ruby rbenv ruby-build heroku mysql postgresql mongo
curl https://install.meteor.com/ | sh;
npm install react-native-cli less --global
gem install rails sass
rbenv rehash

# INSTALL GIT AND CONFIGURE
echo 'INSTALL AND CONFIGURE GIT'
brew install git
brew install bash-completion
git config --global user.name "Guillaume Kolly"
git config --global user.email guillaume.kolly@gmail.com
git config --global core.editor atom
git config --global color.ui true
ssh-keygen -t rsa -C "guillaume.kolly@gmail.com"
cat ~/.ssh/id_rsa.pub

## ************************* SETTINGS ********************************


## USE PLAIN TEXT MODE FOR NEW TEXTEDIT DOCUMENTS
defaults write com.apple.TextEdit RichText -int 0

## UNHIDE YOUR USER LIBRARY
chflags nohidden ~/Library
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string “Nlsv”
defaults write com.apple.finder ShowPathbar -bool true
sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true

## SET FINDER TO DEFAULT TO $HOME
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

## SET DEFAULT SEARCH TO CURRENT FOLDER
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

## SET REASONABLE SCREEN CAPTURE DEFAULTS
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture type -string "jpg"

## DOCK
defaults write com.apple.dock tilesize -int 35
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -float 128

## TRACKPAD
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

## SAFARI
defaults write com.apple.safari IncludeDevelopMenu -int 1
defaults write com.apple.safari ShowOverlayStatusBar -int 1
defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1
defaults write com.apple.Safari ShowFavoritesBar -bool true

## SHOW PERCENTAGE IN BATTERY STATUS
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

## AUTOMATICALLY OPEN A NEW FINDER WINDOW WHEN A VOLUME IS MOUNTED
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

## DISABLE THE WARNING BEFORE EMPTYING THE TRASH
defaults write com.apple.finder WarnOnEmptyTrash -bool false

## RESTART SYSTEM WHEN FROZEN/HUNG
sudo systemsetup -setrestartfreeze on

## Remove items from dock that you won't use
dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/Mail/ {print NR}') && /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist && killall Dock
dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/Contacts/ {print NR}') && /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist && killall Dock
#dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/Calendar/ {print NR}') && /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist && killall Dock
#dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/Reminders/ {print NR}') && /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist && killall Dock
dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/Maps/ {print NR}') && /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist && killall Dock
dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/Facetime/ {print NR}') && /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist && killall Dock
#dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/iTunes/ {print NR}') && /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist && killall Dock
dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/iBooks/ {print NR}') && /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist && killall Dock
dloc=$(defaults read com.apple.dock persistent-apps | grep _CFURLString\" | awk '/Notes/ {print NR}') && /usr/libexec/PlistBuddy -c "Delete persistent-apps:$dloc" ~/Library/Preferences/com.apple.dock.plist && killall Dock

## ADD APPS TO DOCK
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Evernote.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Atom.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Firefox.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Opera.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Skype.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

## ************ INSTALL END *********

echo "Finder and Dock reaload"
killall Dock
killall Finder

## RUN A MACOS UPDATE
echo "last updates"
sudo softwareupdate --install -all

echo "Last cleanup"
brew cleanup
rm -f -r /Library/Caches/Homebrew/*

# LATEST COMMANDS ADVICE
echo "To have launchd start mysql at login: $> ln -sfv /usr/local/opt/mysql/*plist ~/Library/LaunchAgents"
echo "Then to load mysql now: $> launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
echo "To have launchd start postgresql at login: $> ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents"
echo "Then to load postgresql now: $> launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
echo "You must connect ssh keys to git \n\n"
echo "ET VOILÀ !"
