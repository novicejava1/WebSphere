#!/usr/bin/python

import sys

def addEnvironmentVariable():
	variableXml=AdminConfig.getid(scope + 'VariableMap:/')
	AdminConfig.create('VariableSubstitutionEntry', variableXml , '[[symbolicName ' + name + '] [description ""] [value ' + value + ' ]]')
	AdminConfig.save()

scope = sys.argv[0]
name = sys.argv[1]
value = sys.argv[2]

addEnvironmentVariable()
