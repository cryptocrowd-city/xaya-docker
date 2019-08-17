#!/bin/bash
docker rm gambit;
docker run -d --name gambit \
           -v=/home/cymon/works/xaya/projects:/opt/projects \
           -v=/home/cymon/works/xaya/xaya-data:/var/xaya \
           -v=/home/cymon/works/xaya/docker/xaya.conf:/root/.xaya/xaya.conf \
           xaya

