# setup interactive aliases and paths to point to dev working copy
testdir="${BASH_SOURCE[0]%/*}"
testdir=$(readlink -f "$testdir")
bindir="$testdir/../bin"
bindir=$(readlink -f "$bindir")
mandir="$testdir/../man"
mandir=$(readlink -f "$mandir")
shrmandir="$testdir/../share/man"
mkdir -p "$shrmandir"
shrmandir=$(readlink -f "$shrmandir")
shrhtmlmandir="$testdir/../share/html/man"
mkdir -p "$shrhtmlmandir"
shrhtmlmandir=$(readlink -f "$shrhtmlmandir")
alias auxenv="source $bindir/auxenv"
alias auxsource="source $bindir/auxsource"
export PATH="$bindir:$PATH"
auxenv dedup PATH
export MANPATH="$shrmandir:$MANPATH"
auxenv dedup MANPATH
