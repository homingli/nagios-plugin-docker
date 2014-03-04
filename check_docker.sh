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
    echo $PROGNAME $VERSION
    echo
    print_usage
    echo
    echo Docker plugin for Nagios
    echo
}

# defaults
NC_OPTS="-U /var/run/docker.sock"
PORT=4243
HOST="localhost"

while test -n "$1"; do
    case "$1" in
        --help)
            print_help
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
            PORT=$1
            NC_OPTS="$HOST $PORT"
            ;;
        *)
            echo "ERROR: Unknown argument: $1"
            echo
            print_usage
            exit $STATE_UNKNOWN
            ;;
    esac
    shift
done

REQUEST="GET /info HTTP/1.1\r\n"
echo -e $REQUEST | $NC $NC_OPTS
RC=$?
echo
if [ $RC -ne 0 ]; then
    echo ERROR: $REQUEST -- returned $RC
    exit $RC
fi

