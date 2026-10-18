<#
.SYNOPSIS
Gets operating system and hardware information from computers.

.DESCRIPTION
Collects Windows OS, manufacturer, model, and BIOS information.
Returns one custom object for each computer.

.PARAMETER ComputerName
Enter one or more computer names starting with LON-.
Also accepts computer names through the pipeline.

.EXAMPLE
Get-CorpOSInfo -ComputerName LON-DC1

Gets system information from LON-DC1.

.EXAMPLE
"LON-DC1","LON-SVR1" | Get-CorpOSInfo

Gets system information from both computers through the pipeline.
#>#>
function Get-CorpOSInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, helpMessage="Please provide a computer name.", 
        ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [validatepattern('LON-\w{2,3}\d{1,2}')]
        [alias('HostName')]
        [string[]]$ComputerName
    )
    process {
        foreach ($Computer in $ComputerName) {
            Write-Verbose "Connecting to $Computer"
            $OS = Get-CimInstance -ComputerName $Computer -ClassName Win32_OperatingSystem
            $compsys = Get-CimInstance -ComputerName $computer -ClassName Win32_ComputerSystem
            $bios = Get-CimInstance -ComputerName $computer -ClassName Win32_BIOS
            $properties = @{
                ComputerName = $Computer
                OSVersion = $os.Caption
                SPVersion = $os.servicepackmajorversion
                BIOSSerial = $bios.SerialNumber
                Manufacturer = $compsys.Manufacturer
                Model = $compsys.Model
            }
        $output = New-Object -TypeName PSObject -Property $properties
        write-Output $output
        }
    }
}


Get-Help Get-CorpOSInfo -Full