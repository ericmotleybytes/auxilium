#!/usr/bin/env bats
load test_helper
@test "check auxsource path file" {
    tempdir="$AUXILIUM_TEMPDIR"
    mkdir -p "$tempdir"
    [ -d "$tempdir" ]
    export AUXSOURCE_PATH="$tempdir"
    export AUXSOURCE_OPTIONS="--env=AUXSOURCE_PATH"
    echo "export MYTEST1=\"\$1\""  >  "$tempdir"/temp.bash
    echo "export MYTEST2=\"\$2\""  >> "$tempdir"/temp.bash
    source ../bin/auxsource temp.bash xxx "hello world"
    unset AUXSOURCE_PATH
    unset AUXSOURCE_OPTIONS
    [ "$MYTEST1" == "xxx" ]
    [ "$MYTEST2" == "hello world" ]
}
@test "check auxsource spec file" {
    tempdir="$AUXILIUM_TEMPDIR"
    mkdir -p "$tempdir"
    [ -d "$tempdir" ]
    export AUXSOURCE_PATH="$tempdir"
    export AUXSOURCE_OPTIONS="--env=AUXSOURCE_PATH"
    echo "export MYTEST1=\"\$1\""  >  "$tempdir"/temp.bash
    echo "export MYTEST2=\"\$2\""  >> "$tempdir"/temp.bash
    source ../bin/auxsource "$tempdir"/temp.bash xxx "hello world"
    unset AUXSOURCE_PATH
    unset AUXSOURCE_OPTIONS
    [ "$MYTEST1" == "xxx" ]
    [ "$MYTEST2" == "hello world" ]
}
# all done
