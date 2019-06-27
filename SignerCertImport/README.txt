#

#Purpose - To automate the importing of SHA256 certificates into key.p12 and trust.p12 stores at CELL and PROFILE level

#



#Scripts

# importSHA256Certs.sh - This scripts takes backup of the key.p12 and trust.p12 at WAS_HOME, CELL, PROFILE level and imports the Certificates into respective stores



#

# Deploying the scripts

#





# 1.	Login as mwadmin onto server

# 2.	mkdir -p /apps/scripts

# 3.	copy script and certificates to /apps/scripts directory

	Files to Copy :

		importSHA256Certs.sh

		godaddyroot.cer

		godaddyintermediate.cer

		godaddyintermediate1.cer


# 4.	chown -R mwadmin:mwgrp /apps/scripts

# 5.	Run - /apps/scripts/importSHA256Certs.sh <STORE_PASSWORD>

# The scripts are going to run with mwadmin:mwgrp user only for PROD and COB environment



# NOTE - For server without DMR profile present, comment out the below functions to suppress errors

# backupDmgrCellFiles

# backupDmgrHomeFiles

# dmgrCellCertImport

# dmgrCertImport


