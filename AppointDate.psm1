############################################################
# 指定日を曜日付きにする
############################################################
function Apo([string]$Date, [string]$time, [string]$ToTime){

    $PointDate = $Date
    $PointTime = $time
    $PointToTime = $ToTime

    # 時刻だけを指定している場合
    if($Date -eq [string]$null){
        # 日付が省略されていたら今日とする
        $PointDate = (Get-Date).ToString("yyyy/M/d ")
    }

    # 時刻がセットされていたら今日とする
    if($Date.Contains(":")){
        $PointDate = (Get-Date).ToString("yyyy/M/d ")
        $PointTime = $Date
        $PointToTime = $time
    }

    # 月日時刻(5/10 17:00) にするとエラーになる対策
    try{
        $DateTime = Get-Date $PointDate
    }
    catch{
        $NowMonth = ((Get-Date).Month).ToString()
        $NewDate = $NowMonth + "/" + $PointDate
        try{
            $DateTime = Get-Date $NewDate
        }
        catch{
            return "$Date $time $ToTime は日付として認識できません"
        }
    }

    $strDateTime = ($DateTime).ToString("yyyy/M/d ") + $PointTime

    try{
        $DateTime = Get-Date $strDateTime
    }
    catch{
        return "$Date $time $ToTime は日付として認識できません"
    }

    # 終了時間チェック
    if( $PointToTime -ne [string]$null){
        try{
            $ToDateTime = Get-Date $PointToTime
        }
        catch{
            return "$Date $time $ToTime は日付として認識できません"
        }
    }

    if( $PointTime -eq [string]$null ){
        $TergetDay = $DateTime.ToString("yyyy年M月d日(ddd)")
    }
    elseif( $PointToTime -eq [string]$null ){
        $TergetDay = $DateTime.ToString("yyyy年M月d日(ddd) H:mm ～")
    }
    else{
        $TergetDay = $DateTime.ToString("yyyy年M月d日(ddd) H:mm ～ ") + $ToDateTime.ToString("H:mm")
    }

    # クリップボードにコピー
    $TergetDay | Set-Clipboard

    return $TergetDay
}
