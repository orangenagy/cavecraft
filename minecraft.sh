#!/bin/bash

cd /opt/minecraft
/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar --nogui >> minecraft.log 2>&1
