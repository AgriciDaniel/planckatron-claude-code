<#
.SYNOPSIS
    Planckatron - Quantum Multi-Agent Orchestration for Claude Code
.DESCRIPTION
    Displays the Planckatron splash screen and provides quick start instructions.
.EXAMPLE
    .\planckatron.ps1
    .\planckatron.ps1 -Help
#>

param(
    [switch]$Help,
    [switch]$Ver
)

$script:appVersion = "3.0.0"

# Colors
$accentColor = "Cyan"
$textColor = "White"
$mutedColor = "DarkGray"

function Show-Splash {
    Clear-Host
    Write-Host ""
    Write-Host "-- Planckatron v$appVersion ----------------------------------------------" -ForegroundColor $accentColor
    Write-Host ""
    Write-Host "                        .  *  ." -ForegroundColor $mutedColor
    Write-Host "                       +-----+" -ForegroundColor $accentColor
    Write-Host "                       |" -ForegroundColor $accentColor -NoNewline
    Write-Host " o o " -ForegroundColor $textColor -NoNewline
    Write-Host "|" -ForegroundColor $accentColor
    Write-Host "                       |" -ForegroundColor $accentColor -NoNewline
    Write-Host " ABG " -ForegroundColor Yellow -NoNewline
    Write-Host "|" -ForegroundColor $accentColor
    Write-Host "                       +-----+" -ForegroundColor $accentColor
    Write-Host ""
    Write-Host "         Quantum Multi-Agent Orchestration " -ForegroundColor $textColor -NoNewline
    Write-Host "Active" -ForegroundColor Green
    Write-Host ""
    Write-Host "--------------------------------------------------------------------" -ForegroundColor $accentColor
    Write-Host ""
}

function Show-Help {
    Show-Splash
    Write-Host "  QUICK START" -ForegroundColor Yellow
    Write-Host "  -----------" -ForegroundColor $mutedColor
    Write-Host ""
    Write-Host "  1. Open Claude Code in your project" -ForegroundColor $textColor
    Write-Host "  2. Copy the prompt from:" -ForegroundColor $textColor
    Write-Host "     .planckatron/templates/orchestrator-prompt.md" -ForegroundColor $accentColor
    Write-Host "  3. Paste it into Claude Code" -ForegroundColor $textColor
    Write-Host "  4. Describe what you want to build" -ForegroundColor $textColor
    Write-Host ""
    Write-Host "  OR simply say:" -ForegroundColor $textColor
    Write-Host "     'Act as Planckatron and build me [feature]'" -ForegroundColor Green
    Write-Host ""
    Write-Host "  WORKERS" -ForegroundColor Yellow
    Write-Host "  -------" -ForegroundColor $mutedColor
    Write-Host ""
    Write-Host "  [A] ALPHA    Foundation - layout, styles, config" -ForegroundColor Cyan
    Write-Host "  [B] BETA     Components - UI, data, hooks" -ForegroundColor Cyan
    Write-Host "  [G] GAMMA    Integration - pages, assembly" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  LINKS" -ForegroundColor Yellow
    Write-Host "  -----" -ForegroundColor $mutedColor
    Write-Host ""
    Write-Host "  GitHub: " -ForegroundColor $textColor -NoNewline
    Write-Host "github.com/AgriciDaniel/quantum-planckatron" -ForegroundColor $accentColor
    Write-Host ""
    Write-Host "--------------------------------------------------------------------" -ForegroundColor $accentColor
    Write-Host ""
}

function Show-Version {
    Write-Host "Planckatron v$appVersion" -ForegroundColor $accentColor
}

# Main
if ($Ver) {
    Show-Version
} elseif ($Help) {
    Show-Help
} else {
    Show-Help
}
