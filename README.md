# AZ-040 PowerShell Labs

PowerShell administration exercises from Microsoft Software & Systems Academy (MSSA), covering Windows inventory, Active Directory administration, CIM queries, script modules, and advanced functions.

**Scope:** This is a collection of separate learning exercises, not one integrated automation tool. The examples use the fictional **Adatum** domain (`adatum.com`) and machines such as `LON-DC1` and `LON-SVR1`.

## Advanced functions — Labs A–H

These labs progressively build a function called `Get-CorpOSInfo`. Each module is a **separate stage** of the same exercise; do not import them together expecting eight different commands.

| Lab | File | Main concept |
| --- | --- | --- |
| A | [Advanced function](advanced-functions/Lab-A-Advanced-Function.ps1) | Wrap a CIM query in an advanced function using `[CmdletBinding()]`. |
| B | [Script module](advanced-functions/Lab-B-Script-Module.psm1) | Package the function in a `.psm1` file and add verbose output. |
| C | [Parameter validation](advanced-functions/Lab-C-Parameter-Validation.psm1) | Mandatory computer name, alias, and `ValidatePattern`. |
| D | [Multiple computers](advanced-functions/Lab-D-Multiple-Computers.psm1) | Accept an array of computer names and loop through them. |
| E | [Pipeline input](advanced-functions/Lab-E-Pipeline-Input.psm1) | Accept values and properties from the pipeline in a `process` block. |
| F | [Custom objects](advanced-functions/Lab-F-Custom-Objects.psm1) | Combine OS, computer-system, and BIOS queries into inventory objects. |
| G | [Comment-based help](advanced-functions/Lab-G-Comment-Based-Help.psm1) | Document the function with PowerShell help examples. |
| H | [WhatIf and Confirm](advanced-functions/Lab-H-WhatIf-Confirm.ps1) | Demonstrate `SupportsShouldProcess`, `ShouldProcess`, and `-WhatIf`. |

**Example — explore Lab F:**

```powershell
Import-Module ./advanced-functions/Lab-F-Custom-Objects.psm1 -Force
Get-CorpOSInfo -ComputerName LON-DC1 -Verbose

# Or pass more than one computer through the pipeline:
'LON-DC1', 'LON-SVR1' | Get-CorpOSInfo
```

Remote CIM access and the lab hosts must be available for these examples to return inventory data. Lab H's `Set-CorpServicePassword` is intentionally **demonstration only**: it supports the `-WhatIf` confirmation pattern but does **not** change service credentials.

## Administration exercises

| Script | Purpose |
| --- | --- |
| [Adatum Domain Challenges](administration-exercises/Adatum-Domain-Challenges.ps1) | Ten individual tasks: loops, services, AD computer/user queries, connectivity checks, CSV reporting, and remote service inspection. |
| [Basic Admin Report](administration-exercises/Basic-Admin-Report.ps1) | Explore CIM computer/BIOS properties, create a `PSCustomObject`, export to CSV, and import it back. |
| [System Information](administration-exercises/System-Information.ps1) | Query a lab computer for OS, C: drive capacity, free space, and uptime. |
| [AD Users and CIM Exercises](administration-exercises/AD-Users-And-CIM-Exercises.ps1) | Classroom snippets for creating AD users from a CSV and querying disk information with CIM. |
| [Mixed AD Practice](administration-exercises/Mixed-AD-Practice.ps1) | Exploratory loops, file listings, OU operations, AD account changes, and CSV exercises. |

## Requirements and safe use

- Windows PowerShell / PowerShell with the required **CIM** commands, and access to a Windows lab environment for remote queries.
- AD exercises require the **ActiveDirectory** PowerShell module and appropriate permissions.
- Several examples use fixed lab values such as `LON-DC1`, `DC=Adatum,DC=com`, `E:\Mod07\Labfiles\users.csv`, or `C:\DisabledMarketingUsers.csv`; update those for your own environment.
- **Read each exercise before running it.** `Mixed-AD-Practice.ps1` and `AD-Users-And-CIM-Exercises.ps1` are rough classroom snippets, **not verified end-to-end scripts**. They contain unfinished or conflicting examples, and some commands **create, disable, or move AD objects**. Do not run them wholesale against real accounts.
- The advanced-function files are successive versions of the same function. Import only the version you are working with.

## Where to make changes

- **Change the inventory fields:** start with [Lab F](advanced-functions/Lab-F-Custom-Objects.psm1), then edit the CIM queries and the `$properties` hashtable.
- **Change input rules or pipeline behavior:** use [Labs C–E](advanced-functions/Lab-C-Parameter-Validation.psm1).
- **Study safe change confirmation:** start with [Lab H](advanced-functions/Lab-H-WhatIf-Confirm.ps1); the actual password operation is intentionally unimplemented.
- **Change domain names, hosts, or CSV paths:** inspect the appropriate file under [administration-exercises](administration-exercises/).

### Status

These are training examples preserved to show the progression from individual commands to reusable PowerShell functions. The repository organization and source were reviewed, but the scripts have **not been executed or validated here** against the Adatum lab. A malformed help-comment terminator in Lab G was corrected during this cleanup; other exercises were preserved without changes to their logic.
