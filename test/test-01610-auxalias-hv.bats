#!/usr/bin/env bats
load test_helper
@test "check auxalias help" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    for switch in "--help" "-h"; do
        run source ../bin/auxalias $switch
        [ "$status" == "0" ]
        stuff="$output"
        linecnt=0
        foundflag1="n"
        foundflag2="n"
        foundflag3="n"
        for line in ${stuff}; do
            let linecnt=$linecnt+1
            line=$(echo "$line" | xargs)   # trim leading and trailing spaces
            if [[ "$line" =~ ^auxalias.*$ ]];  then foundflag1="y"; fi
            if [[ "$line" =~ ^.*help.*$ ]];    then foundflag2="y"; fi
            if [[ "$line" =~ ^.*version.*$ ]]; then foundflag3="y"; fi
        done
        [ "$foundflag1" == "y" ]
        [ "$foundflag2" == "y" ]
        [ "$foundflag3" == "y" ]
    done
}
@test "check auxalias version" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    for switch in "--version" "-v"; do
        run source ../bin/auxalias $switch
        [ "$status" == "0" ]
        stuff="$output"
        linecnt=0
        foundflag1="n"
        foundflag2="n"
        for line in ${stuff}; do
            let linecnt=$linecnt+1
            line=$(echo "$line" | xargs)   # trim leading and trailing spaces
            if [[ "$line" =~ ^auxalias.*$ ]];  then foundflag1="y"; fi
            if [[ "$line" =~ ^.*version.*$ ]]; then foundflag2="y"; fi
        done
        [ "$foundflag1" == "y" ]
        [ "$foundflag2" == "y" ]
    done
}
# all done
