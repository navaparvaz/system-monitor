#!/bin/bash

get_cpu_usage(){
echo "CPU Usage:"
 mpstat 1 1 | awk '/Average:/ && $2 == "all" {printf "  Used: %.1f%%\n", 100-$NF}'
echo " "
}

get_memory_usage(){
echo "Memory Usage:"
free -m | awk '/^Mem:/ {printf "%.1f", ($2-$7)/$2*100}'
echo " "
}

get_disk_usage(){
echo "Disk Usage:"
 df -h --total | awk 'nr==2 {PRINT $5}'
echo " "
}

get_top_cpu_processes(){
echo "Top 10 Process by CPU Usage:"
ps aux --sort=-%cpu | head -11 | awk '{printf "%-10s %8s %6s%%  %s\n", $1, $2, $3, $11}'
echo " "
}
get_top_mem_processes(){
echo "Top 10 Process by Memory Usage:"
ps aux --sort=-%mem | head -11 | awk '{printf "%-10s %8s %6s%%  %s\n", $1, $2, $4, $11}'
echo " "
}
get_extra_stats(){

    echo "OS Version:"

    lsb_release -a 2>/dev/null || cat /etc/os-release
    echo " "


    echo "Uptime:"

    uptime
    echo " "



    echo "Load Average:"

    cat /proc/loadavg
    echo " "


    echo "Logged in users:"
    who
    echo " "
}
get_cpu_usage

get_memory_usage

get_disk_usage

get_top_cpu_processes

get_top_mem_processes

get_extra_stats
