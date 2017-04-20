#! /bin/bash

# use same credentials for git as for gitlab user

echo "precondition: create project 'hello-world-app' in gitlab"
echo "The default user is 'root' and the pw is shown above"

TARGETFOLDER=~/puppet
GITLAB_USER=root
GITLAB_PW=12345678
GITLAB_ADDR=gitlab

git config --global user.name "Administrator"
git config --global user.email "admin@example.com"

createProjectAndCommitToGitLab(){
	local projectName=$1
	local targetPath=$TARGETFOLDER/$projectName
	echo "=== $targetPath ==="

	rm -fr $targetPath

	echo "--- Cloning..."
	git clone http://$GITLAB_USER:$GITLAB_PW@$GITLAB_ADDR/root/$projectName.git $targetPath
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
	git add .
	git commit -a -m "inital commit"
	git push -u origin production
	cd $currentPath
}

createProjectAndCommitToGitLab code
