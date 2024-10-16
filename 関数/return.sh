#!/bin/bash
#引数を足す
function sum(){
	retval=0
	for num in "${@}" #引数をループさせる
	do
		(( retval+="${num}" ))
	done
#	echo "${retval}"    #←こういうのを入れないこと！
	return "${retval}" #引数が数値の場合返り値をreturnで取得できる
}

#以下は別shからこのshを使ったときに実行しそうなこと
#本来呼び出される関数側でここまで書かない（あくまでイメージのため）
sum 1 2 3 4

value="${?}" #`${?}`は返り値取得の記述→sum 1 2 3 4のreturnの値を取得（10が得られるはず）
echo "返り値は${value}です"
