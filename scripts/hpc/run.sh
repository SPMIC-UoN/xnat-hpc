#Wrapper script to run named command
#
# This is very simple at present but we keep it so we
# have a level of indirection that can be used in the
# future for better error handling etc and which doesn't
# require changes on the XNAT instance
HPC_COMMAND_DIR=$HOME/xnat-hpc/scripts/hpc/hpc-commands

CMD=$1
HOST=$2
JSESSION=$3
PROJ=$4
SUBJ=$5
EXP=$6
ARGS=$7
CURL_CA_BUNDLE="" ${HPC_COMMAND_DIR}/${CMD}/run "$HOST" "$JSESSION" "$PROJ" "$SUBJ" "$EXP" $ARGS

