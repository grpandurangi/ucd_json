#!/bin/bash

LOG_FILE="ucd_deploy2.log"


{
 "name"="RHEL2NEW",
 "agent"="RHEL2NEW",
 "parent"="/UserMgmtGrpA"
}



cd /tmp
wget --no-check-certificate  https://13.78.48.145:8443/tools/udclient.zip
unzip udclient.zip

ls -l /tmp/udclient/udclient

/tmp/udclient/udclient -weburl https://13.78.48.145:8443 -username admin -password password createResource /home/azureuser/ucd_json/update_resource1agent.json >> $LOG_FILE


/tmp/udclient/udclient -weburl https://13.78.48.145:8443 -username admin -password password createResource  /home/azureuser/ucd_json/map_component_withagent1.json >> $LOG_FILE


/tmp/udclient/udclient -username admin -password password -weburl https://13.78.48.145:8443 requestApplicationProcess /home/azureuser/ucd_json/run_application_process.json >> $LOG_FILE

