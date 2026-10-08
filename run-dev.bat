@echo off
chcp 65001 > nul
title BookStore Development Launcher

echo ========================================================================
echo               KHOI CHAY HE THONG BOOKSTORE E-COMMERCE                   
echo ========================================================================
echo.
echo [1/2] Dang khoi dong Backend API (.NET 8 Web API tren cong 5193)...
start "BookStore Backend API (Port 5193)" cmd /k "cd Backend && dotnet run --project BookStore.Api --urls http://localhost:5193"

echo [2/2] Dang khoi dong Frontend (React Vite tren cong 5173)...
start "BookStore Frontend (Port 5173)" cmd /k "cd Frontend && npm run dev"

echo.
echo ========================================================================
echo Backend Swagger : http://localhost:5193/swagger
echo Frontend Website : http://localhost:5173
echo.
echo Tai khoan Admin    : admin@bookstore.com / Admin@123456
echo Tai khoan Khach hang: customer1@gmail.com / Password@123
echo ========================================================================
echo.
pause
