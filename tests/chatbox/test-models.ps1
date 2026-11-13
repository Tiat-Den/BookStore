$models = @("gemini-3.1-flash-lite", "gemini-flash-latest", "gemini-3.8-flash")
# Lay API Key tu User Secrets hoac bien moi truong, khong hardcode vao source code
$secretsPath = "$env:APPDATA\Microsoft\UserSecrets\f4b849f5-27b5-40f1-b05c-ba65df6b581c\secrets.json"
$apiKey = $env:GEMINI_API_KEY
if (-not $apiKey -and (Test-Path $secretsPath)) {
    $secrets = Get-Content $secretsPath | ConvertFrom-Json
    $apiKey = $secrets."GeminiSettings:ApiKey"
}

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
