#!/bin/bash

OFFICIAL_SITE="https://www.freedownloadmanager.org/"
URL="https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb"
PKGNAME="freedownloadmanager"
LICENSE="Proprietary"
DESC="Free Download Manager is a powerful, modern download accelerator and organizer for Linux"
BUILD_DIR=$(mktemp -d)
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Clean previous .rpm
rm -f ./*.rpm

# Check/Install Dependencies (rubygems and fpm)
# --- Verifica se RubyGems está instalado ---
if ! command -v gem >/dev/null 2>&1; then
    echo "[INFO] RubyGems not found. Installing..."
    sudo dnf install -y rubygems
fi

if ! command -v fpm >/dev/null 2>&1; then
   echo "[INFO] fpm not found. Installing by RubyGems..."
   sudo gem install --no-document fpm
fi

# Enter build dir
cd "$BUILD_DIR"

# Download official .deb
wget "$URL"

# Extract
ar x ./freedownloadmanager.deb
tar -xf ./data.tar.xz
tar -xf ./control.tar.xz

# Adjustments
cp -f "$SCRIPT_DIR"/freedownloadmanager.desktop ./usr/share/applications
mkdir -p ./usr/share/icons/hicolor/64x64/apps/
cp -f "$SCRIPT_DIR"/freedownloadmanager.png ./usr/share/icons/hicolor/64x64/apps/

# RPM
VERSION=$(grep '^Version:' control | awk '{print $2}')

fpm -s dir -t rpm \
  -n "$PKGNAME" \
  -v "$VERSION" \
  --iteration 1 \
  --license "$LICENSE"\
  --url "$OFFICIAL_SITE" \
  --description "$DESC" \
  -d "libtorrent" \
  -d "qt5-qtbase" \
  -a x86_64 \
  --prefix / \
  opt usr/share
  
mv ./*.rpm "$SCRIPT_DIR"

# CLEAN
cd "$SCRIPT_DIR"
rm -rf "$BUILD_DIR"

