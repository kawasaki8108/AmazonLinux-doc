#!/usr/bin/bash

# ユーザーにデバイス名を入力させる
read -p "InctanceIdを入力してください（例:i-020539a26cbe1061f）: " InstanceId
read -p "VolumeIdを入力してください（例:vol-0df7d8233e03ef2c1）: " VolumeId

echo "ボリュームアタッチのコマンドです。デバイス名は直接書き換えてください"
echo "aws ec2 attach-volume --volume-id $VolumeId --instance-id $InstanceId --device <device>"
