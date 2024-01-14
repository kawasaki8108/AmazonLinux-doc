#!/usr/bin/bash

echo "ブロックデバイスの情報取得"
aws ec2 describe-volumes

echo "インスタンスの情報取得"
aws ec2 describe-instances \
    --query 'Reservations[*].Instances[*].{InstanceId:InstanceId,  InstanceState:State.Name, PublicIPv4:PublicIpAddress, KeyName:KeyName, BlockDeviceMappings:BlockDeviceMappings, RootDeviceName:RootDeviceName
    , Tags:Tags}' \
    --output json

