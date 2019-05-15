#!/bin/bash

#install Amazon Web Services Command Line Interface
apt update
apt install awscli -y

# pull down initialization files from s3 bucket
aws s3 cp s3://eliwyman-test/init.sh /home/ubuntu/ --region us-east-2

# run install scripts
./init.sh
