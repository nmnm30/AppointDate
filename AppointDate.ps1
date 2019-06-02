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
