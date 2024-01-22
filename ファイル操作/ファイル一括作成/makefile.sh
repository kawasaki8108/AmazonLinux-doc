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
#input_file="${input_dir}/input.csv"
output_file="${output_dir}/tempfile_"

#################
#本処理（awk使わないで）
#################
#現在から60日前までの日付・タイムスタンプのファイルを作成する場合
for i in {0..60}
do
	day="$(date -d "${i} day ago" "+%Y%m%d")"
	touch -d "${day}" "${output_file}${day}.txt"
done
