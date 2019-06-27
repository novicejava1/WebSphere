#!/usr/bin/python

# method used to create a new J2CAuth alias

def createAuthAlias():
    print "Adding a new J2C Auth ID: " + alias
    AdminTask.createAuthDataEntry('[-alias ' + alias + ' -user ' + userId + ' -password ' + password + ' -description "' + description + '" ]')     
    AdminConfig.save()
    print "J2C Auth ID created"

# Load the required properties from the cmd line arguments

alias = sys.argv[0]
userId = sys.argv[1]
password = sys.argv[2]
description = ""

if len(sys.argv) > 3:
    description = str(sys.argv[3])

createAuthAlias()
