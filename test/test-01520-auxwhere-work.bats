#!/usr/bin/env bats
load test_helper
@test "check auxwhere short ops" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    export MYPATH="../share/man:../dummy/share/man"
    run ../bin/auxwhere -e MYPATH -s man1 -t .1 -w auxenv
    stuff="$output"
    linecnt=0
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        line=$(echo "$line" | xargs)   # trim leading and trailing spaces
        [[ "$line" =~ ^.*/auxenv.*$ ]]
        [[ "$line" =~ ^.*Found.*$ ]]
    done
    [[ $linecnt -eq 1 ]]
}
@test "check auxwhere long ops" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    export MYPATH="../share/man:../dummy/share/man"
    run ../bin/auxwhere --env=MYPATH --subdir=man1 --type=.1 --how auxenv
    stuff="$output"
    linecnt=0
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        line=$(echo "$line" | xargs)   # trim leading and trailing spaces
        [[ "$line" =~ ^.*/auxenv.*$ ]]
        [[ "$line" =~ ^.*Found.*$ ]]
    done
    [[ $linecnt -eq 1 ]]
}
@test "check auxwhere dot" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    export MYPATH="../share/man:../dummy/share/man"
    run ../bin/auxwhere --env=MYPATH .
    stuff="$output"
    pwd=${PWD}
    linecnt=0
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        #line=$(echo "$line" | xargs)   # trim leading and trailing spaces
        [ "$line" == "$pwd" ]
    done
    [[ $linecnt -eq 1 ]]
}
@test "check auxwhere leading slash" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    export MYPATH="../share/man:../dummy/share/man"
    run ../bin/auxwhere --env=MYPATH $PWD/.
    stuff="$output"
    linecnt=0
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        #line=$(echo "$line" | xargs)   # trim leading and trailing spaces
        base=`basename "$line"`
        dir=`dirname "$line"`
        [ "$base" == "." ]
        [ "$dir" == "$PWD" ]
    done
    [[ $linecnt -eq 1 ]]
}
# all done
