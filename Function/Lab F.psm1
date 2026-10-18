# Lab F - Creating Custom Output Objects
# Collects OS, hardware, and BIOS information from multiple computers.
# Combines the results into custom PowerShell objects for system inventory.
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
