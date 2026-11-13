$token = (Invoke-RestMethod -Uri "http://localhost:5193/api/auth/login" -Method Post -Body (@{ email = "admin@bookstore.com"; password = "Admin@123" } | ConvertTo-Json) -ContentType "application/json").data.token
$headers = @{ "Authorization" = "Bearer $token" }

$res = Invoke-RestMethod -Uri "http://localhost:5193/api/chat/admin/conversations" -Method Get -Headers $headers
Write-Host "Total conversations:" $res.data.Count

if ($res.data.Count -gt 0) {
    $res.data | Select-Object -First 5 -Property userName, userEmail, title, messageCount, updatedAt | Format-Table -AutoSize
    
    $firstId = $res.data[0].id
    $detail = Invoke-RestMethod -Uri "http://localhost:5193/api/chat/admin/conversations/$firstId" -Method Get -Headers $headers
    Write-Host "Detail messages count for first conv:" $detail.data.messages.Count
}
