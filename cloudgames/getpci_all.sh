#!/bin/bash

ids=$(lspci -k | grep -A 1 "NVIDIA Corporation" | awk '{print $1}')

filtered_ids=""
for id in $ids; do
    # 放宽正则表达式匹配条件，允许字母开头
    if [[ $id =~ ^[a-zA-Z0-9]+:[a-zA-Z0-9]+.[a-zA-Z0-9]$ ]]; then
        filtered_ids="$filtered_ids $id"
    fi
done

echo $filtered_ids