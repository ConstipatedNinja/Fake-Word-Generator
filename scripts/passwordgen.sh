#!/bin/bash

if [ -z $1 ]; then
    TIMES="1"
else
	TIMES="$1"
    echo "$1 times"
fi
if [ -z $2 ]; then
    SCRIPT=""
else
    SCRIPT="$2"
fi

for m in `seq 1 $TIMES`; do
PASSYWORD=`./autotypewrite $SCRIPT | grep "....." | shuf -n 2`
PASSWORD=$( echo "$PASSYWORD" | perl -pe 's/\n//g' )
PASSYWORD=`echo "${PASSYWORD}" | perl -pe 's/\n/ /g'`

ENDSTRING=`date +%B`
ENDSTRING="${ENDSTRING}:"
for (( i=0; i<${#PASSWORD}; i++ )); do
    CHARACTER="${PASSWORD:$i:1}"
    if [ $(( RANDOM % 2 )) -eq "0" ]; then
        if [ "$(( RANDOM % 2 ))" -eq "0" ]; then
            GENPASS[$i]=$( echo "${CHARACTER}" | tr '[:lower:]' '[:upper:]' )
        else
            GENPASS[$i]=$( echo "${CHARACTER}" | tr 'abcdefghijklmnopqrstuvwxyz' '@%(&3$&4*~_|{}]!;:$+_<#`^2' )
        fi
    else
        GENPASS[$i]=$CHARACTER
    fi
done
#echo $PASSYWORD
GENERATED=`printf '%s' "${GENPASS[@]}"`
#echo
#echo "$ENDSTRING"
o="${#ENDSTRING}"
for (( i="$o"; i<=14; i++ )); do
  ENDSTRING="${ENDSTRING} "
done
ENDSTRING="${ENDSTRING}${GENERATED}"
o=${#ENDSTRING}
for (( i="$o"; i<=35; i++ )); do
  ENDSTRING="${ENDSTRING} "
done
ENDSTRING="${ENDSTRING}# $PASSYWORD"
echo "$ENDSTRING"
#echo "$GENERATED"
SALT="$( cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1 )"
export GENERATED
export SALT
HASH=`perl -e 'print crypt("$ENV{'GENERATED'}","\\$6\\$$ENV{'SALT'}\\$") . "\n"'`
echo -e "        SALT $SALT HASH $HASH\n"
done
