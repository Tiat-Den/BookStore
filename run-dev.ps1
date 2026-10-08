<#
.SYNOPSIS
    Script khoi chay dong thoi Backend va Frontend cho he thong BookStore
#>

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "               KHOI CHAY HE THONG BOOKSTORE E-COMMERCE                  " -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan

# 1. Start Backend in separate window
Write-Host "`n[1/2] Dang khoi dong Backend (.NET 8 Web API)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\Backend'; Write-Host '--- BookStore Backend API (Port 5193) ---' -ForegroundColor Green; dotnet run --project BookStore.Api --urls 'http://localhost:5193'"

# 2. Start Frontend in separate window
Write-Host "[2/2] Dang khoi dong Frontend (React Vite)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\Frontend'; Write-Host '--- BookStore Frontend (Port 5173) ---' -ForegroundColor Cyan; npm run dev"

Write-Host "`n========================================================================" -ForegroundColor Green
Write-Host "He thong da duoc khoi chay tren cac cua so rieng biet:" -ForegroundColor Green
Write-Host " - Backend Swagger : http://localhost:5193/swagger" -ForegroundColor White
Write-Host " - Frontend UI      : http://localhost:5173" -ForegroundColor White
Write-Host " - Admin Account   : admin@bookstore.com / Admin@123456" -ForegroundColor White
Write-Host " - Employee Account: employee@bookstore.com / Employee@123456" -ForegroundColor White
Write-Host " - Customer Account: customer1@gmail.com / Password@123" -ForegroundColor White
Write-Host "========================================================================`n" -ForegroundColor Green
