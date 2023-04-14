####################################################################################
                          write-host "Boot"
####################################################################################
BIOS(MBR) is old
UEFI(GPT) is new

bcdedit             #boot info
bcdedit /?          #help about boot info
bcdedit /set {bootmgr} description "Del Taco"        #Changes the description field of the bootmgr to the string "Del Taco"

bcdedit /export C:\Boot.blk         #Sets Boot.blk as a backup of your boot configurations
bcdedit /import C:\Boot.blk         #Sets Boot.blk as the current boot configuration

bcdedit /create {ntldr} /d "Windows XP Pro SP2 - Tiger Paw"   #creates a new entry
c:\demo>bcdedit /set {ntldr} device partition=C:              #

c:\demo>bcdedit /set {ntldr} path \ntldr                      #

c:\demo>bcdedit /displayorder {ntldr} /addfirst               #

bcdedit /delete {ntldr} /f                                    #

bcdedit /deletevalue {current} safeboot (1)
bcdedit /set {bootmgr} timeout 29 (2)



