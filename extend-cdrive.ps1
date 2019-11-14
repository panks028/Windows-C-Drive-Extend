import-module VMware.PowerCLI

Connect-viserver -server vcenter.example.com

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore

#If you are specifying a local path , ensure that it's an absolute path and not a relative path.
#$landingVMs = Get-DataCenter -Name "dc-vdi01" | Get-Folder -Name "mgt" | Get-VM

$landingVMs = Get-Content 'C:\Users\pankaj.sharma\Extend Windows C Drive\serverlist.txt'

Foreach ($VM in $landingVMs) 
{

#Specify the capacity disk size required.
    Get-HardDisk -VM $VM | ? {$_.Name -eq "hard disk 1"} | Set-HardDisk -CapacityGB 62 -Confirm:$false

#ensure that encoding is set to utf8 for diskpart1.txt file.
    Copy-Item -Path 'C:\Users\pankaj.sharma\Extend Windows C Drive\diskpart1.txt' -Destination "\\$VM\c$\";

#Below command would be executed locally for C Drive.    
    Invoke-Command -ComputerName $VM -ScriptBlock { diskpart.exe /s 'C:\diskpart1.txt' }

}