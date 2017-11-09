import-module activedirectory
. .\Invoke-Ping.ps1 #invoke-ping.ps1 obtained from microsoft (link: https://gallery.technet.microsoft.com/scriptcenter/Invoke-Ping-Test-in-b553242a) -- needs to be in same location as this file

$ADcomputers = Get-ADComputer -Filter "OperatingSystem -like '*10*' -and OperatingSystem -notlike '*enterprise*'" -Property * | 
    Select-Object -expand Name

$pingComputers = invoke-ping -ComputerName $ADcomputers | 
    Select-Object Address, @{Name="Name"; Expression={$_.Address}}, Status | 
    where {$_.Status -like 'Responding'}  

Get-ADComputer -Filter "OperatingSystem -like '*10*' -and OperatingSystem -notlike '*enterprise*'" -Property * | 
    where ({$pingComputers.Name -contains $_.Name}) | 
    Select-Object Name,OperatingSystem,@{Name="LastLogonTime"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}},extensionattribute2 |
    Sort-Object Name |
    export-csv C:\users\huffa\win10_invokePing.csv
