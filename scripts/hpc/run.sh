#!/bin/env python
#
# Wrapper script to run named command
#
# For historical reasons this is .sh but is now a python script

import os
import sys
import logging
from pathlib import Path

LOG = logging.getLogger("XNAT_HPC")
LOG_LEVEL = logging.INFO
HPC_COMMAND_DIR = "hpc-commands"

# Send the log to an output logfile
logging.basicConfig(filename="xnat_hpc.log", filemode="a", level=LOG_LEVEL)

# Also to stdout
extra_handler = logging.StreamHandler(sys.stdout)
extra_handler.setFormatter(logging.Formatter('%(levelname)s : %(message)s'))
LOG.addHandler(extra_handler)

if len(sys.argv) != 8:
    LOG.error("Called with incorrect number of arguments: %i (%s)", len(sys.argv), sys.argv)
    sys.exit(1)

cmd, host, jsessionid, proj, subj, exp, args = sys.argv[1:]
impl_cmd = Path(HPC_COMMAND_DIR, cmd, "run.slurm").resolve()
if not Path(HPC_COMMAND_DIR).resolve() in impl_cmd.parents:
    LOG.error("Command: %s not in correct XNAT commands folder", cmd)
elif not os.path.isfile(cmd):
    LOG.error("No such command: %s", cmd)
else:
    os.environ["CURL_CA_BUNDLE"] = ""
    fullcmd = os.path.join(HPC_COMMAND_DIR, "generic", "run") + f' "{cmd}" "{host}" "{jsessionid}" "{proj}" "{subj}" "{exp}" {args}'
    LOG.info(fullcmd)
    retval = os.system(fullcmd)
    if retval != 0:
        LOG.error("Exit status: %i: %s", retval, fullcmd)
