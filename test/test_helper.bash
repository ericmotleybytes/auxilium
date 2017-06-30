setup() {
    export AUXILIUM_ORG_IFS="$IFS"
    export AUXILIUM_TEMPDIR="${PWD}/temporary"
    #testdir="${BASH_SOURCE[0]%/*}"
    testdir="."
    testdir=$(readlink -f "${testdir}")
    bindir="${testdir}/../bin"
    bindir=$(readlink -f "${bindir}")
    # make sure aliases point to dev programs being tested (for auxenv, auxsource, and auxalias)
    set --
    source "$bindir/auxalias"
    # make sure dev bin directory first on PATH search (for auxguidish, and auxchecktap)
    export PATH="$bindir:$PATH"
}
teardown() {
    IFS="$AUXILIUM_ORG_IFS"
    if [ -d "$AUXILIUM_TEMPDIR" ]; then rm -rf "$AUXILIUM_TEMPDIR"; fi
}
