#Converting a command into an advanced function 
function Get-CorpOSInfo {
    [CmdletBinding()]
    param(
        [string]$ComputerName
    )
    Get-CimInstance -ComputerName $ComputerName -ClassName Win32_OperatingSystem
}

Get-CorpOSInfo -ComputerName lon-dc1.adatum.com





