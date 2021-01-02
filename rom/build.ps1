Push-Location $PSScriptRoot

Remove-Item .\bin -Recurse | Out-Null
Remove-Item .\obj -Recurse | Out-Null

New-Item -ItemType Directory .\bin | Out-Null
New-Item -ItemType Directory .\obj | Out-Null

cc65.exe -t none -O --cpu 65c02 src\rom.c -o obj\rom.s
ca65.exe --cpu 65c02 obj\rom.s -o obj\rom.o
ca65.exe --cpu 65c02 src\interrupt.s -o obj\interrupt.o
ca65.exe --cpu 65c02 src\startup.s -o obj\startup.o
ca65.exe --cpu 65c02 src\vectors.s -o obj\vectors.o
ca65.exe --cpu 65c02 src\zeropage.s -o obj\zeropage.o
ld65.exe -C src\machine.cfg none.lib obj\interrupt.o obj\startup.o obj\vectors.o obj\zeropage.o obj\rom.o -o bin\rom.bin

Get-ChildItem .\bin\rom.bin

Pop-Location