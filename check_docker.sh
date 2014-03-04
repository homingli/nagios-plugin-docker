#!/bin/bash

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

PROGNAME=`/usr/bin/basename $0`
VERSION="0.0.1"

NC="/bin/nc"

print_usage() {
    echo "Usage: $PROGNAME --host host --port port"
    echo "Usage: $PROGNAME [--help|-?]"
    echo "Usage: $PROGNAME --version"
}

print_help() {
    print_usage
}

# defaults
NC_OPTS="-U /var/run/docker.sock"
PORT=4243
HOST="localhost"

while test -n "$1"; do
    case "$1" in
        --help)
            print_usage
            exit $STATE_OK
            ;;
        "-?")
            print_usage
            exit $STATE_OK
            ;;
        -f)
            shift
            NC_OPTS="-U $1"
            ;;
        --host)
            shift
            HOST=$1
            NC_OPTS="$HOST $PORT"
            ;;
        --port)
            shift
            echo $1
            PORT=$1
            NC_OPTS="$HOST $PORT"
            ;;
        *)
            echo "Unknown argument: $1"
            exit $STATE_UNKNOWN
            ;;
    esac
    shift
done

echo $HOST $PORT $NC_OPTS
echo -e "GET /info HTTP/1.1\r\n" | $NC $NC_OPTS
echo
