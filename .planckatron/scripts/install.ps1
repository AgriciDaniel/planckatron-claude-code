<#
.SYNOPSIS
    Installs Planckatron to a target project.

.DESCRIPTION
    Copies the Planckatron orchestration system to a target project directory.
    This includes:
    - .planckatron folder with all configuration and templates
    - CLAUDE.md file for Claude Code integration
    - Optionally, the README.md documentation

.PARAMETER Target
    The target project directory where Planckatron will be installed.
    This parameter is required.

.PARAMETER IncludeReadme
    If specified, also copies the README.md file to the target project.

.PARAMETER Force
    If specified, overwrites existing Planckatron installation without prompting.

.PARAMETER Help
    Displays this help message.

.EXAMPLE
    .\install.ps1 -Target "C:\Projects\MyApp"
    Installs Planckatron to the MyApp project.

.EXAMPLE
    .\install.ps1 -Target "C:\Projects\MyApp" -IncludeReadme
    Installs Planckatron with README to the MyApp project.

.EXAMPLE
    .\install.ps1 -Target "C:\Projects\MyApp" -Force
    Installs Planckatron, overwriting any existing installation.

.NOTES
    Part of Planckatron Universal - Quantum Multi-Agent Orchestration System
#>

param(
    [Parameter(Mandatory=$false)]
    [string]$Target,

    [switch]$IncludeReadme,
    [switch]$Force,
    [switch]$Help
)

# Display help if requested or no target provided
if ($Help) {
    Get-Help $MyInvocation.MyCommand.Path -Detailed
    exit 0
}

if (-not $Target) {
    Write-Host ""
    Write-Host "ERROR: Target directory is required." -ForegroundColor Red
    Write-Host ""
    Write-Host "Usage: .\install.ps1 -Target ""C:\path\to\project""" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Run '.\install.ps1 -Help' for more information." -ForegroundColor Gray
    exit 1
}

# Determine source paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PlanckatronDir = Split-Path -Parent $ScriptDir
$SourceRoot = Split-Path -Parent $PlanckatronDir

# Source files/directories
$SourcePlanckatron = $PlanckatronDir
$SourceClaudeMd = Join-Path $SourceRoot "CLAUDE.md"
$SourceReadme = Join-Path $SourceRoot "README.md"

# Target paths
$TargetPlanckatron = Join-Path $Target ".planckatron"
$TargetClaudeMd = Join-Path $Target "CLAUDE.md"
$TargetReadme = Join-Path $Target "README.md"

function Write-Status {
    param(
        [string]$Status,
        [string]$Message
    )

    $symbol = switch ($Status) {
        "OK"      { "[OK]" }
        "ERROR"   { "[ERROR]" }
        "COPY"    { "[COPY]" }
        "SKIP"    { "[SKIP]" }
        "INFO"    { "[INFO]" }
        default   { "[?]" }
    }

    $color = switch ($Status) {
        "OK"      { "Green" }
        "ERROR"   { "Red" }
        "COPY"    { "Cyan" }
        "SKIP"    { "Yellow" }
        "INFO"    { "Gray" }
        default   { "White" }
    }

    Write-Host $symbol -ForegroundColor $color -NoNewline
    Write-Host " $Message"
}

# Header
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Planckatron Installer" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Validate source
Write-Host "Validating source installation..." -ForegroundColor White
Write-Host ""

if (-not (Test-Path $SourcePlanckatron)) {
    Write-Status -Status "ERROR" -Message "Source .planckatron directory not found"
    Write-Host "  Expected: $SourcePlanckatron" -ForegroundColor DarkGray
    exit 1
}

if (-not (Test-Path $SourceClaudeMd)) {
    Write-Status -Status "ERROR" -Message "Source CLAUDE.md not found"
    Write-Host "  Expected: $SourceClaudeMd" -ForegroundColor DarkGray
    exit 1
}

Write-Status -Status "OK" -Message "Source installation valid"
Write-Host ""

# Validate target
Write-Host "Validating target directory..." -ForegroundColor White
Write-Host ""

# Resolve target path (handle relative paths)
$Target = [System.IO.Path]::GetFullPath($Target)

if (-not (Test-Path $Target)) {
    Write-Host "Target directory does not exist: $Target" -ForegroundColor Yellow
    $createDir = Read-Host "Create it? (y/n)"
    if ($createDir -eq 'y' -or $createDir -eq 'Y') {
        try {
            New-Item -ItemType Directory -Path $Target -Force | Out-Null
            Write-Status -Status "OK" -Message "Created target directory"
        }
        catch {
            Write-Status -Status "ERROR" -Message "Failed to create target directory"
            Write-Host "  $($_.Exception.Message)" -ForegroundColor DarkGray
            exit 1
        }
    }
    else {
        Write-Host "Installation cancelled." -ForegroundColor Yellow
        exit 0
    }
}

Write-Status -Status "OK" -Message "Target: $Target"
Write-Host ""

# Check for existing installation
if ((Test-Path $TargetPlanckatron) -or (Test-Path $TargetClaudeMd)) {
    if (-not $Force) {
        Write-Host "Existing Planckatron installation detected!" -ForegroundColor Yellow
        Write-Host ""
        if (Test-Path $TargetPlanckatron) {
            Write-Host "  - .planckatron folder exists" -ForegroundColor DarkGray
        }
        if (Test-Path $TargetClaudeMd) {
            Write-Host "  - CLAUDE.md exists" -ForegroundColor DarkGray
        }
        Write-Host ""
        $overwrite = Read-Host "Overwrite existing installation? (y/n)"
        if ($overwrite -ne 'y' -and $overwrite -ne 'Y') {
            Write-Host "Installation cancelled." -ForegroundColor Yellow
            exit 0
        }
    }

    # Remove existing installation
    if (Test-Path $TargetPlanckatron) {
        Remove-Item -Path $TargetPlanckatron -Recurse -Force
        Write-Status -Status "INFO" -Message "Removed existing .planckatron"
    }
    if (Test-Path $TargetClaudeMd) {
        Remove-Item -Path $TargetClaudeMd -Force
        Write-Status -Status "INFO" -Message "Removed existing CLAUDE.md"
    }
    Write-Host ""
}

# Install
Write-Host "Installing Planckatron..." -ForegroundColor White
Write-Host ""

$success = $true

# Copy .planckatron directory
try {
    Copy-Item -Path $SourcePlanckatron -Destination $TargetPlanckatron -Recurse -Force
    Write-Status -Status "COPY" -Message ".planckatron/ -> $TargetPlanckatron"
}
catch {
    Write-Status -Status "ERROR" -Message "Failed to copy .planckatron"
    Write-Host "  $($_.Exception.Message)" -ForegroundColor DarkGray
    $success = $false
}

# Copy CLAUDE.md
try {
    Copy-Item -Path $SourceClaudeMd -Destination $TargetClaudeMd -Force
    Write-Status -Status "COPY" -Message "CLAUDE.md -> $TargetClaudeMd"
}
catch {
    Write-Status -Status "ERROR" -Message "Failed to copy CLAUDE.md"
    Write-Host "  $($_.Exception.Message)" -ForegroundColor DarkGray
    $success = $false
}

# Copy README.md if requested
if ($IncludeReadme) {
    if (Test-Path $SourceReadme) {
        try {
            Copy-Item -Path $SourceReadme -Destination $TargetReadme -Force
            Write-Status -Status "COPY" -Message "README.md -> $TargetReadme"
        }
        catch {
            Write-Status -Status "ERROR" -Message "Failed to copy README.md"
            Write-Host "  $($_.Exception.Message)" -ForegroundColor DarkGray
        }
    }
    else {
        Write-Status -Status "SKIP" -Message "README.md not found in source"
    }
}

Write-Host ""

# Result
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Installation Complete" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

if ($success) {
    Write-Host "  Planckatron has been installed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Target: $Target" -ForegroundColor White
    Write-Host ""
    Write-Host "  NEXT STEPS:" -ForegroundColor Cyan
    Write-Host "  1. Open the project in Claude Code" -ForegroundColor White
    Write-Host "  2. Say 'Planckatron' to activate" -ForegroundColor White
    Write-Host "  3. Describe what you want to build" -ForegroundColor White
    Write-Host ""
    Write-Host "  Available commands:" -ForegroundColor Gray
    Write-Host "    Planckatron           - Auto-detect project type" -ForegroundColor DarkGray
    Write-Host "    Planckatron frontend  - Frontend UI project" -ForegroundColor DarkGray
    Write-Host "    Planckatron backend   - Backend API project" -ForegroundColor DarkGray
    Write-Host "    Planckatron fullstack - Full-stack application" -ForegroundColor DarkGray
    Write-Host ""
    exit 0
}
else {
    Write-Host "  Installation completed with errors." -ForegroundColor Red
    Write-Host "  Please check the messages above and try again." -ForegroundColor Yellow
    Write-Host ""
    exit 1
}
