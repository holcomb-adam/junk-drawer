#!/bin/bash

CONFIG_DIR=~/.config/status-tray
ENTRIES_DIR=$CONFIG_DIR/entries
DEFAULT_ENTRY="date +%c"

prepare() {
    [[ -d $CONFIG_DIR ]] || {
        mkdir $CONFIG_DIR
    }
    [[ -d $ENTRIES_DIR ]] || {
        mkdir $ENTRIES_DIR
        echo $DEFAULT_ENTRY > $ENTRIES_DIR/1
    }
}

source_entries() {
    for ENTRY in $ENTRIES_DIR/*; do
        source $ENTRY
    done
}



prepare
cache_entries

OUTPUT=""
for (( IT=0; IT <= ${#ENTRIES_CACHE[@]}; IT++ )); do
    if [ -n "$OUTPUT" ]; then
        OUTPUT=" | $OUTPUT"
    fi

    OUTPUT="$(${ENTRIES_CACHE[$IT]})$OUTPUT"
done

echo -e "$OUTPUT"
