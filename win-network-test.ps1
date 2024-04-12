# Get the current date and define timestamp format
$currentTime = Get-Date
$timestampFormat = "yyyyMMdd_HHmmss"

# Construct the filename with the timestamp
$filename = "network-test_" + $currentTime.ToString($timestampFormat) + ".txt"

# Create the text file in the same path as the script
New-Item -Path $PSScriptRoot -ItemType File -Name $filename

# Construct the log file path
$logPath = Join-Path -Path $PSScriptRoot -ChildPath $filename

# Begin commands execution
Write-Host "Running network test. It may take several minutes to complete. Please, do not close this window."
"" >> $logPath
"" >> $logPath
"Execution started at $([System.DateTime]::Now)" >> $logPath

# Get hostname, network adapter and IP
"Hostname: " + $env:COMPUTERNAME >> $logPath
$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
$adapter | Format-Table -Property Name, InterfaceDescription, ifIndex, Status, MacAddress -AutoSize >> $logPath
$index = $adapter.ifIndex
Get-NetIPConfiguration -InterfaceIndex $index >> $logPath

# Test connection to AdGate
$app1="myapp1.com" # Replace with your app name
"Testing connection to AdGate at $([System.DateTime]::Now)" >> $logPath
Test-NetConnection -ComputerName $app1 -Port 443 >> $logPath

# Trace route to AdGate
"Trace route to AdGate at $([System.DateTime]::Now)" >> $logPath
tracert -h 20 $app1 >> $logPath

# Test connection to JARV
$app2="myapp2.com" # Replace with your app name
"Testing connection to JARV at $([System.DateTime]::Now)" >> $logPath
Test-NetConnection -ComputerName $app2 -Port 443 >> $logPath

# Trace route to JARV
"Trace route to JARV at $([System.DateTime]::Now)" >> $logPath
tracert -h 20 $app2 >> $logPath

# Test connection to JARV
$app3="myapp3.com" # Replace with your app name
"Testing connection to JARV at $([System.DateTime]::Now)" >> $logPath
Test-NetConnection -ComputerName $app3 -Port 443 >> $logPath

# Trace route to JARV
"Trace route to JARV at $([System.DateTime]::Now)" >> $logPath
tracert -h 20 $app3 >> $logPath

# End execution and lose the console window
Write-Host "Execution completed at $([System.DateTime]::Now)" >> $logPath
Write-Host "Please wait, this window will close automatically."
Start-Sleep -Seconds 1