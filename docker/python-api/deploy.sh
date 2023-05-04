#!/bin/bash

if [ $# -eq 0 ]; then
   echo "No arguments supplied"
   echo "Usage:<script name> region repo tag"
   exit 1
fi

declare -r Region=$1
declare -r Repo=$2
declare -r Tag="${3:-latest}"

out=$(aws ecr describe-repositories --repository-names "${Repo}" 2>/dev/null)
Status=$?
if [ $Status -gt 0 ]; then
   echo $'\n'
   echo "The repository with name ${Repo} does not exist in the registry with id '496253059293')"
   exit 1
else
   RepoURI=$(echo "${out}" | jq -r '.repositories[0].repositoryUri')
   echo $'\n'
   echo "${RepoURI}"
fi

Registry=$(echo "${RepoURI}" | sed "s/\/$Repo//")
echo $'\n'
echo "${Registry}"

aws ecr get-login-password --region "${Region}" | docker login --username AWS --password-stdin "${Registry}"
Status=$?
if [ $Status -gt 0 ]; then
   echo $'\n'
   echo "ecr login failed"
   exit 1;
fi
echo $'\n'

docker build -t "${Repo}:${Tag}" . 
Status=$?
if [ $Status -gt 0 ]; then
   echo $'\n'
   echo "Build failed for ${Repo}"
   exit 1;
fi
echo $'\n'

docker tag "${Repo}:${Tag}" "${RepoURI}:${Tag}"
echo $'\n'

docker push "${RepoURI}:${Tag}"
Status=$?
if [ $Status -gt 0 ]; then
   echo $'\n'
   echo "Image push failed for ${Repo}"
   exit 1;
else
   echo $'\n'
   echo "Image has been successfully uploaded to ${Repo}"
fi

echo $'\n'
echo "The latest 4 image versions are :" 
aws ecr describe-images --output json --repository-name "${Repo}" --query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[0]' | jq . --raw-output | tail -n 5
exit 0;