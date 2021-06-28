#!/bin/bash

echo ""
echo ""
echo "*****************************"
echo "*****   SWITCH TUNNEL   *****"
echo "**                         **"
echo "** Background: Ctrl-Z + bg **"
echo "*****************************"
echo ""
echo ""

# TUNNEL ONLY!!
#
ssh -NL 8484:10.42.0.100:80 gateway

# To connect to and forward it from the gateway:
#
# ssh -L 8080:localhost:8484 [user]@[server/domain]
