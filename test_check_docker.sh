#!/bin/bash

CHECK_DOCKER="./check_docker.sh"

echo 
echo ==Test 1== OUTPUT USAGE
echo 
$CHECK_DOCKER -?

echo 
echo ==Test 2== OUTPUT HELP
echo 
$CHECK_DOCKER --help

echo 
echo ==Test 3== NO_ARG
echo 
$CHECK_DOCKER

echo 
echo ==Test 4== HOST: localhost, PORT: 4243
echo 
$CHECK_DOCKER --host localhost --port 4243

echo
echo ==Test 5== SOCKET FILE: /var/run/docker.sock
echo 
$CHECK_DOCKER -f /var/run/docker.sock
