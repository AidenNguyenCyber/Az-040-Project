

function Get-CorpOSInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, helpMessage="Please provide a computer name.")]
        [validatepattern('LON-\w{2,3}\d{1,2}')]
        [alias('HostName')]
        [string]$ComputerName
    )
    Write-Verbose "Connecting to $ComputerName"
    Get-CimInstance -ComputerName $ComputerName -ClassName Win32_OperatingSystem
}