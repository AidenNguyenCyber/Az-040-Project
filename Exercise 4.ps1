$users = Import-Csv "E:\Mod07\Labfiles\users.csv"

ForEach ($u in $users) {
    $path = "OU=" + $u.Department + ",DC=Adatum,DC=com"
    $upn = $u.UserID + "@adatum.com"
    $display = $u.First + " " + $u.Last
    Write-Host "Creating $display in $path"
    New-ADUser -GivenName $u.First -Surname $u.Last -Name $display -DisplayName $display -SamAccountName $u.UserID -UserPrincipalName $UPN -Path $path -Department $u.Department
}

# task 5
param(
    [string]$ComputerName=(Read-Host "Enter computer name")
)

Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"

# task 6
param(
    [string]$ComputerName=(Read-Host "Enter computer name"),
    [switch]$AlternateCredentials
)

If ($AlternateCredential -eq $true) {
    $cred = Get-Credential
    $session = New-CimSession -ComputerName $ComputerName -Credential $cred
    Get-CimInstance Win32_LogicalDisk -CimSession $session -Filter "DriveType=3"
} Else {
    Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"
}
