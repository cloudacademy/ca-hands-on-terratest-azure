#!/bin/bash
cd /cloudacademy
git clone https://github.com/cloudacademy/ca-hands-on-terratest-azure
cp -r ./ca-hands-on-terratest-azure/testlab/* /cloudacademy/lab
chmod -R 777 /cloudacademy

# Replace Resource Group Name
find "/cloudacademy" -name "*.tf" | xargs sed -i "s/REPLACEME/$1/g"
