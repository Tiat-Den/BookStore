$loginBody = @{ email = "admin@bookstore.com"; password = "Admin@123" } | ConvertTo-Json
$loginRes = Invoke-RestMethod -Uri "http://localhost:5193/api/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginRes.data.token

$headers = @{ 
    "Authorization" = "Bearer $token"
}

$settingsObj = @{
    isEnabled = $true
    welcomeMessage = "Xin chào bạn! 👋 Mình là trợ lý AI của BookStore. Mình có thể giúp bạn tìm sách, gợi ý sách bán chạy hoặc giải đáp chính sách cửa hàng nhé!"
    systemNotice = ""
}

$json = $settingsObj | ConvertTo-Json
$bytes = [System.Text.Encoding]::UTF8.GetBytes($json)

$response = Invoke-RestMethod -Uri "http://localhost:5193/api/chat/admin/settings" -Method Put -Headers $headers -Body $bytes -ContentType "application/json; charset=utf-8"
Write-Host "Updated ChatSettings successfully:" ($response | ConvertTo-Json -Depth 3)
