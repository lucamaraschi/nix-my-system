#!/bin/bash

set -e

HOST_NAME=$1
NIXOS_USERNAME=$2

function setup_darwin_based_host() {
  if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Please run this script on a Darwin-based machine"
    exit 1
  fi
  
  if [[ -z "$(command -v git)" ]]; then
    # Install XCode Command Line Tools.
    echo 'Installing Xcode tools'
    xcode-select --install &> /dev/null

    # Wait until XCode Command Line Tools installation has finished.
    until $(xcode-select --print-path &> /dev/null); do
      sleep 5;
    done
  fi
  
  if [[ $(command -v brew) == "" ]]; then
      echo "Installing Hombrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      
      echo 'Sourcing brew...'
      (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
  else
      echo "Updating Homebrew"
      brew update
  fi
  
  if [[ $(command -v nix) == "" ]]; then
      echo 'Installing Nix on Mac'
      curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  fi

  if [ -d "/Users/batman/src/lm/nix-my-system" ]; then
    echo 'Your nix settings are already available'
  else
    mkdir -p ~/src/lm/
    git clone https://github.com/lucamaraschi/nix-my-system.git ~/src/lm/nix-my-system/
  fi
  
  if [ ! -f "/etc/nix/nix.conf.before-nix-darwin" ]; then
    sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
  fi
  
  if [ ! -f "/etc/zshenv.before-nix-darwin" ]; then
    sudo mv /etc/zshenv /etc/zshenv.before-nix-darwin
  fi
  
  export NIXUSER=batman
  export NIXNAME=macbook-pro-m1

  cd ~/src/lm/nix-my-system/
  git pull
  make
  cd
}

setup_darwin_based_host