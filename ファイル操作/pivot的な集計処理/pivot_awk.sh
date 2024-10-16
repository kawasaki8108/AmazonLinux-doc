#!/bin/bash
#################
#ファイル/ディレクトリパスの定義
#################
#当該shファイルの絶対パスを取得
file_path="$(realpath ${0})" #絶対パス
base_dir="$(dirname ${file_path})" #そのファイルパスのディレクトリパス
#当該ファイルのファイル名を取得
##`rev`は文字列をひっくり返すコマンド→ファイル名部分が先頭にくるので
##`/`で区切って1番目の要素(逆さのファイル名)を取得しまた`rev`で戻すとファイル名だけ拾える
sh_fname="$(echo ${file_path} | rev | cut -d '/' -f1 | rev)"

#input/outputディレクトリ、inputファイルのパス定義
input_dir="${base_dir}/input"
output_dir="${base_dir}/output"
output_date="$(date "+%Y%m%d")"
input_file="${input_dir}/input.csv"
output_file="${output_dir}/(${sh_fname})output_${output_date}.csv"

#↓awkで計算定義
#################
#計算定義
#################
#タイトルのみ出力・書き込み
echo "合計" > "${output_file}"
#売上合計
awk -F "," '
{if($2=="売上") {sum+=$5}}
END{print "売上：" sum}
' "${input_file}" >> "${output_file}"
#費用合計
awk -F "," '
    {if($2=="費用") {sum+=$5}}
    END{print "費用：" sum}
' "${input_file}" >> "${output_file}"

#日付ごとの売上、費用
echo -e "\n日付ごとの合計" >> "${output_file}"
echo "日付、売上、費用" >> "${output_file}"

#`($2=="売上"){earnings[$1]+=$5}`：2列目が「売上」なら1列目をキーにして5列目を加算する
#`earnings[$1]`：awkではこの表記で連想配列として認識され、この場合「earinigs」が配列名となる
#└参考記事：https://it-ojisan.tokyo/awk-array-str-count/
awk -F "," '
    {if($2=="売上"){earnings[$1]+=$5} else if($2=="費用"){costs[$1]+=$5}}
    END{for(i in costs) {print i "," earnings[i] "," costs[i]}}
' "${input_file}" | sort -T "," -n -k1 >> "${output_file}"

#品目ごとの売上、費用
echo -e "\n品目ごとの合計" >> "${output_file}"
echo "品目、売上、費用" >> "${output_file}"

awk -F "," '
    {if($2=="売上"){earnings[$3]+=$5} else if($2=="費用"){costs[$3]+=$5}}
    END{for(i in costs) {print i "," earnings[i] "," costs[i]}}
' "${input_file}" | sort >> "${output_file}"
