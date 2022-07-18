#!/bin/bash

RED='\033[0;31m'
L_RED='\033[1;31m'
GREEN='\033[0;32m'
L_GREEN='\033[1;32m'
BROWN='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
L_BLUE='\033[1;34m'
PURPLE='\033[0;35m'
L_PURPLE='\033[1;35m'
CYAN='\033[0;36m'
L_CYAN='\033[1;36m'
LIGHTGRAY='\033[0;37m'
NC='\033[0m' # No Color

function color_print () {
    COLOR=${!1}
    shift
    printf "${COLOR}$*${NC}\n"
}

function error () {
    color_print RED "$@"
}

function warn () {
    color_print BROWN "$@"
}

function info () {
    color_print BLUE "$@"
}