#!/bin/bash
# Author: José M Beltrán Vargas
# Creation Date: 17/11/2021
# Last Review: 18/11/2021
# Objective:
#  - List all the Type A Registers in your Hosted Zones
#  - The results are saved in a separated JSON File


# Getting Hosted Zones
hostedzones="$(sudo aws route53 list-hosted-zones --query 'HostedZones[*].Id' --output text)"

echo "Obtained the next hostedzones: ${hostedzones}"

# Getting the Type A Registers by Zone and Saving Them:
#

for tmpHostedId in $hostedzones
do
 filteredHostId=${tmpHostedId/#\/hostedzone\/""}
 tmpFileName="listTypeARegisters_$filteredHostId.json"   
 echo "Getting Type A Registers for the Hosted Zone: ${tmpHostedId}"
 touch $tmpFileName
 sudo aws route53 list-resource-record-sets --hosted-zone-id $tmpHostedId  --query 'ResourceRecordSets[?Type==`A`]'.[Name,ResourceRecords[].Value] > $tmpFileName

done




