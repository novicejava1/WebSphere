#!/usr/bin/python

import sys

# method used to setup the JVM custom properties for a given server

def configureJDBC():
    print '[-scope ' +scope+ ' -databaseType ' + dbType + ' -providerType "' + providerType.replace("__", " ") + '" -implementationType "' + impleType.replace("__", " ") + '" -name "' + name + '" -description "' + description + '" -classpath [ "' + classpath + '" ] -nativePath "" ]'
    AdminTask.createJDBCProvider('[-scope ' +scope+ ' -databaseType ' + dbType + ' -providerType "' + providerType.replace("__", " ") + '" -implementationType "' + impleType.replace("__", " ") + '" -name "' + name + '" -description "' + description + '" -classpath [ "' + classpath + '" ] -nativePath "" ]')
    AdminConfig.save()
    print "JDBCProvider configured with new settings"

# Load the required properties from the cmd line arguments

scope = sys.argv[0]
dbType = sys.argv[1]
providerType = sys.argv[2]
impleType = sys.argv[3]
name = sys.argv[4]
classpath = sys.argv[5]
description = ""

configureJDBC()
