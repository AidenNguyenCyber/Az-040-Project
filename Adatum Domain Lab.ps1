#Challenge 1, list the computers in the Adatum domain
$computers = @('LON-CL1', 'LON-DC1', 'LON-SVR1');
foreach ($pc in $computers) {
    write-output "Computer: $pc"
}

#Challenge 2, build domain qualified names
$domain = 'adatum.com'
foreach ($pc in $computers) {
    write-output "$pc.$domain"
}

#Challenge 3, inspect local services
$services = @('EventLog', 'W32Time', 'Spooler');
foreach ($svc in $services) {
    $info = Get-Service -Name $svc
    Write-Output "Name: $($info.Name) | Status: $($info.Status)"
}

#Challenge 4, Count local services 
$Gservices = @(Get-Service)
$total = 0

foreach ($service in $Gservices) {
    Write-Output $service.Name
    $total++
}

Write-Output "Total Services: $total"

#Challenge 5, read the domain computer inventory
import-module activedirectory
$computers = @('LON-CL1', 'LON-DC1', 'LON-SVR1');

foreach ($computer in $computers) {
    $adComputer = Get-ADComputer -Identity $computer -Server LON-DC1.Adatum.com -Properties OperatingSystem
    Write-Output "Name: $($adComputer.Name) | DNS: $($adComputer.DNSHostName) | 
    OS: $($adComputer.OperatingSystem)"
}

#Challenge 6, Flag local services for review
$services = @('EventLog', 'W32Time', 'Spooler');
$count = 0

foreach ($svc in $services) {
    $info = Get-Service -Name $svc
    if ($info.Status -eq 'Running') {
        Write-Output "OK: $($service.Name)"
    }
    Else {
        Write-Output "REVIEW: $($service.Name) | Status: $($service.Status)"
        $count++
    }
}
Write-Output "Total services for review: $count"

#Challenge 7, summarize domain user account states
import-module activedirectory
$user = @(get-aduser -filter * 
    -searchbase "DC=Adatum,DC=com" 
    -Server LON-DC1.Adatum.com)

$enabledCount = 0
$disabledCount = 0

foreach ($u in $user) {
    if ($u.Enabled -eq $true) {
        write-output "Enabled: $($u.SamAccountName)"
        $enabledCount++
    }
    Else {
        write-output "Disabled: $($u.SamAccountName)"
        $disabledCount++
    }
}
Write-Output "Enabled users: $enabledCount"
Write-Output "Disabled users: $disabledCount"

#Challenge 08 Test lab network responses
$computers = @('LON-CL1', 'LON-DC1', 'LON-SVR1');
$domain = 'adatum.com'
$count = 0

foreach ($pc in $computers) {
    $target = "$pc.$domain"
    $response = Test-Connection -ComputerName $target -Count 1 -Quiet Erroraction SilentlyContinue
    if ($response -eq $true) {
        Write-Output "OK: $target is responding"
        $count++
    }
    Else {
        Write-Output "REVIEW: $target is not responding"
    }
}

write-Output "Total responding computers: $count"

#Challenge 09 Extort a computer account report
$computers = @('LON-CL1', 'LON-DC1', 'LON-SVR1');

$report = @(foreach ($computer in $computers) {
        $adComputer = Get-ADComputer -Identity $computer -Server LON-DC1.Adatum.com -Properties OperatingSystem
        if ($adComputer.Enabled) {
            $state = 'Enabled'
        }
        else {
            $state = 'Disabled'
        }

        [pscustomobject]@{
            ComputerName    = $adComputer.Name
            DNSHostName     = $adComputer.DNSHostName
            OperatingSystem = $adComputer.OperatingSystem
            AccountState    = $state
        }
    }
)
# 1 Generate a unique CSV filename
$fileName = 'Challenge09-' + [guid]::NewGuid() + '.csv'

# 2 Save the file in the same folder as your script
$filePath = Join-Path $PSScriptRoot $fileName

# 3 Export the report to CSV
$report | Export-Csv -Path $filePath -NoTypeInformation -Encoding UTF8

# 4 Import the CSV to verify its contents
$imported = @(Import-Csv -Path $filePath)

# 5 Display the results
Write-Output "Report saved: $filePath"
Write-Output "Total records: $($imported.Count)"

#Challenge 10 Review services on the member server


$targets = @('LON-SVR1.Adatum.com')

foreach ($target in $targets) {
    try {
        $services = @(Invoke-Command -ComputerName $target `
                -ErrorAction Stop -ScriptBlock {
                Get-Service -Name 'EventLog', 'W32Time', 'Spooler' `
                    -ErrorAction Stop
            })

        foreach ($service in $services) {
            if ($service.Status -eq 'Running') {
                Write-Output "OK: $target | $($service.Name) | $($service.Status)"
            }
            else {
                Write-Output "REVIEW: $target | $($service.Name) | $($service.Status)"
            }
        }
    }
    catch {
        Write-Output "QUERY FAILED: $target | $($_.Exception.Message)"
    }
}
