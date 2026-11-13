$models = @("gemini-3.1-flash-lite", "gemini-flash-latest", "gemini-3.8-flash")
$apiKey = "AIzaSyD5r5sajnWEz2R8nXX15GHKstuo-DQF_Ho"

foreach ($m in $models) {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    try {
        $body = @{ contents = @(@{ role = "user"; parts = @(@{ text = "Hi" }) }) } | ConvertTo-Json -Depth 5
        $res = Invoke-RestMethod -Uri "https://generativelanguage.googleapis.com/v1beta/models/${m}:generateContent?key=${apiKey}" -Method Post -Body $body -ContentType "application/json" -TimeoutSec 15
        $sw.Stop()
        Write-Host "Model $m : OK in $($sw.ElapsedMilliseconds)ms" -ForegroundColor Green
    } catch {
        $sw.Stop()
        Write-Host "Model $m : FAILED ($($_.Exception.Message)) in $($sw.ElapsedMilliseconds)ms" -ForegroundColor Red
    }
}
