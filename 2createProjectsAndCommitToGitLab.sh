#! /bin/bash

# use same credentials for git as for gitlab user

echo "precondition: create project 'hello-world-app' in gitlab"
echo "The default user is 'root' and the pw is shown above"

ip="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
TARGETFOLDER=~/Devel
GITLAB_USER=root
GITLAB_PW=12345678
GITLAB_URL=$ip:10080

_TOKEN="curl http://$ip:10080/api/v3/session --data 'login=$GITLAB_USER&password=$GITLAB_PW' | jq '.private_token'"
TOKEN=$(eval $_TOKEN)

docker run -it veden/gitlab-cli --help

git config --global user.name "Administrator"
git config --global user.email "admin@example.com"

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

createProjectAndCommitToGitLab code
