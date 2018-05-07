#!/bin/sh

update_chrooted conf
ip a

exec launch.sh --web $WEB $VNC_RUN_PARAMS
