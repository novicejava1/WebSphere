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

while read line1 ; do
	read line2
	read line3
	scope=`echo $line1 | sed 's/scope=//g' | sed 's/\"//g'`
	name=`echo $line2 | awk -F"=" '{print $2}' | sed 's/\"//g'`
	value=`echo $line3 | awk -F"=" '{print $2}' | sed 's/\"//g'`

	arg_list=("$scope" "$name" "$value")
	echo "${DMGR_HOME}/bin/wsadmin.sh -lang jython -f ${PY_HOME}/$(basename $0 .sh).py \"${arg_list[@]}\""
	${DMGR_HOME}/bin/wsadmin.sh -lang jython -f ${PY_HOME}/$(basename $0 .sh).py "${arg_list[@]}"
done < $CONFIG_FILE
