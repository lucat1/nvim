#!/bin/bash

/bin/echo -e '\x1b[32mEnabling ethereal chroot-style...\x1b[0m'
echo XBPS_CHROOT_CMD=ethereal >> ./void-packages/etc/conf
echo XBPS_ALLOW_CHROOT_BREAKOUT=yes >> ./void-packages/etc/conf
/bin/echo -e '\x1b[32mLinking / to /masterdir...\x1b[0m'
ln -s / ./void-packages/masterdir
