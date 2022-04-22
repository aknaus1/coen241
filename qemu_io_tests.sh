#!/bin/bash

dir=$(pwd)
filename=$dir/io_test_results.txt
if [ ! -f $filename ]
then
    touch $filename
    echo "QEMU VM Sysbench IO Test Results" >> $filename
fi
filename2=$dir/io_test_results2.txt
if [ ! -f $filename2 ]
then
    touch $filename2
    echo "QEMU VM Sysbench IO Test Results" >> $filename2
fi

echo "IO Test with Sequential Write Mode" >> $filename
echo "--------------------------------" >> $filename
for ((counter=1; counter<6; counter++));
do
    sysbench --test=fileio --file-num=2 --file-total-size=1024 prepare
    sysbench --test=fileio --file-num=2 --file-total-size=1024 --file-test-mode=seqwr run \
    | grep "Throughput:\|read, MiB/s:\|written, MiB/s:\|Latency (ms):\|min:\|avg:\|max:\|95th percentile:\|sum" >> $filename
    sysbench --test=fileio cleanup
    sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
done

echo "IO Test with Sequential Read Mode" >> $filename2
echo "--------------------------------" >> $filename2
for ((counter=1; counter<6; counter++));
do
    sysbench --test=fileio --file-num=2 --file-total-size=1024 prepare
    sysbench --test=fileio --file-num=2 --file-total-size=1024 --file-test-mode=seqrd run \
    | grep "Throughput:\|read, MiB/s:\|written, MiB/s:\|Latency (ms):\|min:\|avg:\|max:\|95th percentile:\|sum" >> $filename2
    sysbench --test=fileio cleanup
    sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
done