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
input_file="${input_dir}/input.csv"


#################
#計算定義
#################
#==変数と初期値を設定==
total_cost=0 #費用合計
total_earning=0 #売上合計

#日付ごとの売上、費用
##それぞれ連想配列として定義（-Aオプション）
declare -A dialy_costs
declare -A dialy_earnings

#品目ごとの売上、費用
declare -A product_costs
declare -A product_earnings

#==売上、費用の合計==
while read p
do
	#列ごとの値を変数に格納
	day="$(echo ${p} | cut -d "," -f 1)"
	cost_or_earning="$(echo ${p} | cut -d "," -f 2)"
	product_name="$(echo ${p} | cut -d "," -f 3)"
	price="$(echo ${p} | cut -d "," -f 5)"

	#費用、売上それぞれの合計値を算出
	if [[ "${cost_or_earning}" == "費用" ]] ;then
		(( dialy_costs["${day}"]+="${price}"))
		(( product_costs["${product_name}"]+="${price}"))
		(( total_cost+="${price}" ))
	elif [[ "${cost_or_earning}" == "売上" ]] ;then
		(( dialy_earnings["${day}"]+="${price}"))
		(( product_earnings["${product_name}"]+="${price}"))
		(( total_earning+="${price}" ))
	fi
done < "${input_file}"
#outputファイルを作成
output_date="$(date "+%Y%m%d")"
output_file="${output_dir}/(${sh_fname})output_${output_date}.csv"
#outputファイルに値を書き込み
echo "合計" > "${output_file}"
echo "売上合計：${total_earning}" >> "${output_file}"
echo "費用合計：${total_cost}" >> "${output_file}"

echo -e "\n日付ごとの合計" >> "${output_file}"
echo "日付、売上、費用" >> "${output_file}"
# echo "${dialy_costs[@]}"←これだと連想配列の場合valueの方が出力されるので、!つけてkey情報を取得する
echo "${!dialy_costs[@]}" | sed 's/ /\n/g' | sort -n | while read key
do
	# echo "${key},${dialy_earnings[${key}]},${dialy_costs[${key}]}"
	echo "${key},${dialy_earnings[${key}]},${dialy_costs[${key}]}" >> "${output_file}"
done

echo -e "\n品目ごとの合計" >> "${output_file}"
echo "品目、売上、費用" >> "${output_file}"
# echo "${!product_costs[@]}"
# echo "${!product_earnings[@]}"

#`echo "${!product_costs[@]} ${!product_earnings[@]}"`：キーだけを標準出力する
#`| sed 's/ /\n/g'`：上の結果がスペース区切りの羅列なので、スペースを改行してリストみたいにする
#`| sort -n`：上の結果が日付なので、数値扱いして昇順で並べ替える
#`| uniq`：重複を削除する
#`| while read key`：上で綺麗にしたリストをkeyという変数に入れて最終行まで1行ずつ処理する
echo "${!product_costs[@]} ${!product_earnings[@]}" | sed 's/ /\n/g' | sort -n | uniq | while read key
do
	echo "${key},${product_earnings[${key}]},${product_costs[${key}]}" >> "${output_file}"
	#1行ずつ、品目(key),keyに応じた売上,keyに応じた費用の順に並べた状態で標準出力し、それをoutput_fileに1行ずつ書き込む
done