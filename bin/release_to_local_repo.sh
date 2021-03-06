#!/bin/bash


# Uploads the artifacts in ./dist (JAR and src JAR) to the local repo ($HOME/.ms/jboss-repository)
# so we can do local testing before uploading to the Nexus maven repo


# Author: Bela Ban


DIST=../dist
POM=../pom.xml

JAR=`find $DIST -name "jgroups-raft*.jar" | grep -v source`
SRC_JAR=`find $DIST -name "jgroups-raft*.jar" | grep source`

REPO=file:$HOME/.m2/jboss-repository
FLAGS="-Dpackaging=jar -DrepositoryId=jboss-releases-repository"


echo "Deploying $JAR to $REPO"
mvn deploy:deploy-file -Dfile=$JAR -Durl=$REPO -DpomFile=$POM $FLAGS


echo "Deploying $SRC_JAR to $REPO"
mvn deploy:deploy-file -Dfile=$SRC_JAR -Durl=$REPO -DpomFile=$POM -Dclassifier=sources $FLAGS

