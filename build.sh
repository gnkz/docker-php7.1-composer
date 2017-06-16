#!/usr/bin/env bash

USERNAME=gnkz
REPONAME=php7.1-composer-alpine
BRANCHNAME=$(git symbolic-ref -q HEAD)
BRANCHNAME=${BRANCHNAME##refs/heads/}
BRANCHNAME=${BRANCHNAME:-INTAG}

if [ "$BRANCHNAME" == "INTAG" ]
then
        TAG=$(git describe --tags --abbrev=0)
else
        if [ "$BRANCHNAME" == "master" ]
        then
                TAG="latest"
        else
                TAG="dev"
        fi
fi

docker build -t $USERNAME/$REPONAME:$TAG --rm .
