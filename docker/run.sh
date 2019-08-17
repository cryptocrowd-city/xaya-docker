#!/bin/bash
WORKDIR=$HOME/works/xaya
docker rm gambit;
docker run -d --name gambit \
           -v=$WORKDIR/projects:/opt/projects \
           -v=$WORKDIR/xaya-data:/var/xaya \
           -v=$WORKDIR/docker/xaya.conf:/root/.xaya/xaya.conf \
           xaya

