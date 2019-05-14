#!/bin/bash
scp -r -i "/Users/el/Google Drive/login.pem" /Users/el/aws-deploy/init.sh $AWSUSR@$AWSHOST:/home/ubuntu/

scp -r -i "/Users/el/Google Drive/login.pem" /Users/el/aws-deploy/php/php.ini $AWSUSR@$AWSHOST:/home/ubuntu/

scp -r -i "/Users/el/Google Drive/login.pem" /Users/el/aws-deploy/nginx/default $AWSUSR@$AWSHOST:/home/ubuntu/

scp -r -i "/Users/el/Google Drive/login.pem" /Users/el/aws-deploy/php/info.php $AWSUSR@$AWSHOST:/home/ubuntu/
