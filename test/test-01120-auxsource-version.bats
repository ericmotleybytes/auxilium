#!/usr/bin/env bats
load test_helper
@test "check auxsource version --version" {
    stuff=`source ../bin/auxsource --version`
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    linecnt=0
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        if [ "$linecnt" == "1" ]; then
            saveline=$(echo "$line" | xargs)   # trim leading and trailing spaces
        fi
    done
    [ "$linecnt" == "2" ]
    [[ "$saveline" =~ ^auxsource\:\ version\ .*$ ]]
}
@test "check auxsource version -v" {
    stuff=`source ../bin/auxsource -v`
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    linecnt=0
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        if [ "$linecnt" == "1" ]; then
            saveline=$(echo "$line" | xargs)   # trim leading and trailing spaces
        fi
    done
    [ "$linecnt" == "2" ]
    [[ "$saveline" =~ ^auxsource\:\ version\ .*$ ]]
}
# all done
