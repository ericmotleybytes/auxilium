setup() {
    export AUXILIUM_ORG_IFS="$IFS"
    export AUXILIUM_TEMPDIR="${PWD}/temporary"
    source ./setup_aliases.bash
}
teardown() {
    IFS="$AUXILIUM_ORG_IFS"
    if [ -d "$AUXILIUM_TEMPDIR" ]; then rm -rf "$AUXILIUM_TEMPDIR"; fi
}
