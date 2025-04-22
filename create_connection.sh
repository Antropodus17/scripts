#!/bin/bash
source $BASH_CONFIG_DIR/functions/utils.sh >/dev/null 2>&1
nmcli device wifi list | sed '/s/([0-9]{2}:?){6}/a/'
