#!/usr/bin/env bash

TARGET="${HOME}/.config/i3blocks/scripts/"

echo "Generating $TARGET path if not already existing"
mkdir -p "$TARGET"

echo "Removing old install"
rm -rf "$TARGET/DavesTimerApp"

echo "Adding new install"
cp -r DavesTimerApp "$TARGET"

echo "Set shell scripts to executable"
chmod +x "$TARGET/DavesTimerApp/"*.sh

echo "Creating symlink"
sudo ln ./DavesTimerApp/addt.sh /usr/bin/addt
