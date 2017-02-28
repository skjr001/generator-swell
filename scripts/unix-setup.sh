#!/bin/bash

DESIRED_NODE_VERSION="v6"
DESIRED_NPM_VERSION="3"
DESIRED_YO_VERSION="1"

setOs() {
    MY_OS=""

    case "$OSTYPE" in
        darwin*)  MY_OS="darwin" ;; 
        linux*)   MY_OS="linux" ;;
    esac

    if [[ "$MY_OS" -eq "linux" ]] && [[ -r /etc/debian_version ]] ; then
        MY_OS="debian"
    elif [[ "$MY_OS" -eq "linux" ]] && [[ -r /etc/fedora-release ]] ; then
        MY_OS="fedora"
    elif [[ "$MY_OS" -eq "linux" ]] && [[ -r /etc/oracle-release ]] ; then
        MY_OS="oel"
    elif [[ "$MY_OS" -eq "linux" ]] && [[ -r /etc/centos-release  ]] ; then
        MY_OS="centos"
    elif [[ "$MY_OS" -eq "linux" ]] && [[ -r /etc/redhat-release  ]] ; then
        MY_OS="rhel"
    elif [[ "$MY_OS" -ne "darwin" ]] ; then
        echo "The OS: $OSTYPE is not supported by this script"
        exit 1
    fi
}

setupMac() {
    BREW_VERSION=$(brew --version)
    if [[ $? -ne 0 ]] ; then
        echo "It looks like your mising homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi    
}

installNode() {
    echo "Downloading & Installing $DESIRED_NODE_VERSION"    
    if [[ "$MY_OS" == "debian" ]] ; then
        curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
        sudo apt-get install -y nodejs
    elif [[ "$MY_OS" == "darwin" ]] ; then
        brew install node
    else
        curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
        sudo yum -y install nodejs
    fi
}

installNpm() {
    curl -L https://www.npmjs.com/install.sh | sh
    if [[ $? -ne 0 ]] ; then
        echo "npm Install Failed"
    fi 
}

installYo() {
    sudo npm install -g yo
    if [[ $? -ne 0 ]] ; then
        echo "Yeoman Install Failed"
    fi 
}

# Script Start
setOs
if [[ "$MY_OS" == "darwin" ]] ; then
    setupMac
fi

NODE_VERSION=$(node --version | cut -d '.' -f1)
if [[ $? -ne 0 ]] ; then
    echo "Node not installed"
    installNode
elif [[ "$NODE_VERSION" -ne "$DESIRED_NODE_VERSION" ]] ; then
    echo "Current node version is $NODE_VERSION which is not $DESIRED_NODE_VERSION"
    installNode    
else
    echo "Node version up to date"
fi

NPM_VERION=$(npm --version | cut -d '.' -f1)
if [[ $? -ne 0 ]] ; then
    echo "npm not installed"
    installNpm
elif [[ "$NPM_VERION" -ne "$DESIRED_NPM_VERSION" ]] ; then
    echo "Current npm version is $NPM_VERION which is not $DESIRED_NPM_VERSION"
    installNpm    
else
    echo "npm version up to date"
fi

YO_VERION=$(yo --version| cut -d '.' -f1)
if [[ $? -ne 0 ]] ; then
    echo "yeoman not installed"
    installYo
elif [[ "$NPM_VERION" -ne "$DESIRED_NPM_VERSION" ]] ; then
    echo "Current yeoman version is $YO_VERION which is not $DESIRED_YO_VERSION"
    installYo    
else
    echo "yeoman version up to date"
fi
