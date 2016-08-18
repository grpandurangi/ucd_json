#!/bin/bash

LOG_FILE="ucd_deploy.log"

/root/udclient/udclient -weburl https://13.78.48.145:8443 -username admin -password password createResource /home/azureuser/ucd_json/create_baseresourceA.json >> $LOG_FILE


/root/udclient/udclient -weburl https://13.78.48.145:8443 -username admin -password password createResource /home/azureuser/ucd_json/update_resource2agent.json >> $LOG_FILE


/root/udclient/udclient -weburl https://13.78.48.145:8443 -username admin -password password addEnvironmentBaseResource -application UserMgmtApp -environment UserDBAppDev  -resource  "/UserMgmtGrpA" >> $LOG_FILE

/root/udclient/udclient -weburl https://13.78.48.145:8443 -username admin -password password createResource  /home/azureuser/ucd_json/map_component_withagent2.json >> $LOG_FILE


/root/udclient/udclient -username admin -password password -weburl https://13.78.48.145:8443 requestApplicationProcess /home/azureuser/ucd_json/run_application_process.json >> $LOG_FILE
