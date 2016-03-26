#!/bin/bash

echo ""
echo "-----------------------------"
echo "Application Thread Monitoring"
echo "-----------------------------"
echo ""

#-----------------------------------------------------
#
# Script to monitor Thread from an Application
# Author : Badji Thierry
#          Bignumb-bi-Kumb Boris Kurtis
# Date 20/03/16
#
#   Usage : ./atm -p PID
#   With PID is the PID of the application you want to
#   Analyze.
#-----------------------------------------------------


#-----------------------------------------------------
#   Variables declaration
#----------------------------------------------------


#-----------------------------------------------------
#   Functions declaration
#-----------------------------------------------------

display_help()
{
    echo ""
    echo "atm : Thread Priority Analysis"
    echo "Usage : ./atm.sh -p PID"
    echo "PID is an integer corresponding to the PID"
    echo "of the application you want to analyze"
    echo ""
}

print_thread_info()
{
    echo "---------------------------------"
    echo "Thread ID : $1"
    echo "Thread Name : $2"
    echo "Thread Priority : $3"
    echo "Thread Scheduling Policy : $4"
    decode_thread_state $5
    echo "---------------------------------"
    echo ""
}

decode_thread_state()
{
    case "$1" in 
        S) echo "Thread State : Sleeping in an interruptible wait"
            ;;
        R) echo "Thread State : Running"
            ;;
        D) echo "Thread State : Waiting in uninterruptible disk sleep"
            ;;
        Z) echo "Thread State : Zombie"
            ;;
        *) echo "Thread State : Other state"
    esac
}
#-----------------------------------------------------
#   Main
#-----------------------------------------------------

if [ -z $1 ]; 
then
    echo "See the help (-h)to understand how to use TPA."

elif [ $1 == "-h" ]; 
then
    display_help;
elif [ $1 == "-p" ]; 
then
    appPID="$2"
    pathToTID="/proc/$appPID/task/*"
    echo ""
    echo "Application PID : $appPID"
    echo "--START ATM--"
    for tids in /proc/$appPID/task/*
    do
        tid=$( echo "$tids" | cut -d "/" -f 5 )
        
        if [ -e "/proc/$appPID/task/$tid/stat" ];
        then
            thread_name=$(awk '{ print $2}' /proc/$appPID/task/$tid/stat)
            thread_priority=$(awk '{ print $18}' /proc/$appPID/task/$tid/stat)
            thread_id=$(awk '{ print $1}' /proc/$appPID/task/$tid/stat)
            thread_scheduling_policy=$(awk '{ print $41}' /proc/$appPID/task/$tid/stat)
            thread_state=$(awk '{ print $3}' /proc/$appPID/task/$tid/stat)
            print_thread_info $thread_id $thread_name $thread_priority $thread_scheduling_policy $thread_state
        else
            echo "Thread with PID $1 doesn't exist or has no other threads."
        fi
    done
    echo "--END ATM--"
    echo ""
elif [ $1 == "-h" ];
then
    echo " Usage of ATM"
fi

#-----------------------------------------------------
#   End
#-----------------------------------------------------
