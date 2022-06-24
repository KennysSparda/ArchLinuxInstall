#!/usr/bin/env bash

function TapToClick() {
  echo """
Section \"InputClass\"
  Identifier \"touchpad\"
  MatchIsTouchpad \"on\"
  Driver \"libinput\"
  Option \"Tapping\" \"on\"
EndSection
  """ > /etc/X11/xorg.conf.d/90-touchpad.conf
}

######    VERIFY IS ROOT    ######
if [[ "$EUID" -ne 0 ]]
	then echo "Please run as root"
	exit
fi

######    CALL MAIN FUNCTION    ######
TapToClick

