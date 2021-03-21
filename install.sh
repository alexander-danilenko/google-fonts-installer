#!/usr/bin/env bash

# Stop on any error.
set -e

###> Variables.
installDir=${FONTS_INSTALL_DIR:-"$HOME/.fonts/"}

archiveUrl="https://github.com/google/fonts/archive/refs/heads/main.tar.gz"
tmpDir=$(mktemp -d)
downloadPath="${tmpDir}/google-fonts-main.tar.gz"
###< Variables.

###> Helper functions.
BLACK=`tput setaf 0;`
RED=`tput setaf 1;`
GREEN=`tput setaf 2;`
YELLOW=`tput setaf 3;`
BLUE=`tput setaf 4;`
MAGENTA=`tput setaf 5;`
CYAN=`tput setaf 6;`
LIGHTGREY=`tput setaf 7;`
RESET=`tput sgr0`

echo-info() {
  echo -e "${YELLOW}[INFO]${RESET} $@"
}
echo-success() {
  echo -e "${GREEN}[SUCCESS]${RESET} $@"
}
###< Helper functions.

# Make sure install dir exists.
mkdir -p ${installDir}

echo-info "Downloading the Google Fonts archive..."
wget --show-progress -q -O ${downloadPath} ${archiveUrl}

echo-info "Extrating archive..."
tar -zxf ${downloadPath} -C ${tmpDir}

echo-info "Copying fonts to ${YELLOW}${installDir}${RESET}"
find ${tmpDir} -type f -name "*.ttf" -exec cp -f {} $installDir \;

echo-info "Fonts installed. Cleaning up..."
rm -rf ${tmpDir}

echo-success "Google Fonts installed to ${YELLOW}${installDir}${RESET}"
