#!/usr/bin/env bats
load test_helper
@test "check auxenv dump" {
    spacedir=$(readlink -f "fake/dir with spaces")
    export MYTEST="/usr/local/bin:/usr/bin:$spacedir"
    stuff=`source ../bin/auxenv dump MYTEST`
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    linecnt=0
    foundflag1="n"
    foundflag2="n"
    foundflag3="n"
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        if [ "$line" == "/usr/local/bin" ]; then foundflag1="y"; fi
        if [ "$line" == "/usr/bin" ];       then foundflag2="y"; fi
        if [ "$line" == "$spacedir" ];      then foundflag3="y"; fi
    done
    [ "$foundflag1" == "y" ]
    [ "$foundflag2" == "y" ]
    [ "$foundflag3" == "y" ]
}
# all done
