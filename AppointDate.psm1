############################################################
# 指定日を曜日付きにする
############################################################
function Apo([string]$Date, [string]$time, [string]$ToTime){

    $PointDate = $Date
    $PointTime = $time
    $PointToTime = $ToTime

    # 引数が無い
    if($Date -eq [string]$null){
        # 日付が省略されていので今日とする
        $PointDate = (Get-Date).ToString("yyyy/M/d ")
    }

	# 日付がセットされている
	if($Date.Contains("/")){
		$PointDate = $Date
        $PointTime = $time
        $PointToTime = $ToTime
    }

    # 時刻がセットされていたら今日とする
    elseif($Date.Contains(":") -or ($Date.Length -gt 2)){
        $PointDate = (Get-Date).ToString("yyyy/M/d ")
        $PointTime = $Date
        $PointToTime = $time
    }

    # 時刻の ":" が省略されている場合
    # From Time
    if( $PointTime -ne $null ){
        if( -not $PointTime.Contains(":") ){
            if( $PointTime.Length -eq 4 ){
                $PointTime = $PointTime.Substring(0, 2) + ":" + $PointTime.Substring(2, 2)
            }
            elseif( $PointTime.Length -eq 3 ){
                $PointTime = $PointTime.Substring(0, 1) + ":" + $PointTime.Substring(1, 2)
            }
        }
    }

    # To Time
    if( $PointToTime -ne $null ){
        if( -not $PointToTime.Contains(":") ){
            if( $PointToTime.Length -eq 4 ){
                $PointToTime = $PointToTime.Substring(0, 2) + ":" + $PointToTime.Substring(2, 2)
            }
            elseif( $PointToTime.Length -eq 3 ){
                $PointToTime = $PointToTime.Substring(0, 1) + ":" + $PointToTime.Substring(1, 2)
            }
        }
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
        $TergetDay = $DateTime.ToString("yyyy年MM月dd日(ddd)")
    }
    elseif( $PointToTime -eq [string]$null ){
        $TergetDay = $DateTime.ToString("yyyy年MM月dd日(ddd) HH:mm ～")
    }
    else{
        $TergetDay = $DateTime.ToString("yyyy年MM月dd日(ddd) HH:mm ～ ") + $ToDateTime.ToString("HH:mm")
    }

    # クリップボードにコピー
    $TergetDay | Set-Clipboard

    return $TergetDay
}

################################################
# 現在時刻をクリップボードにセットする
################################################
function now(){
    $NowDateTime = (Get-Date).ToString("yyyy年MM月dd日(ddd) HH:mm")
    echo $NowDateTime
    $NowDateTime | Set-Clipboard
}

