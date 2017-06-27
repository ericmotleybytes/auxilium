#!/usr/bin/env bats
load test_helper
@test "check auxenv show --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin"
    spc=" "
    stuff=`source ../bin/auxenv --ifs=x20 show MYTEST`
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
@test "check auxenv dump --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin"
    stuff=`source ../bin/auxenv --ifs=x20 dump MYTEST`
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    linecnt=0
    foundflag1="n"
    foundflag2="n"
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        if [ "$line" == "/usr/local/bin" ]; then foundflag1="y"; fi
        if [ "$line" == "/usr/bin" ];       then foundflag2="y"; fi
    done
    [ "$foundflag1" == "y" ]
    [ "$foundflag2" == "y" ]
}
@test "check auxenv count --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin"
    stuff=`source ../bin/auxenv --ifs=x20 count MYTEST`
    [ "$stuff" == "2" ]
}
@test "check auxenv get --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin /root/bin"
    stuff=`source ../bin/auxenv --ifs=x20 get MYTEST 1`
    [ "$stuff" == "/usr/local/bin" ]
    stuff=`source ../bin/auxenv --ifs=x20 get MYTEST 2`
    [ "$stuff" == "/usr/bin" ]
    stuff=`source ../bin/auxenv --ifs=x20 get MYTEST 3`
    [ "$stuff" == "/root/bin" ]
    stuff=`source ../bin/auxenv --ifs=x20 get MYTEST 4`
    [ "$stuff" == "" ]
    stuff=`source ../bin/auxenv --ifs=x20 get MYTEST 0`
    [ "$stuff" == "" ]
}
@test "check auxenv find --ifs-c" {
    export MYTEST="/usr/local/bin /usr/bin /root/bin"
    stuff=`source ../bin/auxenv --ifs=x20 find MYTEST /usr/local/bin`
    [ "$stuff" == "1" ]
    stuff=`source ../bin/auxenv --ifs=x20 find MYTEST "/usr/bin"`
    [ "$stuff" == "2" ]
    stuff=`source ../bin/auxenv --ifs=x20 find MYTEST /root/bin`
    [ "$stuff" == "3" ]
    stuff=`source ../bin/auxenv --ifs=x20 find MYTEST /dummy`
    [ "$stuff" == "" ]
}
@test "check auxenv prepend --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin"
    IFS=" "
    arrone=(); for part in $MYTEST; do arrone+=("$part"); done
    [ "${#arrone[*]}" == "2" ]
    [ "${arrone[0]}" == "/usr/local/bin" ]
    [ "${arrone[1]}" == "/usr/bin" ]
    source ../bin/auxenv --ifs=x20 prepend MYTEST "/root"
    arrtwo=()
    for part in $MYTEST; do arrtwo+=("$part"); done
    [ "${#arrtwo[*]}" == "3" ]
    [ "${arrtwo[0]}" == "/root" ]
    [ "${arrtwo[1]}" == "/usr/local/bin" ]
    [ "${arrtwo[2]}" == "/usr/bin" ]
}
@test "check auxenv append --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin"
    IFS=" "
    arrone=(); for part in $MYTEST; do arrone+=("$part"); done
    #echo "${arrone[*]}" > ./file01.tmp
    #echo "${#arrone[*]}" >> ./file01.tmp
    [ "${#arrone[*]}" == "2" ]
    [ "${arrone[0]}" == "/usr/local/bin" ]
    [ "${arrone[1]}" == "/usr/bin" ]
    source ../bin/auxenv --ifs=x20 append MYTEST "/root"
    arrtwo=()
    for part in $MYTEST; do arrtwo+=("$part"); done
    [ "${#arrtwo[*]}" == "3" ]
    [ "${arrtwo[0]}" == "/usr/local/bin" ]
    [ "${arrtwo[1]}" == "/usr/bin" ]
    [ "${arrtwo[2]}" == "/root" ]
}
@test "check auxenv insert before dir --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin /dummy/bin"
    IFS=" "
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv --ifs=x20 insert MYTEST /root/one before /dummy/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    arr=();
    source ../bin/auxenv --ifs=x20 insert MYTEST /root/two before /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "5" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/root/one" ]
    [ "${arr[3]}" == "/dummy/bin" ]
    [ "${arr[4]}" == "/root/two" ]
    arr=();
    export MYTEST=""
    source ../bin/auxenv --ifs=x20 insert MYTEST /root/three before /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
    arr=();
    unset MYTEST
    source ../bin/auxenv --ifs=x20 insert MYTEST /root/three before /dummy/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/root/three" ]
}
@test "check auxenv remove --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin /dummy/bin"
    IFS=" "
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    # remove dir in list
    arr=();
    source ../bin/auxenv --ifs=x20 remove MYTEST /dummy/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "2" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    # "remove" dir not in list
    arr=();
    source ../bin/auxenv --ifs=x20 remove MYTEST /usr/local/bin/notthere
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "2" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    # remove first item in list
    arr=();
    source ../bin/auxenv --ifs=x20 remove MYTEST /usr/local/bin
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "1" ]
    [ "${arr[0]}" == "/usr/bin" ]
    # remove last item in list
    arr=();
    source ../bin/auxenv --ifs=x20 remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ ! -z "$stillset" ]
    # "remove" dir from empty
    arr=();
    source ../bin/auxenv --ifs=x20 remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ ! -z "$stillset" ]
    # "remove" dir from unset
    unset MYTEST
    arr=();
    source ../bin/auxenv --ifs=x20 remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ ! -z "$stillset" ]
    # remove last item in list with --unsetempty
    arr=();
    export MYTEST=/usr/bin
    source ../bin/auxenv --unsetempty --ifs=x20 remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=""
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ -z "$stillset" ]
    # "remove" dir from empty with --unsetempty
    arr=();
    export MYTEST=""
    source ../bin/auxenv --unsetempty --ifs=x20 remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=""
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ -z "$stillset" ]
    # "remove" dir from unset with --unsetempty
    unset MYTEST
    arr=();
    source ../bin/auxenv --unsetempty --ifs=x20 remove MYTEST /usr/bin
    for part in $MYTEST; do arr+=("$part"); done
    stillset=""
    run stillset=`printenv | grep ^MYTEST\=`
    [ "${#arr[*]}" == "0" ]
    [ "$MYTEST" == "" ]
    [ -z "$stillset" ]
}
@test "check auxenv reverse --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin /dummy/bin"
    IFS=" "
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    # reverse dir list
    arr=();
    source ../bin/auxenv --ifs=x20 reverse MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/dummy/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/usr/local/bin" ]
    # reverse an empty list
    arr=();
    export MYTEST=""
    source ../bin/auxenv --ifs=x20 reverse MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
    # reverse an unset
    arr=();
    unset MYTEST
    source ../bin/auxenv --ifs=x20 reverse MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "0" ]
}
@test "check auxenv dedup --ifs=c" {
    export MYTEST="/usr/local/bin /usr/bin /dummy/bin /usr/bin"
    IFS=" "
    arr=();
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "4" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
    [ "${arr[3]}" == "/usr/bin" ]
    # dedup default order
    arr=();
    source ../bin/auxenv --ifs=x20 dedup MYTEST
    for part in $MYTEST; do arr+=("$part"); done
    [ "${#arr[*]}" == "3" ]
    [ "${arr[0]}" == "/usr/local/bin" ]
    [ "${arr[1]}" == "/usr/bin" ]
    [ "${arr[2]}" == "/dummy/bin" ]
}
# all done
