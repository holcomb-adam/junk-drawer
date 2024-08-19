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
        echo $DEFAULT_ENTRY > $ENTRIES_DIR/date
    }
}

source_entries() {
    for ENTRY in $ENTRIES_DIR/*; do
        source $ENTRY
    done
}



prepare
#cache_entries

OUTPUT=""
for entry in $ENTRIES_DIR/*; do
    if [ -n "$OUTPUT" ]; then
        OUTPUT=" | $OUTPUT"
    fi

    OUTPUT="$($entry)$OUTPUT"
done

echo -e "$OUTPUT"
