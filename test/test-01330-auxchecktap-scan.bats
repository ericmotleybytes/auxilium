#!/usr/bin/env bats
load test_helper
@test "check auxchecktap scan clean tap file" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    for switch in "<notused>"; do
        run ../bin/auxchecktap fake/sample_with_all_ok.taplog
        [ "$status" == "0" ]
        linecnt=0
        for line in ${output}; do
            let linecnt=$linecnt+1
            if [[ $linecnt -eq 1 ]]; then
                [ "$line" == "1..3" ]
            elif [[ $linecnt -eq 2 ]]; then
                [[ "$line" =~ ^ok\ .*$ ]]
            fi
        done
        [[ $linecnt -eq 4 ]]
    done
}
@test "check auxchecktap scan dirty tap file" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    for switch in "<notused>"; do
        foundcomment="n"
        run ../bin/auxchecktap fake/sample_with_not_ok.taplog
        [ "$status" != "0" ]
        linecnt=0
        for line in ${output}; do
            let linecnt=$linecnt+1
            if [[ $linecnt -eq 1 ]]; then
                [ "$line" == "1..3" ]
            elif [[ $linecnt -eq 2 ]]; then
                [[ "$line" =~ ^not\ ok\ .*$ ]]
            elif [[ "$line" =~ ^#.*$ ]]; then
                foundcomment="y"
            fi
        done
        [[ $linecnt -ge 2 ]]
        [[ "$foundcomment" == "y" ]]
    done
}
@test "check auxchecktap scan brief dirty tap file" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    for switch in "--brief" "-b"; do
        foundcomment="n"
        run ../bin/auxchecktap $switch fake/sample_with_not_ok.taplog
        [ "$status" != "0" ]
        linecnt=0
        for line in ${output}; do
            let linecnt=$linecnt+1
            if [[ $linecnt -eq 1 ]]; then
                [ "$line" == "1..3" ]
            elif [[ $linecnt -eq 2 ]]; then
                [[ "$line" =~ ^not\ ok\ .*$ ]]
            elif [[ "$line" =~ ^#.*$ ]]; then
                foundcomment="y"
            fi
        done
        [[ $linecnt -eq 4 ]]
        [[ "$foundcomment" == "n" ]]
    done
}
@test "check auxchecktap scan multiple files" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    for switch in "dummy"; do
        ok_cnt="0"
        not_ok_cnt="0"
        comment_cnt="0"
        files=(fake/sample_with_not_ok.taplog fake/sample_with_all_ok.taplog)
        file_cnt="${#files[*]}"
        adj_cnt=$(($file_cnt+2))
        run ../bin/auxchecktap ${files[*]}
        [ "$status" != "0" ]
        linecnt=0
        for line in ${output}; do
            let linecnt=$linecnt+1
            if [[ $linecnt -eq 1 ]]; then
                [ "$line" == "1..$adj_cnt" ]
            elif [[ "$line" =~ ^ok\ .*$ ]]; then
                ok_cnt=$(($ok_cnt+1))
            elif [[ "$line" =~ ^not\ ok\ .*$ ]]; then
                not_ok_cnt=$(($not_ok_cnt+1))
            elif [[ "$line" =~ ^#.*$ ]]; then
                comment_cnt=$(($comment_cnt+1))
            fi
        done
        reports=$(($ok_cnt+$not_ok_cnt))
        [[ $linecnt -gt $adj_cnt ]]
        [[ $reports -eq $adj_cnt ]]
    done
}
@test "check auxchecktap scan clean file using stdin" {
    lf=$'\x0a'    # hex code for line-feed character
    IFS="$lf"
    stuff=`cat fake/sample_with_all_ok.taplog | ../bin/auxchecktap`
    linecnt=0
    for line in ${stuff}; do
        let linecnt=$linecnt+1
        if [[ $linecnt -eq 1 ]]; then
            [ "$line" == "1..3" ]
        elif [[ $linecnt -eq 2 ]]; then
            [[ "$line" =~ ^ok\ .*$ ]]
        fi
    done
    [[ $linecnt -eq 4 ]]
}
# all done
