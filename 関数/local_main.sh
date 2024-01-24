#!/bin/bash

my_function(){
	echo "${name}"		#この段階では外部の変数として実行される
	local name="jiro"	#この段階からnameはこの関数内での変数として扱われる
	name="saburo"
	echo "${name}"		
	local age=18
}

main(){
	echo "第一引数は${1}です"
	name="taro"

	my_function
	#関数内の記述で一度localと宣言したあとでのnameなのでlocal扱いとなっている。
	#そのため、my_functionでの関数実行ではsaburoであるが、その後のechpではtaroのまま（外部には影響しない）

	echo "関数実行後：${name}"
	echo "年齢：${age}"

}

#全域数と一緒に実行する
main "${@}"

#===実行結果===#
# 第一引数はHelloです
# taro
# saburo
# 関数実行後：taro
# 年齢：
#=============#
