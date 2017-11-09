import-module activedirectory

$ADcomputers = Get-ADComputer -Filter "OperatingSystem -like '*10*' -and OperatingSystem -notlike '*enterprise*'" -Property * | Select-Object Name
$ADcomputers_pingable = @()

#write-output $ADcomputers.length
#$i = 0

foreach($c in $ADcomputers){

    if (Test-Connection -ComputerName $c.Name -Count 1 -Quiet) {$ADcomputers_pingable += $c.Name}

    #$i+=1
    #write-output $i

}

Get-ADComputer -Filter * -Property * | where ({$ADcomputers_pingable -contains $_.Name}) | 
    Select-Object Name,OperatingSystem,@{Name="LastLogonTime"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}},extensionattribute2 |
    Sort-Object Name |
    export-csv C:\users\huffa\win10.csv
