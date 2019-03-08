############################################################
# 指定日を曜日付きにする
############################################################
function Apo([string]$Date, [string]$time){

    # 月日時刻(5/10 17:00) にするとエラーになる対策
    try{
        $DateTime = Get-Date $Date
    }
    catch{
        return  "$Date $time は日付として認識できません"
    }

    $strDateTime = ($DateTime.Year).ToString() `
                    + "/" `
                    + ($DateTime.Month).ToString() `
                    + "/" `
                    + ($DateTime.Day).ToString() `
                    + " " `
                    + $time

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
