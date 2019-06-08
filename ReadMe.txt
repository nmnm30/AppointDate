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
Profile に関数を追加します。

簡単に済ませるのであれば、以下を管理権限 PowerShell プロンプトにペースト(マウス右クリック)し、いったん PowerShell プロンプトを閉じます。
(スクリプト実行許可設定をするので管理権限を使います)

次に PowerShell プロンプト開くと apo コマンドが使えるようになっています。


■ セット用のコピペ元

#--------- ここから
$HereString = @'
############################################################
# 指定日を曜日付きにする
############################################################
function Apo([string]$Date, [string]$time, [string]$ToTime){

    # 月日時刻(5/10 17:00) にするとエラーになる対策
    try{
        $DateTime = Get-Date $Date
    }
    catch{
        return  "$Date $time $ToTime は日付として認識できません"
    }

    $strDateTime = ($DateTime).ToString("yyyy/M/d ") + $time

    try{
        $DateTime = Get-Date $strDateTime
    }
    catch{
        return  "$Date $time $ToTime は日付として認識できません"
    }

    # 終了時間チェック
    if( $ToTime -ne [string]$null){
        try{
            $ToDateTime = Get-Date $ToTime
        }
        catch{
            return  "$Date $time $ToTime は日付として認識できません"
        }
    }

    if( $time -eq [string]$null ){
        $TergetDay = $DateTime.ToString("yyyy年M月d日(ddd)")
    }
    elseif( $ToTime -eq [string]$null ){
        $TergetDay = $DateTime.ToString("yyyy年M月d日(ddd) H:mm ～")
    }
    else{
        $TergetDay = $DateTime.ToString("yyyy年M月d日(ddd) H:mm ～ ") + $ToDateTime.ToString("H:mm")
    }

    # クリップボードにコピー
    $TergetDay | Set-Clipboard

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
PowerShell 6.x 7.x では動きません。
Windows 環境専用です。

■ Web サイト

入力した日付を曜日付きの年月日に変換する PowerShell スクリプト
http://www.vwnet.jp/Windows/PowerShell/2019021501/AppointDate.htm

■ リポジトリ
GitHub でも公開しているので、最新版が欲しい方はこちらから Clone してください。

https://github.com/MuraAtVwnet/AppointDate
git@github.com:MuraAtVwnet/AppointDate.git

