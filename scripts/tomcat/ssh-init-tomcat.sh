#!/bin/sh
#
# This script must be run whenever the server is restarted.
# It starts the ssh-agent as the tomcat user, writes the
# environment configuration to a file so that other scripts
# can read it, and adds the HPC authentication key to 
# ssh-agent.
#
# It will prompt for the passphrase of the authentication key

XNAT_SSH_KEY=/data/xnat/ssh/id_rsa_hpc
XNAT_SSH_AGENT_ENVFILE=/data/xnat/ssh/ssh-agent-tomcat-env

ssh-agent >${XNAT_SSH_AGENT_ENVFILE}
. ${XNAT_SSH_AGENT_ENVFILE}
ssh-add $XNAT_SSH_KEY

