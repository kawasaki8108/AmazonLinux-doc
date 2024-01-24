#!/bin/bash



#合計値を計算
function caluculation::sum(){	#ライブラリとしての扱いとわかりやすいように「::」を使う
	local retval=0				#return valueの略
	for val in "${@}"			#全引数尽きるまでループ（●●.sh 1 2 3 5 7なら、shより後ろの半角スペース区切り数値が引数）
	do
		(( retval+= "${val}" ))	#0+1→1+2→3+3→6+5→11+7ということ（数値計算は((  ))でくくる！）
	done
	echo "合計値：${retval}"
}

function caluculation::avg(){
    local retval=0
	local count=0
	for val in "${@}"
	do
		(( retval+= "${val}" ))
		(( count++ ))			#1(ループ)ずつ加算していく→この場合5回分なので5になる
	done
	retval=$(( ${retval} / ${count}  ))
	echo "平均値：${retval}"
}

