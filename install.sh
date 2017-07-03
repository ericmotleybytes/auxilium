#!/usr/bin/bash
#
echo "Auxilium installation script (source version):"
exitstat="0"
if [[ -z "$1" ]]; then
    echo "ERROR: missing target installation prefix ($0)."
    exitstat="1"
fi
if [[ -z "$1" || "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage:"
    echo "  $0 <prefix>         # do install"
    echo "  $0 -h | --help      # display this screen"
    echo "Example:"
    echo "  $0 ~/local          # personal install to ~/local/bin, etc."
    echo "  sudo $0 /usr/local  # shared install to /usr/local/bin, etc."
    exit $exitstat
fi
prefix="$1"
srcdir=$(dirname "$0")
cd "$srcdir"
make install PREFIX="$prefix"
