#!/usr/bin/env bats
load test_helper
@test "check auxenv show" {
    export MYTEST="/usr/local/bin:/usr/bin"
    auxenvcmd="${BASH_ALIASES[auxenv]}"
    stuff=`$auxenvcmd show MYTEST`
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    linecnt=0
    foundflag1="n"
    foundflag2="n"
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        line=$(echo "$line" | xargs)   # trim leading and trailing spaces
        if [ "$line" == "1=/usr/local/bin" ]; then foundflag1="y"; fi
        if [ "$line" == "2=/usr/bin" ];       then foundflag2="y"; fi
    done
    [ "$foundflag1" == "y" ]
    [ "$foundflag2" == "y" ]
}
# all done
