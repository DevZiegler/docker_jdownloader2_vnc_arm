#!/bin/bash
#based on: https://github.com/jaymoulin/docker-jdownloader

usage="$(basename "$0") <email> <password>"

if [ ! $# -eq 2 ]; then
    echo "$usage"
    exit 1
fi

if [ ! -f /opt/jdownloader2/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json ]; then
    cp /opt/jdownloader2/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json.dist /opt/jdownloader2/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json
fi

if [ -f /opt/jdownloader2/credentials ]; then
    cred=($(cat /opt/jdownloader2/cfg/credentials))
    sed -i "s/\"password\" : \"${cred[1]}\",/\"password\" : \"$2\",/" /opt/jdownloader2/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json && \
    sed -i "s/\"email\" : \"${cred[0]}\"/\"email\" : \"$1\"/" /opt/jdownloader2/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json
else
    sed -i "s/\"password\" : null,/\"password\" : \"$2\",/" /opt/jdownloader2/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json && \
    sed -i "s/\"email\" : null/\"email\" : \"$1\"/" /opt/jdownloader2/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json
fi

echo -e "$1\n$2" > /opt/jdownloader2/credentials
pkill -f "JDownloader"
