#!/bin/bash
#################
#ファイル/ディレクトリパスの定義
#################
#当該shファイルの絶対パスを取得
file_path="$(realpath ${0})" #絶対パス
base_dir="$(dirname ${file_path})" #そのファイルパスのディレクトリパス

#outputディレクトリのパス定義
output_dir="${base_dir}/output_2"
output_date="$(date "+%Y%m%d")"
output_file="${output_dir}/tempfile_"

#################
#本処理（awk、xargs使う）
#################
#現在から60日前までの日付・タイムスタンプのファイルを作成する場合
awk 'BEGIN{for(i=60;i>=0;i--) print i}' | xargs -I @ date -d "@ day ago" "+%Y%m%d" | xargs -I @ touch -d "@" "${output_file}@.txt"