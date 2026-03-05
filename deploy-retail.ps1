param(
    [string]$RetailAddOnsPath = "C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns"
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$target = Join-Path $RetailAddOnsPath "CleanPlates"

if (-not (Test-Path $RetailAddOnsPath)) {
    throw "Retail AddOns path not found: $RetailAddOnsPath"
}

New-Item -Path $target -ItemType Directory -Force | Out-Null

Copy-Item -Path (Join-Path $scriptDir "Core.lua") -Destination (Join-Path $target "Core.lua") -Force
Copy-Item -Path (Join-Path $scriptDir "Options.lua") -Destination (Join-Path $target "Options.lua") -Force
Copy-Item -Path (Join-Path $scriptDir "AceOptions.lua") -Destination (Join-Path $target "AceOptions.lua") -Force
Copy-Item -Path (Join-Path $scriptDir "CleanPlates_Mainline.toc") -Destination (Join-Path $target "CleanPlates.toc") -Force
Copy-Item -Path (Join-Path $scriptDir "libs") -Destination (Join-Path $target "libs") -Recurse -Force

Write-Host "Deployed CleanPlates to: $target"
