#!/usr/bin/env bash

echo_help()
{
    echo "Usage: detach OPTIONS... COMMAND"
    echo "OPTIONS:"
    echo "    -h  --help              Get this help message"
    echo "    -a  --keep-attached     Keep process as a shell job"
    echo "    -o  --keep-stdout       Keep stdout of the detached process"
    echo "    -v  --verbose           Be verbose"
}

USER_COMMAND=()

OPT_VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h | --help)
            echo_help
            exit 0
            ;;
        -a | --keep-attached)
            ;;
        -o | --keep-stdout)
            ;;
        -v | --verbose)
            OPT_VERBOSE=true
            ;;
        -*|--*)
            echo "Unknown option $1"
            echo_help
            exit 1
            ;;
        *)
            USER_COMMAND+=($1)
            ;;
    esac
    shift
done

# Check if command was found
if [ -z $USER_COMMAND ]; then
    echo "No command was specified"
    echo_help
    exit 1
fi

if $OPT_VERBOSE; then
    echo "Running command ${USER_COMMAND[@]}"
fi

# Ignore HANGUP signals for the user command and
# redirect stdio to /dev/null then start as a background process
nohup ${USER_COMMAND[@]} </dev/null >/dev/null 2>&1 &

# Detach the most recent job
disown

# Print the PID of the recently created process
echo "Process PID: $!"
