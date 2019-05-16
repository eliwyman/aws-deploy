#!/bin/bash

#install Amazon Web Services Command Line Interface
apt update
apt install awscli -y

# pull down initialization files from s3 bucket
aws s3 cp s3://eliwyman-test/ /home/ubuntu/ --region us-east-2 --recursive

# grant owner (root) execute permissions
chmod o+x /home/ubuntu/init.sh

# run install scripts
/home/ubuntu/init.sh
