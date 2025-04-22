# CARGAMOS LA INFO DE LAS IP
$ips Get-Content -Path "./ips.json" -Raw | ConvertFrom-Json

Write-Output $ips