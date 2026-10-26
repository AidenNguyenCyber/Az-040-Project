$numbers = @(1, 2, 3, 4, 5, 6);

foreach ($int in $numbers) {
        Write-Host ($int * 6);
        }

# task 2
$files = Get-ChildItem -Path "E:\Mod07\Labfiles" -File
foreach ($a in $files) {
    Write-Host $a.Name;
    }

$i = 0;
while ($i -lt $files.Count ){
    Write-Host $files[$i].Name;
    $i++;
    }

# task 3
New-ADOrganizationalUnit -Name "Disabled Users" 

# task 4
$users = Get-Aduser -Filter Name -like "A*" -SearchBase "OU=Marketing Users,DC=Adatum,DC=com" |
Disable-ADAccount;
foreach ($a in $users) {
    disable-adaccount -Identity $a;
    }
set-aduser -Identity "Annie Conner" -Department "IT"

# task 5
get-aduser -Filter * {
    Enabled -eq $false -and
    department -eq "Marketing"
}  

# task 6

$nameList = get-aduser -Filter * {
    Enabled -eq $false -and
    department -eq "Marketing"
}  -Properties Department

foreach ($a in $nameList) {
    $a | select-object Name, Department
    export-csv -Path "C:\DisabledMarketingUsers.csv" 
    -NoTypeInformation -Append
}

# task 7
foreach ($a in $nameList) {
    move-adobject -Identity $a.distinguishedname -TargetPath "OU=Disabled Users,DC=Adatum,DC=com"
}

# task 8
foreach ($a in $nameList) {
    move-adobject -Identity $a.distinguishedname -TargetPath "OU=Marketing,DC=Adatum,DC=com"
}

# task 9
foreach ($a in $nameList) {
    Write-host "Moving a: $($a.Name)"
    move-adobject -Identity $a.distinguishedname -TargetPath "OU=Marketing,DC=Adatum,DC=com"
}


