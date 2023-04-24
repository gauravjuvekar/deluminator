#!/bin/bash
set -Eeuxo pipefail

rsync --recursive --mkpath ./bin/ "$HOME/.local/bin/"
rsync --recursive --mkpath ./config/ "$HOME/.config/deluminator/"
rsync --recursive --mkpath ./share/ "$HOME/.local/share/deluminator/"
