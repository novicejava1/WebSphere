#!/bin/bash

BASE=/var/tmp/scripts
SCRIPT_HOME=$BASE/bin
CONFIG_HOME=$BASE/etc
PY_HOME=$BASE/python
DMGR_HOME=`ps -ef | grep dmgr | grep -v grep | awk '{print $(NF-3)}' | sed 's/\/config//g'`
CONFIG_FILE=${CONFIG_HOME}/$(basename $0 .sh).cfg

echo $SCRIPT_HOME
echo $CONFIG_HOME
echo $PY_HOME
echo $DMGR_HOME
echo $CONFIG_FILE

# Backup config file
#cp ./$CONFIG_FILE ./${CONFIG_FILE}_original
# Read 4 lines and copy into another working file

while read line1 ; do
	read line2
	read line3
	read line4

	alias=`echo $line1 | awk -F"=" '{print $2}'`
	userId=`echo $line2 | awk -F"=" '{print $2}'`
	password=`echo $line3 | awk -F"=" '{print $2}'`
	description=`echo $line4 | awk -F"=" '{print $2}' | sed 's/\"//g'`

	arg_list=("$alias" "$userId" "$password" "$description")
	echo "${DMGR_HOME}/bin/wsadmin.sh -lang jython -f ${PY_HOME}/$(basename $0 .sh).py \"${arg_list[@]}\""
	${DMGR_HOME}/bin/wsadmin.sh -lang jython -f ${PY_HOME}/$(basename $0 .sh).py "${arg_list[@]}"
done < $CONFIG_FILE
