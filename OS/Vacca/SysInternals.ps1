#####################################################################################
"SysInternals"
#####################################################################################
net use * http://live.sysinternals.com
or
$wc = new-object System.Net.WebClient
$wc.DownloadFile("https://download.sysinternals.com/files/SysinternalsSuite.zip",
"$pwd\SysinternalsSuite.zip")
Expand-Archive SysinternalsSuite.zip
rm SysInternalsSuite.zip
cd SysInternalsSuitels


#Procmon - create a capture | filter for data
.\Procmon.exe -accepteula

#AutoRuns
.\autoruns.exe

#Process Explorer
.\procexp.exe

#TCP View
.\tcpview.exe





