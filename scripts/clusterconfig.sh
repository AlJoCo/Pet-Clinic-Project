#!/bin/bash

aws configure set aws_access_key_id $ACCESS_KEY
aws configure set aws_secret_access_key $SECRET_ACCESS_KEY

cd kubernetes
eksctl create cluster -f eks-pcp.yaml
cd