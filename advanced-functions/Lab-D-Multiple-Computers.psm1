

function Get-CorpOSInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, helpMessage="Please provide a computer name.")]
        [validatepattern('LON-\w{2,3}\d{1,2}')]
        [alias('HostName')]
        [string[]]$ComputerName
    )
    foreach ($Computer in $ComputerName) {
        Write-Verbose "Connecting to $Computer"
        Get-CimInstance -ComputerName $Computer -ClassName Win32_OperatingSystem
    }
}