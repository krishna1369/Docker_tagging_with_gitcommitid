#!/bin/bash
sudo docker rmi -f $(sudo docker images -q) ##this is not recommned step, i am deleting existing images to save space
sudo rm -r gold ## these steps are not recommened instead you can modify script as shown below
sudo mkdir gold
cd gold/
sudo git clone https://github.com/krishna1369/Docker_tagging_with_gitcommitid.git
cd Day9/Code
git_commit=$(sudo git rev-parse HEAD)
sudo docker build -t react-microk8s:$git_commit -f golddockerfile .
sudo docker tag react-microk8s:$git_commit krishna1369/react-microk8s:$git_commit
sudo docker push krishna1369/react-microk8s:$git_commit
aws s3 rm s3://gitcommittagbucket/new_value.txt
sudo touch new_value.txt
sudo chmod 777 new_value.txt
sudo echo $git_commit > new_value.txt
aws s3 cp new_value.txt s3://gitcommittagbucket/
sudo rm new_value.txt
