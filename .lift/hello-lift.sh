#!/usr/bin/env bash

#SAW=$HOME/work/saw-script/dist-newstyle/build/x86_64-linux/ghc-8.10.7/saw-script-0.9.0.99/build/saw/saw
SAW=saw

function tellApplicable() {
    printf "true"
}

function tellVersion() {
    printf "1"
}

function run() {
    local SEP=""
    echo "["

    file="solution.saw"
    msg=$("$SAW" "$file" 2>&1)
    if [ $? -ne 0 ]; then
        msg0=${msg//$'\n'/'\n'}
        msg1=${msg0//'"'/'\"'}
        line=1
        printf "\
{ \
\"message\": \"%s\", \
\"file\": \"%s\", \
\"line\": %d, \
\"type\": \"SAW\" \
}\n" "$msg1" "$file" "$line"
    fi

    #for file in $(git ls-files) ; do
    #    if [[ ( -f "$file" ) && ( $(wc -l < "$file") -gt 1337 ) ]] ; then
    #        printf "%s" "$SEP"
    #        author=$(git blame "$file" --porcelain 2>/dev/null | grep  "^author " | head -n1)
    #        msg="$author did a bad job and they should feel bad"
    #        printf "{ \"message\": \"%s\", \
    #            \"file\": \"%s\", \
    #            \"line\": 123, \
    #            \"type\": \"Over-length file\" \
    #             }\n" "$msg" "$file"
    #        SEP=","
    #    fi
    #done
    echo "]"
}

case "$3" in
    run)
        run
        ;;
    applicable)
        tellApplicable
        ;;
    version)
        tellVersion
        ;;
    default)
        echo "What? Check my version, I'm 1 (bulk)"
esac
