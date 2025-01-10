#!/bin/bash



### Variables #######################################################################

CACHE_DIR=~/.cache/wallpaper-engine
CACHE_JSON=$CACHE_DIR/bing-biturl.json
CACHE_BING_WALLPAPER=$CACHE_DIR/bing-wallpaper.jpg
BING_BITURL='https://bing.biturl.top/?resolution=1920&format=json&index=0&mkt=zh-CN'
POLL_RATE=30m



### Functions #######################################################################

info() {
    echo -e "[info]\t$@"
}

prepare() {
    # Yikes! Hopefully leave enough time for WM/DE to load!
    sleep 1s # yikes

    [[ -d $CACHE_DIR ]] || {
        info "Preparing cache directory '$CACHE_DIR'"
        mkdir $CACHE_DIR
    }
    [[ -f $CACHE_JSON ]] || {
        info "Creating empty JSON file"
        touch $CACHE_JSON
    }
    if [ -f $CACHE_BING_WALLPAPER ]; then
        info "Updating wallpaper..."
        update-wallpaper
    fi
}

poll-json() {
    JSON=$(curl -s $BING_BITURL)
}

parse-json() {
    if [[ -z "$JSON" ]]; then
        echo "JSON was not found"
        return 1
    fi

    local DATE_OLD=$(jq -r .end_date $CACHE_JSON)
    local DATE_NEW=$(echo $JSON | jq -r .end_date)
    if (( DATE_NEW == DATE_OLD )); then
        echo "Wallpaper up to date!"
        return 2
    fi

    info "Caching JSON @ '$CACHE_JSON'"
    echo $JSON > $CACHE_JSON
}

fetch-bing-wallpaper() {
    local URL=$(jq -r .url $CACHE_JSON)
    wget -O $CACHE_BING_WALLPAPER "$URL"
}

update-wallpaper() {
    info "loading $CACHE_BING_WALLPAPER"
    hyprctl hyprpaper unload $(hyprctl hyprpaper listactive | awk '{print $2}')
    hyprctl hyprpaper preload $CACHE_BING_WALLPAPER
    hyprctl hyprpaper wallpaper "DP-1,$CACHE_BING_WALLPAPER"
}



### Main #######################################################################

info "Preparing..."
prepare
while :
do
    info "Polling JSON from '$BING_BITURL'"
    poll-json

    info "Parsing JSON..."
    if parse-json; then
        info "Downloading Bing wallpaper..."
        fetch-bing-wallpaper

        info "Updating the wallpaper..."
        update-wallpaper
    fi
    sleep $POLL_RATE
done
