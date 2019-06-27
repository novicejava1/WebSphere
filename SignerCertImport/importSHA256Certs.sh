#!/bin/bash



##########################################################################################################################

###  This Script is used to import signer certificates into keystore and truststore

###  Author             : Sudhir

###  Assumptions :

###  SCRIPT RUN AS      : mwadmin - [user 'mwadmin' must be part of 'mwgrp' group]

###  AGRUMENTS          : Password for keystore and truststore (i.e Default - WebAS)

###  Tested Platform    : Redat Linux

##########################################################################################################################



usage()

{

        echo "RUN THE SCRIPT WITH 'mwadmin' USER WHO IS MEMBER OF 'mwgrp' and 'PASSWORD'"

        echo "sudo su mwadmin -c ./$FILENAME <password>"

}



if [[ ! "$#" = "1" ]] || [[ "`id -ng`" != "mwgrp" ]] || [[ "`id -nu`" != "mwadmin" ]] ; then

        usage

        exit 100

fi



LOCATION=/app/scripts

PASSWORD=$1

cd $LOCATION



WASND_HOME=`ps -ef | grep dmgr | grep -v grep | awk -F ' ' '{ print $(NF-3)}' | awk -F'config' '{print $1}' | sed 's/.$//'`

WASPROFILE_HOME=`ps -ef | grep nodeagent | grep -v grep | awk -F ' ' '{ print $(NF-3)}' | awk -F'config' '{print $1}' | sed 's/.$//'`

WAS_CELL=`ps -ef | grep dmgr | grep -v grep | awk -F ' ' '{ print $(NF-2)}'`



echo $WASND_HOME

echo $WASPROFILE_HOME

echo $WAS_CELL

echo $LOCATION



DMGR_COUNT=`ps -ef | grep dmgr | grep -v grep | awk -F ' ' '{ print $(NF-3)}' | awk -F'config' '{print $1}' | sed 's/.$//' | wc -l`

PROFILE_COUNT=`ps -ef | grep nodeagent | grep -v grep | awk -F ' ' '{ print $(NF-3)}' | awk -F'config' '{print $1}' | sed 's/.$//' | wc -l`

CELL_COUNT=`ps -ef | grep dmgr | grep -v grep | awk -F ' ' '{ print $(NF-2)}' | wc -l`

CERTIFICATE_COUNT=`ls *.cer | wc -l`



echo "DMGR_COUNT        : $DMGR_COUNT"

echo "PROFILE_COUNT     : $PROFILE_COUNT"

echo "CELL_COUNT        : $CELL_COUNT"

echo "CERTIFICATE_COUNT : $CERTIFICATE_COUNT"





backupDmgrCellFiles()

{

### Backup the key store and trust store files from cell level

echo "========================================================"

echo "Backup the key store and trust store files from cell level"

echo "========================================================"



for dmgr in $WASND_HOME ; do

        dmgr_string=`echo $dmgr | awk -F"/" '{print $NF}' | sed 's/Dmgr//g'`

        for cell in $WAS_CELL ; do

                cell_string=`echo $cell | sed 's/Cell//g'`

                        if [[ "$dmgr_string" = "$cell_string" ]] ; then

                                echo "cp -p ${dmgr}/config/cells/$cell/security.xml ${dmgr}/config/cells/$cell/security.xml_b4sha2_import"

                                echo "cp -p ${dmgr}/config/cells/$cell/key.p12 ${dmgr}/config/cells/$cell/key.p12_b4sha2_import"

                                echo "cp -p ${dmgr}/config/cells/$cell/trust.p12 ${dmgr}/config/cells/$cell/trust.key.p12_b4sha2_import"

                        fi

        done

done

}



backupDmgrHomeFiles()

{

### Backup the key store and trust store files from WAS HOME level

echo "========================================================"

echo "Backup the key store and trust store files from WAS HOME level"

echo "========================================================"



for dmgr in $WASND_HOME ; do

        echo "cp -p ${dmgr}/etc/key.p12 ${dmgr}/etc/key.p12_b4sha2"

        echo "cp -p ${dmgr}/etc/trust.p12 ${dmgr}/etc/trust.p12_b4sha2"

done

}



backupProfileHomeFiles()

{

### Backup the key store and trust store files from PROFILE HOME level

echo "========================================================"

echo "Backup the key store and trust store files from PROFILE HOME level"

echo "========================================================"



for profile in $WASPROFILE_HOME ; do

        echo "cp -p ${profile}/etc/key.p12 ${profile}/etc/key.p12_b4sha2"

        echo "cp -p ${profile}/etc/trust.p12 ${profile}/etc/trust.p12_b4sha2"

done

}



dmgrCellCertImport()

{

### SHA2 root signer certs import on dmgr scope - key.p12 && trust.p12

echo "========================================================"

echo "SHA2 root signer certs import on dmgr scope - key.p12 && trust.p12"

echo "========================================================"



for cert in `ls *.cer` ; do

        alias=${cert/.cer/}

        for dmgr in $WASND_HOME ; do

                source ${dmgr}/bin/setupCmdLine.sh

                dmgr_string=`echo $dmgr | awk -F"/" '{print $NF}' | sed 's/Dmgr//g'`

                for cell in $WAS_CELL ; do

                        cell_string=`echo $cell | sed 's/Cell//g'`

                        if [[ "$dmgr_string" = "$cell_string" ]] ; then

                                echo "keytool -import -alias $alias -file $cert -keystore ${dmgr}/config/cells/$cell/key.p12 -storepass $PASSWORD -storetype pkcs12"

                                echo "keytool -import -alias $alias -file $cert -keystore ${dmgr}/config/cells/$cell/trust.p12 -storepass $PASSWORD -storetype pkcs12"

                        fi

                done

        done

done

}



dmgrCertImport()

{

### SHA2 root signer certs import on dmgr scope -/etc/key.p12 && /etc/trust.p12 

echo "========================================================"

echo "SHA2 root signer certs import on dmgr scope -/etc/key.p12 && /etc/trust.p12"

echo "========================================================"



for cert in `ls *.cer` ; do

        alias=${cert/.cer/}

        for dmgr in $WASND_HOME ; do

                source ${dmgr}/bin/setupCmdLine.sh

                echo "keytool -import -alias $alias -file $cert -keystore ${dmgr}/etc/key.p12 -storepass $PASSWORD -storetype pkcs12"

                echo "keytool -import -alias $alias -file $cert -keystore ${dmgr}/etc/trust.p12 -storepass $PASSWORD -storetype pkcs12"

        done

done

}



profileCertImport()

{

### SHA2 root signer certs import on nodeagent  scope -/etc/key.p12 && /etc/trust.p12

echo "========================================================"

echo "SHA2 root signer certs import on nodeagent  scope -/etc/key.p12 && /etc/trust.p12"

echo "========================================================"



for cert in `ls *.cer` ; do

        alias=${cert/.cer/}

        #for dmgr in $WASND_HOME ; do

        #        dmgr_string=`echo $dmgr | awk -F"/" '{print $NF}' | sed 's/Dmgr//g'`

                for profile in $WASPROFILE_HOME ; do

        #                profile_string=`echo $profile | awk -F"/" '{print $(NF-1)}' | sed 's/Cell//'`

        #                if [[ "$dmgr_string" = "$profile_string" ]] ; then

                                source ${dmgr}/bin/setupCmdLine.sh

                                echo "keytool -import -alias $alias -file $cert -keystore ${profile}/etc/key.p12 -storepass $PASSWORD -storetype pkcs12"

                                echo "keytool -import -alias $alias -file $cert -keystore ${profile}/etc/trust.p12 -storepass $PASSWORD -storetype pkcs12"

                                count=$((count+1))

        #                fi

                done

        #done

done

}





echo "Backing up files"

backupDmgrCellFiles

backupDmgrHomeFiles

backupProfileHomeFiles



echo "Importing Certs"

dmgrCellCertImport

dmgrCertImport

profileCertImport





echo $?
