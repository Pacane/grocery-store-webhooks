#!/bin/bash
GROCERY_STORE="../grocery-store"
CLIENT_PATH="../grocery-store"

echo "killing existing client"
CLIENT_PID=$(head -n 1 client.pid)
kill -9 $CLIENT_PID

echo "Resetting master branch"
(cd $GROCERY_STORE && git reset --hard pacane/master)
(cd $GROCERY_STORE && git pull pacane master)

echo "starting client"
(cd $CLIENT_PATH && pub serve --port=3001 --hostname=stacktrace.ca --mode=release) &

echo $(ps aux | awk '/--port=3000/ {print $2;}' | head -n1) > client.pid

