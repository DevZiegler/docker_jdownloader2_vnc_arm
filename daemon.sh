#!/usr/bin/env bash
#based on: https://github.com/jaymoulin/docker-jdownloader

trap 'kill -TERM $PID' TERM INT
rm -f /opt/jdownloader2/JDownloader.jar.*
rm -f /opt/jdownloader2/JDownloader.pid

# Check if JDownloader.jar exists, or if there is an interrupted update
if [ ! -f /opt/jdownloader2/JDownloader.jar ] && [ -f /opt/jdownloader2/tmp/update/self/JDU/JDownloader.jar ]; then
    cp /opt/jdownloader2/tmp/update/self/JDU/JDownloader.jar /opt/jdownloader2/
fi

# Execute JDownloader
# java -Djava.awt.headless=true -jar /opt/jdownloader2/JDownloader.jar & # no headless neaded
# DISPLAY=:0 java -jar /opt/jdownloader2/JDownloader.jar &
java -jar /opt/jdownloader2/JDownloader.jar &
PID=$!
wait $PID
wait $PID

# Debugging helper - if the container crashes, create a file called "jdownloader-block.txt" in the download folder
# The container will not terminate (and you can run "docker exec -it ... bash")
if [ -f /root/Downloads/jdownloader-block.txt ]; then
    sleep 1000000
fi

EXIT_STATUS=$?
