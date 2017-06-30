#!/usr/bin/env bats
load test_helper
@test "check auxguidish version" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    for switch in "--version" "-v"; do
        stuff=`../bin/auxguidish $switch`
        linecnt=0
        foundflag1="n"
        foundflag2="n"
        for line in ${stuff}; do
            let linecnt=$linecnt+1
            line=$(echo "$line" | xargs)   # trim leading and trailing spaces
            if [[ "$line" =~ ^auxguidish.*$ ]]; then foundflag1="y"; fi
            if [[ "$line" =~ ^.*version.*$ ]]; then foundflag2="y"; fi
        done
        [ "$foundflag1" == "y" ]
        [ "$foundflag2" == "y" ]
    done
}
# all done
