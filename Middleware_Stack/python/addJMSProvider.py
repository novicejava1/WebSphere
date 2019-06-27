#!/usr/bin/python

import sys

def addJMSProvider():
	node=AdminConfig.getid(scope)
	AdminConfig.create('JMSProvider', node, [['name', name], ['description', description], ['classpath', classpath], ['externalInitialContextFactory', extICF], ['externalProviderURL', externalProviderUrl]])
	AdminConfig.save()

scope = sys.argv[0]
name = sys.argv[1]
description = sys.argv[2]
classpath = sys.argv[3]
extICF = sys.argv[4]
externalProviderUrl = sys.argv[5]

addJMSProvider()

	
