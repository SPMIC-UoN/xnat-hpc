#!/bin/bash

cp Dockerfile.in Dockerfile
python ../cmd2label.py ukat_cmd.json >> Dockerfile

tag=0.0.1
docker build -t martincraig/xnat-ukat .
docker tag martincraig/xnat-ukat martincraig/xnat-ukat:$tag 
docker push martincraig/xnat-ukat:$tag
