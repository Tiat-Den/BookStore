$token = (Invoke-RestMethod -Uri "http://localhost:5193/api/auth/login" -Method Post -Body (@{ email = "customer1@gmail.com"; password = "Password@123" } | ConvertTo-Json) -ContentType "application/json").data.token
$headers = @{ "Authorization" = "Bearer $token" }

$res = Invoke-RestMethod -Uri "http://localhost:5193/api/chat/messages" -Method Post -Headers $headers -Body (@{ message = "Sách bán chạy nhất" } | ConvertTo-Json) -ContentType "application/json; charset=utf-8"

Write-Host "Response text:" $res.data.text
Write-Host "Books count:" $res.data.books.Count
if ($res.data.books) {
    $res.data.books | Format-Table -Property id, title, price -AutoSize
}
