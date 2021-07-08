#!/bin/bash
cd kubernetes
eksctl create cluster -f eks-pcp.yaml
cd