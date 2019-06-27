#/usr/bin/python



#AdminTask.createDatasource('"CDE DB2 Provider(cells/mdwrCell/nodes/mdwrDmgrNode|resources.xml#JDBCProvider_1517376028368)"', '[-name CDE_DB2_AU -jndiName jdbc/CDE_DB2_AU -dataStoreHelperClassName com.ibm.websphere.rsadapter.DB2UniversalDataStoreHelper -containerManagedPersistence true -componentManagedAuthenticationAlias CDEDmgrNode/FCWAUCZ2 -configureResourceProperties [[databaseName java.lang.String RD01DBAG] [driverType java.lang.Integer 4] [serverName java.lang.String RUSADVIPA.gcb-us-hosts.citicorp.com] [portNumber java.lang.Integer 5098]]]')



import sys
# method used to add an datasource in a given scope
def configureDatasource():
    jdbcProviderId = AdminConfig.getid(scope + 'JDBCProvider:' + providerName + '/')

    # get dbtype from provider to establish correct helper class 
    providerType = AdminConfig.showAttribute(jdbcProviderId, 'providerType')

    helperClass = ""

    if providerType.startswith("Oracle"):
        helperClass = "com.ibm.websphere.rsadapter.Oracle11gDataStoreHelper"
    elif providerType.startswith("Sybase"):
        helperClass = "com.ibm.websphere.rsadapter.SybaseDataStoreHelper"
    elif providerType.startswith("DB2"):
        helperClass = "com.ibm.websphere.rsadapter.DB2UniversalDataStoreHelper"

    cmpAuth = ""    
    if j2cauthAlias != "None" and j2cauthAlias != "":
        cmpAuth = ' -componentManagedAuthenticationAlias ' + j2cauthAlias

#    AdminTask.createDatasource(jdbcProviderId, '[-name ' + dsName \
#        + ' -jndiName ' + jndiName \
#        + ' -containerManagedPersistence true' \
#        + cmpAuth \
#        + ' -dataStoreHelperClassName ' + helperClass \
#        + ' -xaRecoveryAuthAlias' \
#        + ' -configureResourceProperties [[URL java.lang.String ' + url + ']]]') 

#     AdminTask.createDatasource('jdbcProviderId', '[-name ' + dsName \
#         + ' -jndiName ' + jndiName \
#         + ' -dataStoreHelperClassName ' + helperClass \
#         + ' -containerManagedPersistence true ' \ 
#         + cmpAuth \
#         + ' -configureResourceProperties [[databaseName java.lang.String ' + databaseName + ' ] [driverType java.lang.Integer ' + databaseType + ' ] [serverName \ 
#         java.lang.String ' + serverName + ' ] [portNumber java.lang.Integer ' + serverPort + ' ]]]')

#     AdminConfig.save()

    AdminTask.createDatasource(jdbcProviderId, '[-name ' + dsName \
    + ' -jndiName ' + jndiName \
    + ' -dataStoreHelperClassName ' + helperClass \
    + ' -containerManagedPersistence true ' \
    + cmpAuth \
    + ' -configureResourceProperties [[databaseName java.lang.String ' + databaseName + ' ] [driverType java.lang.Integer ' + databaseType + ' ] [serverName \
    java.lang.String ' + serverName + ' ] [portNumber java.lang.Integer ' + serverPort + ' ]]]')

    AdminConfig.save()

# Load the required properties from the cmd line arguments

scope = sys.argv[0]
dsName = sys.argv[1]
jndiName = sys.argv[2]
providerName = sys.argv[3]
j2cauthAlias = sys.argv[4]
databaseName = sys.argv[5]
databaseType = sys.argv[6]
serverName = sys.argv[7]
serverPort = sys.argv[8]

configureDatasource()
