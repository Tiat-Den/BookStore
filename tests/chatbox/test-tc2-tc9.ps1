$token = (Invoke-RestMethod -Uri "http://localhost:5193/api/auth/login" -Method Post -Body (@{ email = "customer1@gmail.com"; password = "Password@123" } | ConvertTo-Json) -ContentType "application/json").data.token
$headers = @{ "Authorization" = "Bearer $token" }

# TC02 with "dac nhan tam"
$res1 = Invoke-RestMethod -Uri "http://localhost:5193/api/chat/messages" -Method Post -Headers $headers -Body (@{ message = "tim sach dac nhan tam" } | ConvertTo-Json) -ContentType "application/json; charset=utf-8"
Write-Host "TC02 text:" $res1.data.text
Write-Host "TC02 books count:" $res1.data.books.Count

# TC09
$res2 = Invoke-RestMethod -Uri "http://localhost:5193/api/chat/messages" -Method Post -Headers $headers -Body (@{ message = "Chinh sach doi tra sach cua shop nhu the nao?" } | ConvertTo-Json) -ContentType "application/json; charset=utf-8"
Write-Host "TC09 text:" $res2.data.text
