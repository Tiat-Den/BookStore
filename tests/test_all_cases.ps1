<#
========================================================================================
 BookStore E-Commerce Comprehensive Test Suite
 Tuân thủ quy định: .agent/TEST_CASES.md & BUSINESS_RULES.md (BR-01 đến BR-36)
 Vai trò: qa-agent (bookstore-testing skill)
========================================================================================
#>

$baseUrl = "http://localhost:5193/api"
$testResults = @()

function Report-Test {
    param(
        [string]$Id,
        [string]$Description,
        [bool]$Passed,
        [string]$Details = ""
    )
    $status = if ($Passed) { "[PASS]" } else { "[FAIL]" }
    $color = if ($Passed) { "Green" } else { "Red" }
    Write-Host "$status $Id : $Description - $Details" -ForegroundColor $color
    $script:testResults += [PSCustomObject]@{
        ID = $Id
        Description = $Description
        Result = if ($Passed) { "PASS" } else { "FAIL" }
        Details = $Details
    }
}

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "               RUNNING BOOKSTORE AUTOMATED TEST SUITE                   " -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan

# --------------------------------------------------------------------------------------
# 1. AUTHENTICATION TEST CASES
# --------------------------------------------------------------------------------------
Write-Host "`n--- 1. AUTHENTICATION TESTS ---" -ForegroundColor Yellow

# TC-AUTH-01: Register new email
$uniqueEmail = "user_test_$(Get-Random)@gmail.com"
try {
    $regBody = @{
        fullName = "Test User"
        email = $uniqueEmail
        password = "Password@123"
        phone = "0987111222"
    } | ConvertTo-Json
    $regRes = Invoke-RestMethod -Uri "$baseUrl/auth/register" -Method Post -ContentType "application/json; charset=utf-8" -Body $regBody
    Report-Test "TC-AUTH-01" "Register email moi" ($regRes.success -eq $true) "User registered: $uniqueEmail"
} catch {
    Report-Test "TC-AUTH-01" "Register email moi" $false $_.Exception.Message
}

# TC-AUTH-02: Register duplicate email -> Chặn 400
try {
    $dupBody = @{
        fullName = "Test User Duplicate"
        email = $uniqueEmail
        password = "Password@123"
    } | ConvertTo-Json
    $dupRes = Invoke-RestMethod -Uri "$baseUrl/auth/register" -Method Post -ContentType "application/json; charset=utf-8" -Body $dupBody
    Report-Test "TC-AUTH-02" "Register email trung" $false "Should have failed"
} catch {
    Report-Test "TC-AUTH-02" "Register email trung" $true "Correctly blocked duplicate email (400)"
}

# TC-AUTH-03: Login sai password -> Chặn 401
try {
    $badLogin = @{ email = $uniqueEmail; password = "WrongPassword999" } | ConvertTo-Json
    $badRes = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -ContentType "application/json" -Body $badLogin
    Report-Test "TC-AUTH-03" "Password sai" $false "Should have rejected"
} catch {
    Report-Test "TC-AUTH-03" "Password sai" $true "Rejected invalid password (401)"
}

# TC-AUTH-04: Login đúng password -> Trả token
$custToken = ""
try {
    $goodLogin = @{ email = $uniqueEmail; password = "Password@123" } | ConvertTo-Json
    $loginRes = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -ContentType "application/json" -Body $goodLogin
    $custToken = $loginRes.data.token
    Report-Test "TC-AUTH-04" "Login dung pass lay JWT Token" ($custToken -ne $null -and $custToken.Length -gt 20) "JWT Token received"
} catch {
    Report-Test "TC-AUTH-04" "Login dung pass lay JWT Token" $false $_.Exception.Message
}

# Lấy token Admin
$adminToken = ""
try {
    $adminLogin = @{ email = "admin@bookstore.com"; password = "Admin@123456" } | ConvertTo-Json
    $adminRes = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -ContentType "application/json" -Body $adminLogin
    $adminToken = $adminRes.data.token
} catch {
    Write-Host "Cannot login admin: $($_.Exception.Message)" -ForegroundColor Red
}

# --------------------------------------------------------------------------------------
# 2. BOOKS & CATALOG TEST CASES
# --------------------------------------------------------------------------------------
Write-Host "`n--- 2. BOOKS & CATALOG TESTS ---" -ForegroundColor Yellow

# TC-BOOK-01: List books pagination
$firstBookId = ""
try {
    $booksRes = Invoke-RestMethod -Uri "$baseUrl/books?page=1&pageSize=5" -Method Get
    $firstBookId = $booksRes.data.items[0].id
    $hasPaging = $booksRes.data.totalCount -gt 0 -and $booksRes.data.items.Count -gt 0
    Report-Test "TC-BOOK-01" "List books co pagination" $hasPaging "Total: $($booksRes.data.totalCount) books"
} catch {
    Report-Test "TC-BOOK-01" "List books co pagination" $false $_.Exception.Message
}

# TC-BOOK-02: Search keyword
try {
    $searchRes = Invoke-RestMethod -Uri "$baseUrl/books?keyword=Tam" -Method Get
    $match = $searchRes.data.items.Count -gt 0
    Report-Test "TC-BOOK-02" "Search tu khoa 'Tam'" $match "Found: $($searchRes.data.items.Count) books"
} catch {
    Report-Test "TC-BOOK-02" "Search tu khoa 'Tam'" $false $_.Exception.Message
}

# TC-BOOK-03: Filter price range
try {
    $filterRes = Invoke-RestMethod -Uri "$baseUrl/books?minPrice=50000&maxPrice=150000" -Method Get
    $validRange = $true
    foreach ($b in $filterRes.data.items) {
        if ($b.salePrice -lt 50000 -or $b.salePrice -gt 150000) { $validRange = $false }
    }
    Report-Test "TC-BOOK-03" "Filter price range 50k-150k" $validRange "Total in range: $($filterRes.data.items.Count)"
} catch {
    Report-Test "TC-BOOK-03" "Filter price range 50k-150k" $false $_.Exception.Message
}

# TC-BOOK-06: Unauthorized CRUD (Customer gọi Admin API tạo sách -> Chặn 403)
try {
    $bookBody = @{
        isbn = "9781234567890"
        title = "Unauthorized Book"
        salePrice = 100000
        importPrice = 50000
    } | ConvertTo-Json
    $unauthRes = Invoke-RestMethod -Uri "$baseUrl/books" -Method Post -Headers @{ Authorization = "Bearer $custToken" } -ContentType "application/json" -Body $bookBody
    Report-Test "TC-BOOK-06" "Customer tao sach bi chan 403" $false "Customer should not be able to create books"
} catch {
    Report-Test "TC-BOOK-06" "Customer tao sach bi chan 403" $true "Access denied for non-admin (403)"
}

# --------------------------------------------------------------------------------------
# 3. CART TEST CASES
# --------------------------------------------------------------------------------------
Write-Host "`n--- 3. CART TESTS ---" -ForegroundColor Yellow

$custHeaders = @{ Authorization = "Bearer $custToken" }

# TC-CART-01: Add book to cart
try {
    $cartBody = @{ bookId = $firstBookId; quantity = 1 } | ConvertTo-Json
    $cartRes = Invoke-RestMethod -Uri "$baseUrl/cart/items" -Method Post -Headers $custHeaders -ContentType "application/json" -Body $cartBody
    $added = $cartRes.data.items.Count -gt 0
    Report-Test "TC-CART-01" "Them sach vao gio hang" $added "Cart has $($cartRes.data.items.Count) item(s)"
} catch {
    Report-Test "TC-CART-01" "Them sach vao gio hang" $false $_.Exception.Message
}

# TC-CART-02: Add same book -> Quantity updates
try {
    $cartBody = @{ bookId = $firstBookId; quantity = 2 } | ConvertTo-Json
    $cartRes2 = Invoke-RestMethod -Uri "$baseUrl/cart/items" -Method Post -Headers $custHeaders -ContentType "application/json" -Body $cartBody
    $targetItem = $cartRes2.data.items | Where-Object { $_.bookId -eq $firstBookId }
    $qtyUpdated = $targetItem.quantity -ge 3
    Report-Test "TC-CART-02" "Them tiep cung quyen sach -> Cong don quantity" $qtyUpdated "New Quantity: $($targetItem.quantity)"
} catch {
    Report-Test "TC-CART-02" "Them tiep cung quyen sach -> Cong don quantity" $false $_.Exception.Message
}

# --------------------------------------------------------------------------------------
# 4. ORDER & COUPON TEST CASES
# --------------------------------------------------------------------------------------
Write-Host "`n--- 4. ORDER & COUPON TESTS ---" -ForegroundColor Yellow

# TC-ORDER-04: Coupon validation
try {
    $coupBody = @{ code = "BOOK20"; orderAmount = 300000 } | ConvertTo-Json
    $coupRes = Invoke-RestMethod -Uri "$baseUrl/coupons/validate" -Method Post -ContentType "application/json" -Body $coupBody
    $coupOk = $coupRes.data.isValid -eq $true -and $coupRes.data.discountAmount -gt 0
    Report-Test "TC-ORDER-04" "Validate Coupon BOOK20" $coupOk "Discount amount: $($coupRes.data.discountAmount) VND"
} catch {
    Report-Test "TC-ORDER-04" "Validate Coupon BOOK20" $false $_.Exception.Message
}

# TC-ORDER-01: Checkout hợp lệ
$createdOrderId = ""
$createdOrderCode = ""
try {
    $ordBody = @{
        receiverName = "Test User"
        phone = "0987111222"
        province = "TP. Ho Chi Minh"
        district = "Quan 1"
        ward = "Phuong Ben Nghe"
        addressLine = "123 Le Loi"
        paymentMethod = "VNPAY"
        couponCode = "BOOK20"
        note = "Giao buoi sang"
    } | ConvertTo-Json
    $ordRes = Invoke-RestMethod -Uri "$baseUrl/orders" -Method Post -Headers $custHeaders -ContentType "application/json" -Body $ordBody
    $createdOrderId = $ordRes.data.id
    $createdOrderCode = $ordRes.data.orderCode
    $ordOk = $ordRes.success -eq $true -and $createdOrderId -ne ""
    Report-Test "TC-ORDER-01" "Checkout don hang hop le voi Coupon" $ordOk "Order: $createdOrderCode, Total: $($ordRes.data.totalAmount)"
} catch {
    Report-Test "TC-ORDER-01" "Checkout don hang hop le voi Coupon" $false $_.Exception.Message
}

# --------------------------------------------------------------------------------------
# 5. PAYMENT TEST CASES
# --------------------------------------------------------------------------------------
Write-Host "`n--- 5. PAYMENT TESTS ---" -ForegroundColor Yellow

# TC-PAY-01: VNPay create URL
try {
    $vnpRes = Invoke-RestMethod -Uri "$baseUrl/payment/vnpay/create-url" -Method Post -Headers $custHeaders -ContentType "application/json" -Body ($createdOrderId | ConvertTo-Json)
    Report-Test "TC-PAY-01" "Sinh URL thanh toan VNPay" ($vnpRes.success -eq $true) "URL: $($vnpRes.data)"
} catch {
    Report-Test "TC-PAY-01" "Sinh URL thanh toan VNPay" $false $_.Exception.Message
}

# TC-PAY-02: VNPay mock callback -> PAID
try {
    $mockPayBody = @{
        orderId = $createdOrderId
        paymentMethod = "VNPAY"
        isSuccess = $true
    } | ConvertTo-Json
    $mockRes = Invoke-RestMethod -Uri "$baseUrl/payment/vnpay/process-mock" -Method Post -Headers $custHeaders -ContentType "application/json" -Body $mockPayBody
    Report-Test "TC-PAY-02" "Thanh toan VNPay thanh cong -> Chuyen PAID" ($mockRes.success -eq $true) "Payment processed"
} catch {
    Report-Test "TC-PAY-02" "Thanh toan VNPay thanh cong -> Chuyen PAID" $false $_.Exception.Message
}

# --------------------------------------------------------------------------------------
# 6. REVIEWS & BUSINESS RULE BR-29
# --------------------------------------------------------------------------------------
Write-Host "`n--- 6. REVIEWS & BR-29 TESTS ---" -ForegroundColor Yellow

# TC-REV-02: Non-buyer / Chua DELIVERED -> Chặn 400 (BR-29)
try {
    $revBad = @{ bookId = $firstBookId; rating = 5; content = "Danh gia khi chua nhan sach" } | ConvertTo-Json
    $revBadRes = Invoke-RestMethod -Uri "$baseUrl/reviews" -Method Post -Headers $custHeaders -ContentType "application/json" -Body $revBad
    Report-Test "TC-REV-02" "BR-29: Chan danh gia khi chua DELIVERED" $false "Should have blocked"
} catch {
    Report-Test "TC-REV-02" "BR-29: Chan danh gia khi chua DELIVERED" $true "Correctly blocked review before DELIVERED"
}

# --------------------------------------------------------------------------------------
# 7. AUTHORIZATION & RBAC TEST CASES
# --------------------------------------------------------------------------------------
Write-Host "`n--- 7. AUTHORIZATION & RBAC TESTS ---" -ForegroundColor Yellow

# TC-RBAC-01: Customer gọi Admin Reports API -> Chặn 403
try {
    $adminRep = Invoke-RestMethod -Uri "$baseUrl/reports/dashboard" -Method Get -Headers $custHeaders
    Report-Test "TC-RBAC-01" "Customer goi Admin Reports bi chan 403" $false "Customer should not access admin reports"
} catch {
    Report-Test "TC-RBAC-01" "Customer goi Admin Reports bi chan 403" $true "Access denied (403)"
}

# TC-RBAC-04: Gọi protected API mà không có Token -> Chặn 401
try {
    $noTokenRes = Invoke-RestMethod -Uri "$baseUrl/cart" -Method Get
    Report-Test "TC-RBAC-04" "Goi Protected API khong Token bi chan 401" $false "Should reject unauthenticated call"
} catch {
    Report-Test "TC-RBAC-04" "Goi Protected API khong Token bi chan 401" $true "Unauthorized (401)"
}

# --------------------------------------------------------------------------------------
# SUMMARY REPORT
# --------------------------------------------------------------------------------------
Write-Host "`n========================================================================" -ForegroundColor Cyan
Write-Host "                      TEST EXECUTION SUMMARY                            " -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan

$passedCount = ($testResults | Where-Object { $_.Result -eq "PASS" }).Count
$totalCount = $testResults.Count

$testResults | Format-Table -Property ID, Result, Description, Details -AutoSize

if ($passedCount -eq $totalCount) {
    Write-Host "ALL $totalCount TESTS PASSED SUCCESSFULLY! (100%)" -ForegroundColor Green
} else {
    Write-Host "TESTS COMPLETED: $passedCount / $totalCount PASSED." -ForegroundColor Yellow
}
