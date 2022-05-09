#!/bin/bash

dir=$(pwd)
filename=$dir/cpu_test_results.txt
if [ ! -f $filename ]
then
    touch $filename
    echo "QEMU VM Sysbench CPU Test Results" >> $filename
fi

for ((i=1; i<4; i++))
do
    nthreads=$((2**$i))
    echo "CPU Test with $nthreads Threads" >> $filename
    echo "--------------------------------" >> $filename
    for ((counter=1; counter<6; counter++));
    do
        sysbench --test=cpu --threads=$nthreads --cpu-max-prime=100000 --time=30 run | grep "events per second:\|total number of events:" >> $filename
    done
done