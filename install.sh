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
script=$(readlink -f "${BASH_SOURCE[0]}")
auxdir=$(dirname "$script")
mkdir -p "$tgtdir"/bin
fulltgtdir=$(readlink -f "$tgtdir")
for file in bin/auxenv bin/auxsource bin/auxalias; do
    echo "INFO: Installing $auxdir/$file to $tgtdir/$file..."
    cp "$auxdir/$file" "$tgtdir/$file"
    chmod a+r "$tgtdir/$file"
    chmod a-x "$tgtdir/$file"
done
echo "INFO: All files copied."
echo "INFO: Recommended adding \"source $fulltgtdir/auxalias\" to /etc/bashrc or ~/.bashrc."
echo "INFO: Completed auxilium installation."
exit 0
