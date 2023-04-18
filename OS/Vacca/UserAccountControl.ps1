HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System      #reg location for UAC
Prompt Colors:
    Red - Application or publisher blocked by group policy
    Blue & gold - Administrative application
    Blue - Trusted and Authenticode signed application
    Yellow - Unsigned or signed but not trusted application
    
The prompt will show if: (requires sysinternals)
./strings C:\Windows\System32\*.exe -accepteula | select-string -SimpleMatch "autoelevate"
./sigcheck -m C:\Windows\System32\slui.exe -accepteula | Select-String -SimpleMatch "level"
Trusted dir




