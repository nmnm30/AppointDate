入力した日付を曜日付きの年月日に変換する PowerShell スクリプト

■ これは何?
入力した日時を曜日付きの年月日にしてクリップボードに送ります。

アポを取る時とかで曜日を間違って恥ずかしい思いをしなくて済みます。

Web サービスで同様のものがあったのですが、年がセットされないので PowerShell で書いてみました。

■ 使い方
・年月日を曜日付きにする
PowerShell プロンプトで「apo 日付」を入力します。
年を省略すると今年になります。

    PS C:\> apo 10/13
    2019年10月13日(日)

この状態で曜日付き日付がクリップボードにセットされているので、そのままペーストします。

・年月日 + 時間を曜日付きにする
PowerShell プロンプトで「apo 日付 時刻」を入力します

    PS C:\> apo 2020/5/18 13:00
    2020年5月18日(月) 13:00 ～

こちらもクリップボードにセットされているので、そのままペーストします。

■ セットの仕方
install.ps1 を実行してください

次に PowerShell プロンプト開くと apo コマンドが使えるようになっています。

■ Uninstall 方法
uninstall.ps1 を実行して下さい
(問い合わせが来たら Enter)

■ 動作確認環境
PowerShell 5.1
PowerShell 6.x 7.x では動きません。
Windows 環境専用です。

■ Web サイト

入力した日付を曜日付きの年月日に変換する PowerShell スクリプト
http://www.vwnet.jp/Windows/PowerShell/2019021501/AppointDate.htm

■ リポジトリ
GitHub でも公開しているので、最新版が欲しい方はこちらから Clone してください。

https://github.com/MuraAtVwnet/AppointDate
git@github.com:MuraAtVwnet/AppointDate.git

