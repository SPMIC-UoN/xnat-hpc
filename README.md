This repository contains code that supports the interaction of XNAT
with the HPC via the pipeline functionality.

The methodology is:
 - Define pipeline that runs a command, passing it the URL of the XNAT host
   the login jsession ID, project, subject and experiment, and the name of a command 
   to run on the HPC (with optional additional arguments)
 - This command logs into the HPC via ssh and executes the command with the
   XNAT arguments.
 - Passwordless key-based SSH login is required for this to work. There is a script to start
   ssh-agent as the XNAT server user (tomcat), add the login key and write the agent PID/socket
   information to a text file which is then sourced by the pipeline command to 
   enable it to log in to the HPC via SSH without interaction
 - This assumes that root on the XNAT server can be trusted otherwise arbitrary code
   execution on the HPC is trivial. Note however that an XNAT user cannot run arbitrary
   code, but only those commands exposed to the pipeline.
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
