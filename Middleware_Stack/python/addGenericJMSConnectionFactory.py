#!/usr/bin/python

import sys

def addGenericJMSConnectionFactory():
	providerId=AdminConfig.getid(scope + ' JMSProvider: ' + providerName)
	AdminConfig.create('GenericJMSConnectionFactory', providerId, [['name', name], ['jndiName', jndiname], ['description', description], ['externalJNDIName', externalJNDIName]])
	AdminConfig.save()

scope = sys.argv[0]
providerName = sys.argv[1]
name = sys.argv[2]
description = sys.argv[3]
jndiname = sys.argv[4]
externalJNDIName = sys.argv[5]

addGenericJMSConnectionFactory()
