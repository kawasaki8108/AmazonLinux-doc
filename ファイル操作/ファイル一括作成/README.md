### 現在から60日前までの日付・タイムスタンプのファイルを作成する場合
awk使うかどうか、でそれぞれ本処理部分抜粋すると以下の通りです。詳細は各ファイル参照。
* awk使わない：[makefile.sh](makefile.sh)
  ```bash
  for i in {0..60}
  do
  	day="$(date -d "${i} day ago" "+%Y%m%d")"
  	touch -d "${day}" "${output_file}${day}.txt"
  done
  ```
* awk使う：[makefile_awk.sh](makefile_awk.sh)
  ```bash
  awk 'BEGIN{for(i=60;i>=0;i--) print i}' | xargs -I @ date -d "@ day ago" "+%Y%m%d" | xargs -I @ touch -d "@" "${output_file}@.txt"
  ```
  * `awk 'BEGIN{for(i=60;i>=0;i--) print i}'`：60から0以上までの範囲でマイナス1ずつ減らした数値を標準出力
  * `xargs -I @ date -d "@ day ago" "+%Y%m%d"`：標準出力値を@に入れて受け取り、dateでの標準出力（YYYYMMDD形式にしておく）
  * `xargs -I @ touch -d "@" "${output_file}@.txt"`：上の標準出力値を@に入れて受け取り、その@値のままの更新日、かつファイル名として出力
<br>
以上