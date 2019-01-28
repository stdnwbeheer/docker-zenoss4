#!/bin/bash
###########################################
# Version: 01a
#  Status: Functional
#   Notes: Backup script for zenoss sql
###########################################

# Begin Script
clear
echo && echo "Welcome to the Zenoss SQL Backup script for stdnwbeheer/docker-zenoss4!" && echo

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

# MySQL Backup
echo "...Starting MySQL Backup"
mkdir -p $BACKUPLOC
mysqldump -u$DBUSER -p$DBPASS zenoss_zep > $BACKUPLOC/zenoss_zep_$DATE.sql
mysqldump -u$DBUSER -p$DBPASS zodb > $BACKUPLOC/zodb_$DATE.sql
mysqldump -u$DBUSER -p$DBPASS zodb_session > $BACKUPLOC/zodb_session_$DATE.sql

echo && echo "The Zenoss SQL Backup script is complete!!!" && echo
exit 0
