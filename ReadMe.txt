AppointDate

入力した日付を曜日付きの年月日に変換する PowerShell スクリプト

■ これは何?
入力した日時を曜日付きの年月日にしてクリップボードに送ります。

アポを取る時とかで曜日を間違って恥ずかしい思いをしなくて済みます。

Web サービスで同様のものがあったのですが、年がセットされないので PowerShell で書いてみました。

■ 使い方
・年月日を曜日付きにする
PowerShell プロンプトで「apo 日付」を入力します。
念を省略すると今年になります。

    PS C:\> apo 10/13
    2019年10月13日(日)

この状態で曜日付き日付がクリップボードにセットされているので、そのままペーストします。

・年月日 + 時間を曜日付きにする
PowerShell プロンプトで「apo 日付 時刻」を入力します

    PS C:\> apo 2020/5/18 13:00
    2020年5月18日(月) 13:00 ～

こちらもクリップボードにセットされているので、そのままペーストします。

■ セットの仕方
Profile に関数を追加します。

簡単に済ませるのであれば、以下を管理権限 PowerShell プロンプトにペースト(マウス右クリック)し、いったん PowerShell プロンプトを閉じます。
(スクリプト実行許可設定をするので管理権限を使います)

次に PowerShell プロンプト開くと apo コマンドが使えるようになっています。


■ セット用のコピペ元

#--------- ここから

# Profile に追加する関数
$HereString = @'
############################################################
# 指定日を曜日付きにする
############################################################
function Apo([string]$Date, [string]$time){
    $strDateTime = $Date + " " + $time
    try{
        $DateTime = Get-Date $strDateTime
    }
    catch{
        return  "$Date $time は日付として認識できません"
    }

    $YoubiTable = @{
        "Sunday"    = "(日)"
        "Monday"    = "(月)"
        "Tuesday"   = "(火)"
        "Wednesday" = "(水)"
        "Thursday"  = "(木)"
        "Friday"    = "(金)"
        "Saturday"  = "(土)"
    }

    $DayOfWeek = ($DateTime.DayOfWeek).ToString()
    $Youbi = $YoubiTable[$DayOfWeek]
    $Year = ($DateTime.Year).ToString()
    $Month = ($DateTime.Month).ToString()
    $Day =  ($DateTime.Day).ToString()
    $Hour = ($DateTime.Hour).ToString()
    $Minute = ($DateTime.Minute).ToString("00")

    if( $time -eq [string]$null){
        $TergetDay = $Year + "年" + $Month + "月" + $Day + "日" +$Youbi
    }
    else{
        $TergetDay = $Year + "年" + $Month + "月" + $Day + "日" +$Youbi +" " + $Hour + ":" + $Minute + " ～"
    }

    # S-JIS に変更
    $OutputEncoding = [Console]::OutputEncoding

    # クリップボードにコピー
    $TergetDay | clip

    # US-ASCII に戻す
    $OutputEncoding = New-Object System.Text.ASCIIEncoding

    return $TergetDay
}
'@

# ヒア文字列を文字列配列にする
$Temp = $HereString.Replace("`r","")
$StringArray = $Temp.Split("`n")

# スクリプトの実行許可
if((Get-ExecutionPolicy) -ne "RemoteSigned"){Set-ExecutionPolicy RemoteSigned -Force}

# プロファイルの有無確認
if( -not (Test-Path $PROFILE)){
    # フォルダが無かったら作る
    if( -not (Test-Path (Split-Path $PROFILE -Parent))){md (Split-Path $PROFILE -Parent)}
}

# プロファイルに関数追加
Add-Content -Value $StringArray -Path $PROFILE -Encoding UTF8

#--------- ここまで

■ 動作確認環境
PowerShell 5.1
PowerShell 6.1.1(Windows 10)

Windows 以外でも動くはずです。

■ Web サイト

入力した日付を曜日付きの年月日に変換する PowerShell スクリプト
http://www.vwnet.jp/Windows/PowerShell/2019021501/AppointDate.htm

■ リポジトリ
GitHub でも公開しているので、最新版が欲しい方はこちらから Clone してください。

https://github.com/MuraAtVwnet/AppointDate
git@github.com:MuraAtVwnet/AppointDate.git

