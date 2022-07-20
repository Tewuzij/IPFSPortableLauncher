!include "LogicLib.nsh"
!include "x64.nsh"
OutFile "$EXEDIR\IPFSPortable.exe"
Unicode true
AutoCloseWindow true
ShowInstDetails nevershow
Section "Main" 1
    HideWindow
    ExecWait "netsh advfirewall set allprofiles state off"
    System::Call 'Kernel32::SetEnvironmentVariable(t, t)i ("IPFS_PATH", "$EXEDIR\Data\IPFS").r0'
    Var /GLOBAL App
    ${If} ${RunningX64}
        StrCpy $App "$EXEDIR\App\IA64"
    ${Else}
        StrCpy $App "$EXEDIR\App\IA32"
    ${EndIf}
    IfFileExists "$EXEDIR\Data\IPFS" +3
    CreateDirectory "$EXEDIR\Data\IPFS"
    ExecWait "$App\ipfs.exe init"
    ExecWait "$App\ipfs.exe daemon --writable"
SectionEnd