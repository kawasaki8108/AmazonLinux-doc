#!/usr/bin/bash

# ユーザーにインスタンス名を入力させる
read -p "InstanceIdを入力してください: " InstanceId


echo "instanceを開始します"
aws ec2 stop-instances --instance-ids $InstanceId
