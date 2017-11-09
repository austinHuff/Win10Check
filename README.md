# Win10Check
These PowerShell scripts access Active Directory to find the computers that are running any Windows 10 other than Enterprise. Those computers are exported to a csv file containing the Name of the computer, operating system, and last log on time
win10Check_invokePing.ps1 uses and invoke ping method which is much quicker than win10Check.ps1 which uses a foreach to do one at a time
