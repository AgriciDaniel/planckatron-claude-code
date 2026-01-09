<#
.SYNOPSIS
    Runs self-tests on the Planckatron installation.

.DESCRIPTION
    Comprehensive self-test script that:
    - Runs validate.ps1 to check core files
    - Verifies all template files exist
    - Checks version consistency across files
    - Reports overall health status

.PARAMETER Help
    Displays this help message.

.PARAMETER Verbose
    Shows detailed output for all checks.

.EXAMPLE
    .\test.ps1
    Runs all self-tests.

.EXAMPLE
    .\test.ps1 -Verbose
    Runs all self-tests with detailed output.

.NOTES
    Part of Planckatron Universal - Quantum Multi-Agent Orchestration System
    Exit codes: 0 = all tests passed, 1 = tests failed
#>

param(
    [switch]$Help,
    [switch]$Verbose
)

# Display help if requested
if ($Help) {
    Get-Help $MyInvocation.MyCommand.Path -Detailed
    exit 0
}

# Configuration
$script:TestsPassed = 0
$script:TestsFailed = 0
$script:Versions = @{}

# Determine paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PlanckatronDir = Split-Path -Parent $ScriptDir
$ProjectRoot = Split-Path -Parent $PlanckatronDir

function Write-TestResult {
    param(
        [string]$TestName,
        [bool]$Passed,
        [string]$Details = ""
    )

    if ($Passed) {
        Write-Host "[PASS] " -ForegroundColor Green -NoNewline
        Write-Host $TestName
        $script:TestsPassed++
    }
    else {
        Write-Host "[FAIL] " -ForegroundColor Red -NoNewline
        Write-Host $TestName
        $script:TestsFailed++
    }

    if ($Details -and $Verbose) {
        Write-Host "       $Details" -ForegroundColor DarkGray
    }
}

function Write-Section {
    param([string]$Title)
    Write-Host ""
    Write-Host "--- $Title ---" -ForegroundColor Cyan
    Write-Host ""
}

function Get-VersionFromJson {
    param([string]$Path)

    try {
        $content = Get-Content -Path $Path -Raw | ConvertFrom-Json
        return $content.version
    }
    catch {
        return $null
    }
}

function Get-VersionFromMarkdown {
    param([string]$Path)

    try {
        $content = Get-Content -Path $Path -Raw

        # Try YAML frontmatter - version: "x.y.z" or version: x.y.z
        $yamlPattern = "version:\s*[`"']?([0-9]+\.[0-9]+\.[0-9]+)[`"']?"
        if ($content -match $yamlPattern) {
            return $matches[1]
        }

        # Try header pattern like "v3.0" or "v3.0.0"
        $headerPattern = "v([0-9]+\.[0-9]+(\.[0-9]+)?)"
        if ($content -match $headerPattern) {
            $version = $matches[1]
            # Normalize to x.y.z format
            if ($version -notmatch "^\d+\.\d+\.\d+$") {
                $version = "$version.0"
            }
            return $version
        }

        return $null
    }
    catch {
        return $null
    }
}

# Header
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  Planckatron Self-Test Suite" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "  Project: $ProjectRoot" -ForegroundColor DarkGray
Write-Host "  Time:    $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor DarkGray

# Test 1: Run validate.ps1
Write-Section "Core Validation"

$validateScript = Join-Path $ScriptDir "validate.ps1"
if (Test-Path $validateScript) {
    Write-Host "Running validate.ps1..." -ForegroundColor Gray

    # Capture validate output
    $validateOutput = & $validateScript 2>&1
    $validateExitCode = $LASTEXITCODE

    if ($Verbose) {
        $validateOutput | ForEach-Object { Write-Host "  $_" -ForegroundColor DarkGray }
    }

    Write-TestResult -TestName "Core validation (validate.ps1)" -Passed ($validateExitCode -eq 0)
}
else {
    Write-TestResult -TestName "validate.ps1 exists" -Passed $false -Details "Script not found"
}

# Test 2: Template files
Write-Section "Template Files"

$templateDir = Join-Path $PlanckatronDir "templates"
$requiredTemplates = @(
    "orchestrator-prompt.md",
    "worker-alpha.md",
    "worker-beta.md",
    "worker-gamma.md",
    "design-extractor.md"
)

foreach ($template in $requiredTemplates) {
    $templatePath = Join-Path $templateDir $template
    $exists = Test-Path $templatePath
    Write-TestResult -TestName "Template: $template" -Passed $exists -Details $templatePath
}

# Test 3: State directory
Write-Section "State Management"

$stateDir = Join-Path $PlanckatronDir "state"
$stateExists = Test-Path $stateDir
Write-TestResult -TestName "State directory exists" -Passed $stateExists -Details $stateDir

$currentState = Join-Path $stateDir "current.json"
if (Test-Path $currentState) {
    try {
        Get-Content -Path $currentState -Raw | ConvertFrom-Json | Out-Null
        Write-TestResult -TestName "current.json is valid JSON" -Passed $true
    }
    catch {
        Write-TestResult -TestName "current.json is valid JSON" -Passed $false -Details $_.Exception.Message
    }
}
else {
    Write-TestResult -TestName "current.json exists" -Passed $false -Details "File not found"
}

# Test 4: Version consistency
Write-Section "Version Consistency"

# Collect versions from different sources
$configPath = Join-Path $PlanckatronDir "config.json"
$skillPath = Join-Path $PlanckatronDir "SKILL.md"
$claudePath = Join-Path $ProjectRoot "CLAUDE.md"

$configVersion = Get-VersionFromJson -Path $configPath
$skillVersion = Get-VersionFromMarkdown -Path $skillPath
$claudeVersion = Get-VersionFromMarkdown -Path $claudePath

Write-Host "Detected versions:" -ForegroundColor Gray
if ($configVersion) {
    Write-Host "  config.json: $configVersion" -ForegroundColor DarkGray
    $script:Versions["config.json"] = $configVersion
}
if ($skillVersion) {
    Write-Host "  SKILL.md:    $skillVersion" -ForegroundColor DarkGray
    $script:Versions["SKILL.md"] = $skillVersion
}
if ($claudeVersion) {
    Write-Host "  CLAUDE.md:   $claudeVersion" -ForegroundColor DarkGray
    $script:Versions["CLAUDE.md"] = $claudeVersion
}

Write-Host ""

# Check if all versions match
$uniqueVersions = $script:Versions.Values | Select-Object -Unique
$versionsConsistent = ($uniqueVersions | Measure-Object).Count -le 1

if ($versionsConsistent) {
    $version = if ($configVersion) { $configVersion } else { "unknown" }
    Write-TestResult -TestName "Version consistency check" -Passed $true -Details "All files report version $version"
}
else {
    $versionList = ($script:Versions.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join ", "
    Write-TestResult -TestName "Version consistency check" -Passed $false -Details "Mismatch: $versionList"

    Write-Host ""
    Write-Host "  WARNING: Version mismatch detected!" -ForegroundColor Yellow
    Write-Host "  config.json is the authoritative source." -ForegroundColor Yellow
}

# Test 5: Script files
Write-Section "Script Files"

$scripts = @("validate.ps1", "install.ps1", "test.ps1")
foreach ($script in $scripts) {
    $scriptPath = Join-Path $ScriptDir $script
    $exists = Test-Path $scriptPath
    Write-TestResult -TestName "Script: $script" -Passed $exists -Details $scriptPath
}

# Test 6: JSON file structure
Write-Section "Configuration Structure"

# Check config.json structure
$configPath = Join-Path $PlanckatronDir "config.json"
try {
    $config = Get-Content -Path $configPath -Raw | ConvertFrom-Json

    $hasOrchestration = $null -ne $config.orchestration
    $hasTracks = $null -ne $config.tracks
    $hasProjectType = $null -ne $config.projectType

    Write-TestResult -TestName "config.json has orchestration section" -Passed $hasOrchestration
    Write-TestResult -TestName "config.json has tracks section" -Passed $hasTracks
    Write-TestResult -TestName "config.json has projectType section" -Passed $hasProjectType
}
catch {
    Write-TestResult -TestName "config.json structure" -Passed $false -Details $_.Exception.Message
}

# Check project-types.json
$projectTypesPath = Join-Path $PlanckatronDir "project-types.json"
try {
    $projectTypes = Get-Content -Path $projectTypesPath -Raw | ConvertFrom-Json
    $typeCount = ($projectTypes.PSObject.Properties | Measure-Object).Count
    $testMsg = "project-types.json loaded ($typeCount types)"
    Write-TestResult -TestName $testMsg -Passed ($typeCount -gt 0)
}
catch {
    Write-TestResult -TestName "project-types.json structure" -Passed $false -Details $_.Exception.Message
}

# Summary
Write-Host ""
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  Test Results" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""

$totalTests = $script:TestsPassed + $script:TestsFailed

Write-Host "  Total:  $totalTests tests" -ForegroundColor White
Write-Host "  Passed: $($script:TestsPassed)" -ForegroundColor Green
Write-Host "  Failed: $($script:TestsFailed)" -ForegroundColor $(if ($script:TestsFailed -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($script:TestsFailed -eq 0) {
    Write-Host "  +------------------------------------+" -ForegroundColor Green
    Write-Host "  |  ALL TESTS PASSED                  |" -ForegroundColor Green
    Write-Host "  |  Planckatron is healthy!           |" -ForegroundColor Green
    Write-Host "  +------------------------------------+" -ForegroundColor Green
    Write-Host ""
    exit 0
}
else {
    Write-Host "  +------------------------------------+" -ForegroundColor Red
    Write-Host "  |  SOME TESTS FAILED                 |" -ForegroundColor Red
    Write-Host "  |  Please review the issues above    |" -ForegroundColor Red
    Write-Host "  +------------------------------------+" -ForegroundColor Red
    Write-Host ""
    exit 1
}
