$res = Invoke-RestMethod -Uri "http://localhost:5193/api/books"
if ($res.data.items) {
    $res.data.items | Select-Object -First 10 -Property id, title, price | Format-Table -AutoSize
} elseif ($res.items) {
    $res.items | Select-Object -First 10 -Property id, title, price | Format-Table -AutoSize
} else {
    $res | ConvertTo-Json -Depth 2
}
