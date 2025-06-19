#!/bin/bash

ids=$(lspci -k | grep -A 1 "NVIDIA Corporation" | awk '{print $1}')

filtered_ids=""
for id in $ids; do
    if [[ $id =~ ^[0-9]+:[0-9]+.[0-9]$ ]]; then
        filtered_ids="$filtered_ids $id"
    fi
done

echo $filtered_ids