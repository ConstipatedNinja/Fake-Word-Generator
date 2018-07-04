#!/bin/bash

PASSYWORD=`./autotypewrite | grep "....." | shuf -n 2`
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
