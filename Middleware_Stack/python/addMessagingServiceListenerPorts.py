#!/usr/bin/python

import sys

def addMessagingServiceListenerPorts():
	jvm=AdminConfig.getid('/Server:' + jvmName + '/')
	mls=AdminConfig.list('MessageListenerService', jvm)
	AdminConfig.create('StateManageable', AdminConfig.create('ListenerPort', mls, [['destinationJNDIName', destinationJNDI],['connectionFactoryJNDIName', connectionFactory],['name', listnerName],['maxMessages', "1"],['description', description],['maxSessions', maxSession],['maxRetries', "0"]]),[['initialState', "STOP"]])
	AdminConfig.save()

jvmName = sys.argv[0]
listnerName = sys.argv[1]
state = sys.argv[2]
description = sys.argv[3]
connectionFactory = sys.argv[4]
destinationJNDI = sys.argv[5]
maxSession = sys.argv[6]

addMessagingServiceListenerPorts()
