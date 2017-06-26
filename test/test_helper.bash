setup() {
    source ./setup_aliases.bash
    oldIFS="$IFS"
}
teardown() {
    IFS="$oldIFS"
}
