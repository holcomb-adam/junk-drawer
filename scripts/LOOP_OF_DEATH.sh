#!/usr/bin/env bash

get_help()
{
    echo "Usage: $0 OPTIONS..."
    echo "  -h,        --help            Display this help message"
    echo "  -i <n>,    --iteration <n>   Run for a number of iterations"
}

ARG_ITERATIONS=0

while getopts "hi:" opt; do
    case $opt in
        h)  get_help
            exit 0 ;;
        i)  echo "Looping $OPTARG times...";
            ARG_ITERATIONS=$OPTARG ;;
        *)  get_help
            exit 1 ;;
    esac
done

for ((i = 0; i < $ARG_ITERATIONS || $ARG_ITERATIONS == 0; i++))
do
    sleep 1
    echo "MAKE IT STOP!!!"
done
