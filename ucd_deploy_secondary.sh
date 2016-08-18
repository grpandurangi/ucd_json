#!/bin/bash

LOG_FILE="`echo $1`.log"
UPDATE_RESOURCE="/tmp/update_resourceagent.json"
MAP_COMPONENT="/tmp/map_component_withagent.json"
RUN_APP_PROCESS="/tmp/run_application_process.json"

/bin/cat <<EOM >$UPDATE_RESOURCE
{
 "name"="RHEL2NEW",
 "agent"="RHEL2NEW",
 "parent"="/UserMgmtGrpA"
}
EOM

/bin/cat <<EON >$MAP_COMPONENT
{
 "parent"="/UserMgmtGrpA/RHEL2NEW",
 "component"="ApplicationComponent"
}
EON

/bin/cat <<EOR >$RUN_APP_PROCESS
{
  "application": "UserMgmtApp",
  "description": "Deploying newest versions",
  "applicationProcess": "ApplicationDeployment",
  "environment": "UserDBAppDev",
  "onlyChanged": "true",
  "versions": [
    {
      "version": "latest",
      "component": "ApplicationComponent"
    },
  ]
}
EOR

if [[ ! -f /tmp/udclient.zip ]]; then
cd /tmp
wget --no-check-certificate  https://13.78.48.145:8443/tools/udclient.zip
fi
unzip -o udclient.zip

JRE_FOLDER=$(find /usr -type d -name jre|head -1)
J_HOME="JAVA_HOME=\"$JRE_FOLDER\""
sed -i "/^#JAVA_OPTS/a $J_HOME" /tmp/udclient/udclient

/tmp/udclient/udclient -weburl https://13.78.48.145:8443 -username admin -password password createResource $UPDATE_RESOURCE >> $LOG_FILE

/tmp/udclient/udclient -weburl https://13.78.48.145:8443 -username admin -password password createResource  $MAP_COMPONENT >> $LOG_FILE

/tmp/udclient/udclient -username admin -password password -weburl https://13.78.48.145:8443 requestApplicationProcess $RUN_APP_PROCESS >> $LOG_FILE
