
#Creating a script Module
function Get-CorpOSInfo {
    [CmdletBinding()]
    param(
        [string]$ComputerName
    )
    Write-Verbose "Connecting to $ComputerName"
    Get-CimInstance -ComputerName $ComputerName -ClassName Win32_OperatingSystem
}