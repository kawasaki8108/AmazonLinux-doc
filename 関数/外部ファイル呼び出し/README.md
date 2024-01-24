
* 引数（数値）の合計値と平均値を算出する関数をそれぞれ1つのライブラリとして、以下の1つのshファイルで定義
[caluculation.sh](libraries/caluculation.sh)
* [call_libraries.sh](call_libraries.sh)内で上記の関数を呼び出して、実行する

### 構成
```bash
\---外部ファイル呼び出し
    |   call_libraries.sh
    |
    \---libraries
            caluculation.sh
```

### 実行結果
```bash
$ ./call_libraries.sh 1 2 3 5 7
合計値：18
平均値：3
```