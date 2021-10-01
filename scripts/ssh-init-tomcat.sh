#!/bin/sh
#
# This script must be run whenever the server is restarted.
# It starts the ssh-agent as the tomcat user, writes the
# environment configuration to a file so that other scripts
# can read it, and adds the HPC authentication key to 
# ssh-agent.
#
# It will prompt for the passphrase of the authentication key

XNAT_HOME=/home/xnat
XNAT_SSH_KEY=$XNAT_HOME/.ssh/id_rsa

ssh-agent >$XNAT_HOME/bin/ssh-agent-tomcat-env
. $XNAT_HOME/bin/ssh-agent-tomcat-env
ssh-add $XNAT_SSH_KEY


