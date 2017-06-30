#!/usr/bin/bash
#
echo "INFO: Begin auxilium installation script:"
if [ -z "$1" ]; then
    echo "Usage:"
    echo "  $0 <prefix>"
    echo "Example:"
    echo "  $0 /usr/local"
    echo "or..."
    echo "  sudo $0 /usr/local"
    exit 1
fi
prefix="$1"
make install PREFIX="$prefix"
