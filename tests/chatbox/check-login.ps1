$passwords = @("Admin@123456", "Admin@123", "Password@123", "admin123")
foreach ($p in $passwords) {
    try {
        $body = @{ email = "admin@bookstore.com"; password = $p } | ConvertTo-Json
        $res = Invoke-RestMethod -Uri "http://localhost:5193/api/auth/login" -Method Post -Body $body -ContentType "application/json"
        Write-Host "SUCCESS with password: $p! Token received." -ForegroundColor Green
        break
    } catch {
        Write-Host "Failed with ${p}: $($_.ErrorDetails.Message)" -ForegroundColor Yellow
    }
}
