#!/bin/sh

# Need to be set, otherwise X11 will not work
export QT_X11_NO_MITSHM=1

export HOME=/config

echo "#### Starting AVpro Manager ###"
exec /usr/bin/avpromanager.bin

