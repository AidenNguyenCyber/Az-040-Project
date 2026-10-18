# Lab H - Supporting WhatIf and Confirm

# Function 1 - Keep the existing function from Lab G
function Get-CorpOSInfo {
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
#>                                                  
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Enter the computer name",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidatePattern('LON-\w{2,3}\d{1,2}')]
        [Alias('HostName')]
        [string[]]$ComputerName
    )

    process {
        foreach ($computer in $ComputerName) {
            Write-Verbose "Connecting to $computer"

            $os = Get-CimInstance -ComputerName $computer -ClassName Win32_OperatingSystem
            $compsys = Get-CimInstance -ComputerName $computer -ClassName Win32_ComputerSystem
            $bios = Get-CimInstance -ComputerName $computer -ClassName Win32_BIOS

            $properties = @{
                ComputerName = $computer
                OSVersion    = $os.Caption
                SPVersion    = $os.ServicePackMajorVersion
                BIOSSerial   = $bios.SerialNumber
                Manufacturer = $compsys.Manufacturer
                Model        = $compsys.Model
            }

            $output = New-Object -TypeName PSObject -Property $properties
            Write-Output $output
        }
    }
}


# Function 2 - Lab H
# Demonstrates the required WhatIf/Confirm safety mechanism.
# It does not perform an actual service-password change.
function Set-CorpServicePassword {

    # Enable -WhatIf and -Confirm
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    param(
        [Parameter(Mandatory = $true)]
        [string]$ComputerName,

        [Parameter(Mandatory = $true)]
        [string]$ServiceName,

        [Parameter(Mandatory = $true)]
        [string]$NewPassword
    )

    process {
        # Identify the intended target
        $target = "$ServiceName on $ComputerName"

        # Check whether the operation should proceed
        if ($PSCmdlet.ShouldProcess($target, "Change service password")) {

            # Demonstration only:
            # The actual password-changing operation must come
            # from the original Lab H starting script.

            Write-Warning "Password change not implemented in this demonstration."
        }
    }
}

# Test safely without making any changes
Set-CorpServicePassword -ComputerName LON-SVR1 `
    -ServiceName BITS `
    -NewPassword "Pa55w.rd" `
    -WhatIf
