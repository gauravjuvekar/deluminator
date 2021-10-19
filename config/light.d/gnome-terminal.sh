#!/bin/bash

# Copyright 2021, Gaurav Juvekar
# SPDX-License-Identifier: MIT

TARGET='solarized-light'

PROF_SCHEMA=org.gnome.Terminal.Legacy.Profile
PROF_PATH=/org/gnome/terminal/legacy/profiles:

default_profile=$(gsettings get org.gnome.Terminal.ProfilesList default | \
                  tr -d \')

for profile_id in $(gsettings get org.gnome.Terminal.ProfilesList list | \
                    tr \' \" | jq -c '.[]' | tr -d \")
do
    if [[ $(gsettings get "$PROF_SCHEMA:$PROF_PATH/:$profile_id/" \
            visible-name | tr -d \') = "$TARGET" ]]; then

        source_profile="$profile_id"
        break
    fi
done

for key in $(gsettings list-keys org.gnome.Terminal.Legacy.Profile | \
             grep -v 'visible-name'); do
    gsettings set "$PROF_SCHEMA:$PROF_PATH/:$default_profile/" "$key" \
        "$(gsettings get "$PROF_SCHEMA:$PROF_PATH/:$source_profile/" "$key")"
done

gsettings set org.gnome.desktop.interface    gtk-theme "Mint-Y-Dark"
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark"
