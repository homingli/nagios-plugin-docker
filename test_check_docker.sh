#!/bin/bash

# mini test suite for check_docker
# only runs cases, but does not check result

G_TNUM=1

test_header() {
    # test_header <title>
    echo 
    echo == TEST $G_TNUM == $1 ==
    echo 
    G_TNUM=$((G_TNUM+1))
}

CHECK_DOCKER="./check_docker"

test_header "OUTPUT USAGE"
$CHECK_DOCKER -?

test_header "OUTPUT HELP"
$CHECK_DOCKER --help

test_header "NO ARGUMENT"
$CHECK_DOCKER

test_header "HOST: localhost, PORT: 4243"
$CHECK_DOCKER --host localhost --port 4243

test_header "SOCKET FILE: /var/run/docker.sock"
$CHECK_DOCKER -f /var/run/docker.sock
