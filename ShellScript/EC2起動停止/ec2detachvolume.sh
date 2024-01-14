#!/usr/bin/bash

# ユーザーにインスタンス名を入力させる
read -p "VolumeIdを入力してください: " VolumeId


echo "ブロックデバイスボリュームをデタッチします"
aws ec2 detach-volume --volume-id $VolumeId
