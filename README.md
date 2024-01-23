# Linux-doc
Linuxに関するメモ（コマンドなど）

## ShellScript
### シェル実行準備
* bashのインタプリタを確認（シェルの実体）
  * 先頭文字(種別)が`l`ならリンクであり、`/bin -> usr/bin`となっていれば`/bin`がソフトリンクなので、スクリプト内の冒用で`#!/bin/bash`で書いてok（たいていこっち）
  * no→）スクリプト内の冒用で`#!/usr/bin/bash`を書くこと
  ```bash
  $ which bash #実体位置確認
  /usr/bin/bash
  $ ll /bin #シンボリックリンク（ソフトリンク）ないか確認
  lrwxrwxrwx 1 root root 7 Dec 19 02:35 /bin -> usr/bin
  ```

* shファイル作成と実行準備
  ```bash
  $ vim hoge.sh #VScodeなどあればディタ画面でok
  $ i #挿入モード
  #!/bin/bash
  #……………いろいろ書く
  $ 「Esc」キー押す #コマンドモード
  $ wq #上書き保存してvim抜ける
  $ chmod 755 hoge.sh #少なくとも実行権限はつけるという意図
  ```

### フォルダ/ファイルパスの記述
#### 背景
ファイル操作などしたいとき、対象ファイルの絶対パスや自shファイルからの相対パスを単に記述しただけでは問題が起こります。
* 相対パス：今いる場所(`pwd`)が自shファイルがある場所ではない場合、エラーになる。相対パスの起点は**スクリプトを実行したユーザーのいるディレクトリ**になるため
* 絶対パス：shファイル格納フォルダの親以上のフォルダ名が変更されたときに対応できない。ただし、親を介した別のフォルダ名を変えられたら終わり（下図のdataフォルダをsourceに変えられるとか）

```
親フォルダ
├programs
|  └─program.sh
└data
   └─name.csv
```

#### サンプル
```bash
#!/bin/bash
#################
#ファイル/ディレクトリパスの定義
#################
#当該shファイルの絶対パスを取得
file_path="$(realpath ${0})" #絶対パス
base_dir="$(dirname ${file_path})" #そのファイルパスの所属ディレクトリパス

#input/outputのパス定義
input_dir="${base_dir}/data"
input_file="${input_dir}/input.csv"
output_dir="${base_dir}/output"
output_date="$(date "+%Y%m%d")"
output_file="${output_dir}/outputfile_${output_date}.txt"
#出力ファイル名にどのsh由来のファイルか入れたいとき
##当該ファイルのファイル名を取得
###`rev`は文字列をひっくり返すコマンド→ファイル名部分が先頭にくるので
###`/`で区切って1番目の要素(逆さのファイル名)を取得しまた`rev`で戻すとファイル名だけ拾える
sh_fname="$(echo ${file_path} | rev | cut -d '/' -f1 | rev)"
output_file="${output_dir}/(${sh_fname})OUT_${output_date}.txt"
or
output_file="${output_dir}/(${0})OUT_${output_date}.txt"
###↑なお、実行ファイル名の取得を${0}でやる場合は、ファイル名は「./test.sh」のように「./」がついてしまうので注意
```
