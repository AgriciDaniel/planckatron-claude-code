<#
.SYNOPSIS
    Validates Planckatron installation files.

.DESCRIPTION
    Checks that all required Planckatron files exist and are valid:
    - SKILL.md exists and contains required content
    - config.json exists and is valid JSON
    - project-types.json exists and is valid JSON
    - CLAUDE.md exists in project root

.PARAMETER Help
    Displays this help message.

.EXAMPLE
    .\validate.ps1
    Validates the Planckatron installation in the current directory.

.EXAMPLE
    .\validate.ps1 -Help
    Shows help information.

.NOTES
    Part of Planckatron Universal - Quantum Multi-Agent Orchestration System
    Exit codes: 0 = valid, 1 = errors found
#>

param(
    [switch]$Help
)

# Display help if requested
if ($Help) {
    Get-Help $MyInvocation.MyCommand.Path -Detailed
    exit 0
}

# Configuration
$script:ErrorCount = 0
$script:WarningCount = 0

# Determine paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PlanckatronDir = Split-Path -Parent $ScriptDir
$ProjectRoot = Split-Path -Parent $PlanckatronDir

# Required files relative to .planckatron directory
$RequiredFiles = @{
    "SKILL.md" = @{
        Path = Join-Path $PlanckatronDir "SKILL.md"
        Description = "Main skill definition file"
        ValidateContent = $true
        RequiredContent = @("Planckatron", "ALPHA", "BETA", "GAMMA")
    }
    "config.json" = @{
        Path = Join-Path $PlanckatronDir "config.json"
        Description = "Configuration file"
        ValidateJson = $true
        RequiredKeys = @("name", "version", "orchestration")
    }
    "project-types.json" = @{
        Path = Join-Path $PlanckatronDir "project-types.json"
        Description = "Project type definitions"
        ValidateJson = $true
    }
    "CLAUDE.md" = @{
        Path = Join-Path $ProjectRoot "CLAUDE.md"
        Description = "Claude Code instructions file"
        ValidateContent = $true
        RequiredContent = @("Planckatron")
    }
}

function Write-Status {
    param(
        [string]$Status,
        [string]$Message,
        [string]$Details = ""
    )

    $symbol = switch ($Status) {
        "OK"      { "[OK]" }
        "ERROR"   { "[ERROR]" }
        "WARNING" { "[WARN]" }
        "INFO"    { "[INFO]" }
        default   { "[?]" }
    }

    $color = switch ($Status) {
        "OK"      { "Green" }
        "ERROR"   { "Red" }
        "WARNING" { "Yellow" }
        "INFO"    { "Cyan" }
        default   { "White" }
    }

    Write-Host $symbol -ForegroundColor $color -NoNewline
    Write-Host " $Message"

    if ($Details) {
        Write-Host "     $Details" -ForegroundColor DarkGray
    }
}

function Test-JsonFile {
    param(
        [string]$Path,
        [string[]]$RequiredKeys = @()
    )

    try {
        $content = Get-Content -Path $Path -Raw -ErrorAction Stop
        $json = $content | ConvertFrom-Json -ErrorAction Stop

        # Check required keys if specified
        foreach ($key in $RequiredKeys) {
            if (-not ($json.PSObject.Properties.Name -contains $key)) {
                return @{
                    Valid = $false
                    Error = "Missing required key: $key"
                }
            }
        }

        return @{
            Valid = $true
            Data = $json
        }
    }
    catch {
        return @{
            Valid = $false
            Error = $_.Exception.Message
        }
    }
}

function Test-FileContent {
    param(
        [string]$Path,
        [string[]]$RequiredContent
    )

    try {
        $content = Get-Content -Path $Path -Raw -ErrorAction Stop
        $missing = @()

        foreach ($required in $RequiredContent) {
            if ($content -notmatch [regex]::Escape($required)) {
                $missing += $required
            }
        }

        if ($missing.Count -gt 0) {
            return @{
                Valid = $false
                Error = "Missing required content: $($missing -join ', ')"
            }
        }

        return @{ Valid = $true }
    }
    catch {
        return @{
            Valid = $false
            Error = $_.Exception.Message
        }
    }
}

# Header
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Planckatron Validation" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Project Root: $ProjectRoot" -ForegroundColor DarkGray
Write-Host "Planckatron Dir: $PlanckatronDir" -ForegroundColor DarkGray
Write-Host ""

# Check each required file
foreach ($fileName in $RequiredFiles.Keys) {
    $fileConfig = $RequiredFiles[$fileName]
    $filePath = $fileConfig.Path

    Write-Host "Checking $fileName..." -ForegroundColor White

    # Check if file exists
    if (-not (Test-Path $filePath)) {
        Write-Status -Status "ERROR" -Message "$fileName not found" -Details $filePath
        $script:ErrorCount++
        continue
    }

    Write-Status -Status "OK" -Message "$fileName exists"

    # Validate JSON if required
    if ($fileConfig.ValidateJson) {
        $result = Test-JsonFile -Path $filePath -RequiredKeys $fileConfig.RequiredKeys
        if ($result.Valid) {
            Write-Status -Status "OK" -Message "$fileName is valid JSON"

            # Show version if available
            if ($result.Data.version) {
                Write-Status -Status "INFO" -Message "Version: $($result.Data.version)"
            }
        }
        else {
            Write-Status -Status "ERROR" -Message "$fileName JSON validation failed" -Details $result.Error
            $script:ErrorCount++
        }
    }

    # Validate content if required
    if ($fileConfig.ValidateContent -and $fileConfig.RequiredContent) {
        $result = Test-FileContent -Path $filePath -RequiredContent $fileConfig.RequiredContent
        if ($result.Valid) {
            Write-Status -Status "OK" -Message "$fileName contains required content"
        }
        else {
            Write-Status -Status "ERROR" -Message "$fileName content validation failed" -Details $result.Error
            $script:ErrorCount++
        }
    }

    Write-Host ""
}

# Check for template files
Write-Host "Checking template files..." -ForegroundColor White
$templateDir = Join-Path $PlanckatronDir "templates"
$requiredTemplates = @("orchestrator-prompt.md", "worker-alpha.md", "worker-beta.md", "worker-gamma.md")

if (Test-Path $templateDir) {
    foreach ($template in $requiredTemplates) {
        $templatePath = Join-Path $templateDir $template
        if (Test-Path $templatePath) {
            Write-Status -Status "OK" -Message "Template: $template"
        }
        else {
            Write-Status -Status "WARNING" -Message "Template missing: $template"
            $script:WarningCount++
        }
    }
}
else {
    Write-Status -Status "WARNING" -Message "Templates directory not found"
    $script:WarningCount++
}

Write-Host ""

# Summary
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Validation Summary" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

if ($script:ErrorCount -eq 0 -and $script:WarningCount -eq 0) {
    Write-Host "  Status: ALL CHECKS PASSED" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Planckatron installation is valid." -ForegroundColor Green
    exit 0
}
elseif ($script:ErrorCount -eq 0) {
    Write-Host "  Status: PASSED WITH WARNINGS" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Errors:   0" -ForegroundColor Green
    Write-Host "  Warnings: $script:WarningCount" -ForegroundColor Yellow
    exit 0
}
else {
    Write-Host "  Status: VALIDATION FAILED" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Errors:   $script:ErrorCount" -ForegroundColor Red
    Write-Host "  Warnings: $script:WarningCount" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Please fix the errors above before using Planckatron." -ForegroundColor Red
    exit 1
}
