#!/usr/bin/python

import sys

def addSharedLibrary():
	libscope = AdminConfig.getid(scope)
	AdminConfig.create('Library', libscope, [['name', name], ['isolatedClassLoader', "false"], ['description', description], ['classPath', classpath]])
	AdminConfig.save()

# Input parameters

scope = sys.argv[0]
name = sys.argv[1]
description = sys.argv[2]
classpath = sys.argv[3]

addSharedLibrary()
