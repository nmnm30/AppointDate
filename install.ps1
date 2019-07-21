# モジュール名
$ModuleName = "AppointDate"

# モジュール Path
$ModulePath = Join-Path (Split-Path $PROFILE -Parent) "Modules"

# モジュールを配置する Path
$NewPath = Join-Path $ModulePath $ModuleName

# ディレクトリ作成
md $NewPath

# モジュールのコピー
$ModuleFileName = Join-Path ".\" ($ModuleName + ".psm1")

copy $ModuleFileName $NewPath
