#!/bin/bash

# use same credentials for git as for gitlab user
ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
TARGETFOLDER=~/Devel
GITLAB_USER=root
GITLAB_PW=12345678
#GITLAB_URL=$ip:10080
GITLAB_URL=gitlab

_TOKEN="curl -s http://$ip:10080/api/v3/session --data 'login=$GITLAB_USER&password=$GITLAB_PW' | jq '.private_token'"
TOKEN=$(eval $_TOKEN | tr -d '"')

docker run -it -e GITLAB_API_ENDPOINT=http://$GITLAB_URL/api/v4 \
               -e GITLAB_API_PRIVATE_TOKEN=$TOKEN \
               --net puppet_default \
               test/gitlabcli gitlab users --json

#git config --global user.name "Administrator"
#git config --global user.email "admin@example.com"

createProjectAndCommitToGitLab(){
	local projectName=$1
	local targetPath=$TARGETFOLDER/$projectName
	echo "=== $targetPath ==="

	rm -fr $targetPath

	echo "--- Cloning..."
	git clone http://$GITLAB_USER:$GITLAB_PW@$GITLAB_URL/root/$projectName.git $targetPath
	#git config user.name $GITLAB_USER #don't use --global!
	git config credential.helper cache #caches password for 15 min

	echo "--- Copying..."
	cp -r $projectName $TARGETFOLDER
	rm -fr $targetPath/target
	rm -fr $targetPath/.settings
	rm -fr $targetPath/.classpath
	rm -fr $targetPath/.project

	echo "--- Committing..."
	local currentPath=`pwd`;
	cd $targetPath
	git checkout -b production
	git add .
	git commit -a -m "inital commit"
	git push -u origin production
	cd $currentPath
}

#createProjectAndCommitToGitLab code
