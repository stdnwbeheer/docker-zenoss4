#!/bin/bash
###########################################
# Version: 01a
#  Status: Functional
#   Notes: Backup script for zenoss files
###########################################

# Begin Script
clear
echo && echo "Welcome to the Zenoss Files Backup script for stdnwbeheer/docker-zenoss4!" && echo

# Script Variables
export ZENHOME=/usr/local/zenoss
export PYTHONPATH=/usr/local/zenoss/lib/python
export PATH=/usr/local/zenoss/bin:$PATH
export INSTANCE_HOME=$ZENHOME
export PATH=/opt/zenup/bin:$PATH
export DEFAULT_ZEP_JVM_ARGS="-Djetty.host=localhost -server"
DATE=$(date +%Y%m%d_%H%M)
DBUSER="zenoss"
DBPASS="zenoss"
BACKUPLOC=/zenoss-backups

# Check User
if [ `whoami` != 'zenoss' ];
        then    echo "...This script should be ran by the zenoss user!" && exit 0
        else    echo "...Check User: Passed"
fi

# Stopping Zenoss
echo "...Stopping Zenoss"
/etc/init.d/zenoss stop

# Directory Backup
echo "...Starting Directory Backup"
tar --exclude backups --exclude perf --exclude log -czf $BACKUPLOC/zenoss_backup_$DATE.tgz /usr/local/zenoss

# Starting Zenoss
echo "...Starting Zenoss"
/etc/init.d/zenoss start

echo && echo "The Zenoss Files Backup script is complete!!!" && echo
exit 0
