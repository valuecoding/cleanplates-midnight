param(
    [string]$OutputDir = "dist"
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$tocPath = Join-Path $scriptDir "CleanPlates_Mainline.toc"

if (-not (Test-Path $tocPath)) {
    throw "Missing file: $tocPath"
}

$versionLine = Select-String -Path $tocPath -Pattern '^## Version:\s*(.+)$' | Select-Object -First 1
if (-not $versionLine) {
    throw "Could not read version from CleanPlates_Mainline.toc"
}

$version = $versionLine.Matches[0].Groups[1].Value.Trim()
$distDir = Join-Path $scriptDir $OutputDir
$tmpRoot = Join-Path $distDir "_tmp_mainline"
$packageRoot = Join-Path $tmpRoot "CleanPlates"
$zipName = "CleanPlates-mainline-v$version.zip"
$zipPath = Join-Path $distDir $zipName

if (Test-Path $tmpRoot) {
    Remove-Item -Path $tmpRoot -Recurse -Force
}

New-Item -Path $packageRoot -ItemType Directory -Force | Out-Null
New-Item -Path $distDir -ItemType Directory -Force | Out-Null

Copy-Item -Path (Join-Path $scriptDir "Core.lua") -Destination (Join-Path $packageRoot "Core.lua") -Force
Copy-Item -Path (Join-Path $scriptDir "Options.lua") -Destination (Join-Path $packageRoot "Options.lua") -Force
Copy-Item -Path (Join-Path $scriptDir "AceOptions.lua") -Destination (Join-Path $packageRoot "AceOptions.lua") -Force
Copy-Item -Path (Join-Path $scriptDir "libs") -Destination (Join-Path $packageRoot "libs") -Recurse -Force

# Retail package should contain a plain addon TOC filename.
Copy-Item -Path $tocPath -Destination (Join-Path $packageRoot "CleanPlates.toc") -Force

if (Test-Path $zipPath) {
    Remove-Item -Path $zipPath -Force
}

Compress-Archive -Path (Join-Path $tmpRoot "*") -DestinationPath $zipPath -CompressionLevel Optimal
Remove-Item -Path $tmpRoot -Recurse -Force

Write-Host "Built: $zipPath"
