# XNAT-HPC integration

This repository contains code that supports the interaction of XNAT
with the HPC via the pipeline functionality.

## Methodology

 - Define pipeline that runs a script, passing it the URL of the XNAT host
   the login jsession ID, project, subject and experiment, and the name of a command 
   to run on the HPC (with optional additional arguments)

 - This script logs into the HPC via ssh and passes the arguments to a wrapper command on the
   HPC which is responsible for executing the matching command (if found)

 - Passwordless key-based SSH login is required for this to work. There is a script to start
   ssh-agent as the XNAT server user (tomcat), add the login key and write the agent PID/socket
   information to a text file which is then sourced by the pipeline command to 
   enable it to log in to the HPC via SSH without interaction

 - This assumes that root on the XNAT server can be trusted, otherwise arbitrary code
   execution on the HPC is trivial. Note however that an XNAT *user* cannot run arbitrary
   code on the HPC, but only those commands exposed to the pipeline.

 - Typically the HPC command will first use the jsession ID to obtain a user alias
   token for subsequent authentication to XNAT. This is required because the jsession
   ID is only valid during execution of the command so if a pipeline is being run on
   a queue, it will not be valid after the job completes.

 - Once an alias token has been obtained, the HPC command will typically download the
   session data from XNAT and submit jobs to perform the processing.

 - When the jobs complete, the HPC script will use the alias token as authentication
   to upload the data back to XNAT
 
 - HPC scripts will need to clean up after themselves, to ensure temporary data does not
   build up!

## Installation

This is rather manual at present.

XNAT documentation indicates that the pipeline engine needs to be rebuilt for every new pipeline
definition, but tests suggest this is not the case.

### SSH setup

A suitable location (e.g. `/data/xnat/ssh` or `/home/xnat/.ssh`) for installation of SSH keys should be
created, only readable by the tomcat user.

Into this folder the public/private SSH key pair `id_rsa` and `id_rsa.pub` should be copied. Of course these
are specific to the actual deployment. Generally the private key will be encrypted. The private key must have 
`600` permissions.

### Installing the helper scripts

A suitable location (e.g. `/data/xnat/bin` or `/home/xnat/bin`) for installation of binary scripts
must be created, readable by the Tomcat user. Into this folder must be copied the scripts in `scripts/tomcat`.

Edit the scripts to ensure that the paths to the SSH key and the chosen binary directory are correct.

The file `pipeline/resources/run_hpc_ssh.xml` should then be edited and the line:

    <pip:location>/home/xnat/bin</pip:location>

modified to contain the binary directory created above.

### Installing the pipeline descriptor

The file `pipeline/run_hpc.xml` needs to be copied to a subfolder of the XNAT pipeline folder, namely
`{XNAT_PIPELINE_DIR}/catalog/spmic/`

The folder `pipeline/resources` and the modified `pipeline/resources/run_hpc_ssh.xml` needs to be copied to the same destination.

From within XNAT, the pipeline can then be enabled by selecting `Administer->Pipelines` and then `Add Pipeline to Repository`.
The full path to the file `run_hpc.xml` should be entered. Be careful not to include any spaces before or
after - XNAT has bugs in this area!

### Starting the SSH agent

To start the SSH agent to allow passwordless login use:

    sudo -u tomcat /home/xnat/bin/ssh-init-tomcat.sh
    
This will prompt for the key passphrase (if any).

