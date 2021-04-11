#!/bin/bash

PUBLIC_IP=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
DOMAIN_NAME="minecraft.cavecraft.co.uk"
ZONE_ID="YOUR_ZONE_ID"
CHANGEFILE=/opt/minecraft/minecraft-dns.json

echo "Public IP is $PUBLIC_IP"

cat <<EOF > $CHANGEFILE
{
            "Comment": "CREATE/DELETE/UPSERT a record ",
            "Changes": [{
            "Action": "UPSERT",
                        "ResourceRecordSet": {
                                    "Name": "$DOMAIN_NAME",
                                    "Type": "A",
                                    "TTL": 60,
                                 "ResourceRecords": [{ "Value": "$PUBLIC_IP"}]
}}]
}
EOF

/usr/local/bin/aws route53 change-resource-record-sets --hosted-zone-id ${ZONE_ID} --change-batch file://$CHANGEFILE
