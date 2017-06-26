#!/usr/bin/env bats
load test_helper
@test "check auxenv version" {
    stuff=`source ../bin/auxenv version`
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    linecnt=0
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        if [ "$linecnt" == "1" ]; then
            saveline=$(echo "$line" | xargs)   # trim leading and trailing spaces
        fi
        if [[ "$line" =~ ^auxenv\ \-\ .*$ ]]; then foundflag1="y"; fi
        if [[ "$line" =~ ^help\ .*$ ]];       then foundflag2="y"; fi
        if [[ "$line" =~ ^append\ .*$ ]];     then foundflag3="y"; fi
    done
    [ "$linecnt" == "1" ]
    [[ "$saveline" =~ ^auxenv\ version\ .*$ ]]
}
# all done
