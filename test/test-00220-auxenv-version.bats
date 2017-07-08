#!/usr/bin/env bats
load test_helper
@test "check auxenv version" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    for switch in "--version" "-v"; do
        stuff=`source ../bin/auxenv --version`
        linecnt=0
        for line in ${stuff}; do
            let linecnt=$linecnt+1
            if [ "$linecnt" == "1" ]; then
                saveline=$(echo "$line" | xargs)   # trim leading and trailing spaces
            fi
        done
        [[ $linecnt -ge 1 ]]
        [[ "$saveline" =~ ^auxenv\:\ version\ .*$ ]]
    done
}
# all done
