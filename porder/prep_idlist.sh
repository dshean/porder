#! /bin/bash

cat $1 | tr ',' '\n' | sed -e 's/SkySatScene://g' -e 's/ *//g' > ${1%.*}_fmt.txt
