#!/bin/bash

PUBLIC_IP=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
DOMAIN_NAME="minecraft.cavecraft.co.uk"
ZONE_ID="Z08895941Q4F1JYONJGY6"
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

/usr/local/bin/aws route53 change-resource-record-sets --hosted-zone-id Z08895941Q4F1JYONJGY6 --change-batch file://$CHANGEFILE
