#!/usr/bin/bash
#
echo "INFO: Begin auxilium installation script:"
if [ -z "$1" ]; then
    echo "Usage:"
    echo "  $0 <prefix>"
    echo "Example:"
    echo "  $0 /usr/local"
    exit 1
fi
tgtdir="$1"
auxdir=${BASH_SOURCE[0]%/*}   # keep just dir part
echo "INFO: Installing $auxdir/bin/auxenv to $tgtdir/bin/auxenv..."
mkdir -p "$tgtdir"/bin
cp "$auxdir/bin/auxenv" "$tgtdir/bin/auxenv"
chmod +xr "$tgtdir/bin/auxenv"
echo "INFO: Completed auxilium installation successfully."
exit 0
