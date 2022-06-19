Push-Location $PSScriptRoot

cd cc65\src
msbuild /p:Configuration=Release .\cc65.sln

Pop-Location