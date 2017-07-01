# setup interactive aliases and paths to point to dev working copy
testdir="${BASH_SOURCE[0]%/*}"
testdir=$(readlink -f "$testdir")
bindir="$testdir/../bin"
bindir=$(readlink -f "$bindir")
mandir="$testdir/../man"
mandir=$(readlink -f "$mandir")
shrmandir="$testdir/../share/man"
if [ -e "$shrmandir" ]; then
    shrmandir=$(readlink -f "$shrmandir")
fi
shrhtmlmandir="$testdir/../share/html/man"
if [ -e "$shhtmlrmandir" ]; then
    shrhtmlmandir=$(readlink -f "$shrhtmlmandir")
fi
unalias auxenv
unalias auxsource
set --
source /etc/bashrc
source ~/.bashrc
source ~/.bash_profile
# note: hopefully the auxenv alias will have been redefined
auxenv remove PATH "$bindir"
auxenv remove MANPATH "$shrmandir"
