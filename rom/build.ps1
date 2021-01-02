Push-Location $PSScriptRoot

Remove-Item .\bin -Recurse | Out-Null
Remove-Item .\obj -Recurse | Out-Null

New-Item -ItemType Directory .\bin | Out-Null
New-Item -ItemType Directory .\obj | Out-Null

$asms = @()
$objs = @()

Write-Output "`n[+] Compiling *.c...`n"

foreach ($c in (Get-ChildItem .\src\*.c)) {
    $c = "src\" + (Split-Path -Leaf $c)
    $s = "obj\" + (Split-Path -LeafBase $c) + ".s"

    Write-Output "  > cc65 $c"

    cc65.exe -t none -O --cpu 65c02 $c -o $s
    if (-not $?) {
        Write-Output "`n[!] cc65.exe Failed"
        Exit
    }

    $asms += $s
}

$asms += ".\third_party\cc65\libsrc\common\copydata.s"
$asms += ".\third_party\cc65\libsrc\common\zerobss.s"

foreach ($base in @(".\third_party\cc65\libsrc\runtime", ".\src")) {
    foreach ($s in (Get-ChildItem $base\*.s)) {
        $asms += "$base\" + (Split-Path -Leaf $s)
    }
}

Write-Output "`n[+] Assembling *.s...`n"

foreach ($s in $asms) {
    $o = "obj\" + (Split-Path -LeafBase $s) + ".o"

    Write-Output "  > ca65 $s"

    ca65.exe --cpu 65c02 $s -o $o
    if (-not $?) {
        Write-Output "`n[!] ca65.exe Failed"
        Exit
    }

    $objs += $o
}

Write-Output "`n[+] Linking *.o...`n"

Write-Output "  > ld65 -> bin\rom.bin"

ld65.exe -C cfg\board.cfg none.lib $objs -o bin\rom.bin
if (-not $?) {
    Write-Output "`n[!] ld65.exe Failed"
    Exit
}

Write-Output "`n[+] Done`n"

Pop-Location
