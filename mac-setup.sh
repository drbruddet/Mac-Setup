# INSTALL BASE TOOLS
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/insta\
ll/master/install)"; brew update; brew upgrade; brew doctor;
brew install curl;
brew install wget;

# DOWNLOAD MY A BASH PROFILE
wget "https://raw.githubusercontent.com/guillaumeko/bash_profile/master/.bash_profile" && echo "bash_profile installed" || echo "can't downlaod bash_profile";
mv ./.bash_profile ~/.bash_profile;
source ~/.bash_profile;

# INSTALL X-CODE DEV TOOLS
xcode-select --install;

# INSTALL MAIN JS PACKAGES
brew install node;
brew install watchman;
brew install yarn;
curl https://install.meteor.com/ | sh;
npm install react-native-cli --global;

echo "Javascript env installed";

# INSTALL MAIN RUBY PACKAGES
brew install ruby rbenv ruby-build;
gem install rails;
rbenv rehash;
rails -v;
echo "ruby on rails env installed";

# INSTALL DATABASES
brew install mysql;
echo "To have launchd start mysql at login: $> ln -sfv /usr/local/opt/mysql/*plist ~/Library/LaunchAgents";
echo "Then to load mysql now: $> launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist";
brew install postgresql;
echo "To have launchd start postgresql at login: $> ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents";
echo "Then to load postgresql now: $> launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist";
brew install mongo;

# INSTALL GIT AND CONFIGURE
brew install git;
brew install bash-completion;
git config --global user.name "Guillaume Kolly";
git config --global user.email guillaume.kolly@gmail.com;
git config --global core.editor atom;
git config --global color.ui true;
ssh-keygen -t rsa -C "guillaume.kolly@gmail.com";
cat ~/.ssh/id_rsa.pub;
echo "You must connect ssh keys to git";

# INSTALL OTHER DEV TOOLS
# LESS & SASS
npm install less --global;
gem install sass;
