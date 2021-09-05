
Push-Location $PSScriptRoot

$old_path = $env:PATH
$env:PATH += ';' + (Join-Path (Get-Location) \third_party\cc65\bin)

Remove-Item .\bin -Recurse | Out-Null
Remove-Item .\obj -Recurse | Out-Null

New-Item -ItemType Directory .\bin | Out-Null
New-Item -ItemType Directory .\obj | Out-Null

$cs = [System.Collections.ArrayList]::new()
$asms = [System.Collections.ArrayList]::new()
$objs = [System.Collections.ArrayList]::new()

###
### cc65 *.c -> .s
###

function Compile {
    Write-Host "`n[+] Compiling *.c...`n"

    foreach ($c in (Get-ChildItem .\src\*.c)) {
        $c = "src\" + (Split-Path -Leaf $c)
        $s = "obj\" + (Split-Path -LeafBase $c) + ".s"

        [void]$cs.Add(@($c, $s))
        [void]$asms.Add($s)
    }

    $result = $cs | ForEach-Object -Parallel {
        $c = $_[0]
        $s = $_[1]

        Write-Host "  > cc65 $c"

        cc65.exe -t none -O --cpu 65c02 $c -o $s
        if (-not $?) {
            Write-Host "`n[!] cc65.exe Failed"
            return $false
        }
        return $true
    }

    foreach ($r in $result) {
        if (-not $r) {
            return $false
        }
    }
    return $true
}

###
### ca65 *.s -> .o
###

function Assemble {
    Write-Host "`n[+] Assembling *.s...`n"

    [void]$asms.Add(".\third_party\cc65\libsrc\common\copydata.s")
    [void]$asms.Add(".\third_party\cc65\libsrc\common\memset.s")
    [void]$asms.Add(".\third_party\cc65\libsrc\common\zerobss.s")

    foreach ($base in @(".\third_party\cc65\libsrc\runtime", ".\src")) {
        foreach ($s in (Get-ChildItem $base\*.s)) {
            $s = "$base\" + (Split-Path -Leaf $s)
            [void]$asms.Add($s)
        }
    }

    foreach ($s in $asms) {
        $o = "obj\" + (Split-Path -LeafBase $s) + ".o"
        [void]$objs.Add(@($s, $o))
    }

    $objs | Foreach-Object -Parallel {
        $s = $_[0]
        $o = $_[1]

        Write-Host "  > ca65 $s"

        ca65.exe --cpu 65c02 $s -o $o
        if (-not $?) {
            Write-Host "`n[!] ca65.exe Failed"
        }
    }

    foreach ($r in $result) {
        if (-not $r) {
            return $false
        }
    }
    return $true
}

###
### ld65 *.o -> .bin
###

if ((Compile) -and (Assemble)) {
    Write-Host "`n[+] Linking *.o...`n"

    Write-Host "  > ld65 -> bin\rom.bin"

    $objs = $objs | ForEach-Object { $_[1] }

    ld65.exe -C cfg\board.cfg $objs -o bin\rom.bin
    if ((-not $?) -or (-not (Test-Path .\bin\rom.bin))) {
        Write-Host "`n[!] ld65.exe Failed"
        Exit
    }

    Write-Host "`n[+] Done`n"
}

$env:PATH = $old_path
Pop-Location
