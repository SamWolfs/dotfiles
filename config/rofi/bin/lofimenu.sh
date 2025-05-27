#!/usr/bin/env sh

rofi \
    -modi "Repository:lofi-rofi web -l repositories" \
    -show Repository \
    -theme "$HOME/.config/rofi/theme.rasi"
