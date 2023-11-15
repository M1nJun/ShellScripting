#!/bin/bash

cur_tag=“”
cur_file=“”
count=0

sort fwd.log >sorted.txt

while read tag file time; do
    if [“$tag” == “$cur_tag”] && [“file” == “$cur_file”]; then
        ((count++))
    else
        if [-n “$cur_tag”]; then
            echo $cur_tag $cur_file $count
        fi
        cur_tag=$tag
        cur_file=$file
        count=1
    fi
done <sorted.txt

echo $cur_tag $cur_file $count
