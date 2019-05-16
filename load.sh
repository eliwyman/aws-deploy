#!/bin/bash
scp -r -i $CREDPATH/login.pem /home/el/Projects/AWS-POC/aws-deploy/init.sh $AWSUSR@$AWSHOST:/home/ubuntu/

scp -r -i $CREDPATH/login.pem /home/el/Projects/AWS-POC/aws-deploy/php/php.ini $AWSUSR@$AWSHOST:/home/ubuntu/

scp -r -i $CREDPATH/login.pem /home/el/Projects/AWS-POC/aws-deploy/nginx/default $AWSUSR@$AWSHOST:/home/ubuntu/

scp -r -i "$CREDPATH/login.pem" /home/el/Projects/AWS-POC/aws-deploy/php/index.php $AWSUSR@$AWSHOST:/home/ubuntu/
