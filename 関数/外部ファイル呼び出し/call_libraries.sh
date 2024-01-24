#!/bin/bash

#現在パスを取得（そとのものを読み込む系はお約束）
path=$(realpath ${0})
basedir=$(dirname ${path})

#もってきたい関数を定義
source $basedir/libraries/caluculation.sh

#上記shファイル内の関数を実行
#実行時は「./call_libraries.sh 1 2 3 5 7」みたいになるので、全引数を呼び出す関数へ渡したいので「"{@}"」を付けている
##合計値を計算
caluculation::sum "${@}"
##平均値を計算
caluculation::avg "${@}"
