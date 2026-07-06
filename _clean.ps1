$targets = @(
    @{Path='C:\Users\ASUS\AppData\Local\NetEase\CloudMusic\Cache'; Name='NetEase cache'},
    @{Path='C:\Users\ASUS\AppData\Local\Temp'; Name='Temp'},
    @{Path='C:\Users\ASUS\AppData\Local\npm-cache'; Name='npm cache'},
    @{Path='C:\Users\ASUS\AppData\Local\JianyingPro\User Data\Cache'; Name='JianyingPro'},
    @{Path='C:\Users\ASUS\.cache'; Name='.cache'},
    @{Path='C:\Users\ASUS\AppData\Local\ms-playwright'; Name='ms-playwright'},
    @{Path='C:\Users\ASUS\AppData\Roaming\Tencent\xwechat\radium'; Name='WeChat radium'},
    @{Path='C:\Users\ASUS\AppData\Roaming\Tencent\xwechat\log'; Name='WeChat log'},
    @{Path='C:\Users\ASUS\AppData\Roaming\kingsoft\wps\download'; Name='WPS download'},
    @{Path='C:\Users\ASUS\AppData\Local\Google\Chrome\User Data\Default\Cache'; Name='Chrome Cache'},
    @{Path='C:\Users\ASUS\AppData\Local\Google\Chrome\User Data\Default\Code Cache'; Name='Chrome CodeCache'}
)

$totalFreed = 0
Write-Host "=== Scanning & Cleaning C Drive ==="
Write-Host ""

foreach ($t in $targets) {
    $size = 0
    if (Test-Path $t.Path) {
        try { $size = (Get-ChildItem $t.Path -Recurse -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer } | Measure-Object Length -Sum).Sum } catch {}
    }
    $mb = [math]::Round($size/1MB, 1)
    Write-Host ("$mb MB  ->  $($t.Name)")

    if ($mb -gt 0.5) {
        Remove-Item "$($t.Path)\*" -Recurse -Force -ErrorAction SilentlyContinue 2>$null
        $totalFreed += $mb
    }
}

Write-Host ""
Write-Host "=== Total freed: $([math]::Round($totalFreed, 1)) MB ==="
Write-Host ""
Write-Host "=== Running npm cache clean ==="
npm cache clean --force 2>&1 | Select-Object -Last 2
