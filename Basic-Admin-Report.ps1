Get-CimInstance -ClassName Win32_ComputerSystem |
Select-object Name, Manufacturer, Model, Domain

$system = get-ciminstance -ClassName Win32_ComputerSystem
$system 

$system.Name
$system.Manufacturer
$system.Model
$system.Domain

$system| select-object Name, model

$system| get-member -membertype property
$system.NumberOfLogicalProcessors

$computerReport = $system |
    Select-Object Name, Manufacturer, Model, Domain, NumberOfLogicalProcessors

$computerReport

$bios = Get-CimInstance -ClassName Win32_BIOS
$bios

$bios.Manufacturer
$bios.SMBIOSBIOSVersion
$bios.SerialNumber


$biosReport = $bios |
    Select-Object Manufacturer, SMBIOSBIOSVersion, SerialNumber

$biosReport

$reportProperties = @{
    ComputerName      = $system.Name
    Manufacturer      = $system.Manufacturer
    Model             = $system.Model
    Domain            = $system.Domain
    LogicalProcessors = $system.NumberOfLogicalProcessors
    BIOSManufacturer  = $bios.Manufacturer
    BIOSVersion       = $bios.SMBIOSBIOSVersion
    SerialNumber      = $bios.SerialNumber
    BIOSReleaseDate = $bios.ReleaseDate
}

$reportProperties

$reportProperties['ComputerName']

$adminReport = [pscustomobject]$reportProperties
$adminReport


$adminReport | Get-Member -MemberType NoteProperty

$adminReport.ComputerName
$adminReport | Select-Object ComputerName, Model, BIOSVersion

$reportFolder = $env:USERPROFILE
$reportFolder

$adminReport | Export-Csv "$reportFolder\AdminReport.csv" -NoTypeInformation

Import-Csv "$reportFolder\AdminReport.csv"

Test-Path "$reportFolder\AdminReport.csv"

$adminReport | Select-Object ComputerName, Domain
$adminReport | Select-Object Domain, ComputerName

$bios | Get-Member
$bios.ReleaseDate
