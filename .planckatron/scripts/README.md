# Planckatron Scripts

PowerShell scripts for validating, testing, and installing Planckatron.

## Scripts Overview

| Script | Purpose |
|--------|---------|
| `validate.ps1` | Validates Planckatron installation files |
| `install.ps1` | Installs Planckatron to a target project |
| `test.ps1` | Runs comprehensive self-tests |

---

## validate.ps1

Validates that all required Planckatron files exist and are properly formatted.

### Checks Performed

- **SKILL.md** - Exists and contains required Planckatron keywords
- **config.json** - Exists and is valid JSON with required keys
- **project-types.json** - Exists and is valid JSON
- **CLAUDE.md** - Exists in project root
- **Template files** - Checks for worker and orchestrator templates

### Usage

```powershell
# Run validation
.\validate.ps1

# Show help
.\validate.ps1 -Help
```

### Exit Codes

- `0` - All validations passed
- `1` - Errors found (missing or invalid files)

---

## install.ps1

Copies Planckatron to a target project directory.

### What Gets Installed

- `.planckatron/` - Complete configuration folder
- `CLAUDE.md` - Claude Code integration file
- `README.md` - (optional) Documentation

### Usage

```powershell
# Basic installation
.\install.ps1 -Target "C:\Projects\MyApp"

# Include README
.\install.ps1 -Target "C:\Projects\MyApp" -IncludeReadme

# Force overwrite existing installation
.\install.ps1 -Target "C:\Projects\MyApp" -Force

# Show help
.\install.ps1 -Help
```

### Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `-Target` | Yes | Target project directory |
| `-IncludeReadme` | No | Also copy README.md |
| `-Force` | No | Overwrite without prompting |
| `-Help` | No | Show help message |

### After Installation

1. Open the target project in Claude Code
2. Say "Planckatron" to activate
3. Describe what you want to build

---

## test.ps1

Comprehensive self-test suite for the Planckatron installation.

### Tests Performed

1. **Core Validation** - Runs validate.ps1
2. **Template Files** - Checks all worker templates exist
3. **State Management** - Verifies state directory and files
4. **Version Consistency** - Compares versions across files
5. **Script Files** - Confirms all scripts are present
6. **Configuration Structure** - Validates JSON schemas

### Usage

```powershell
# Run all tests
.\test.ps1

# Verbose output
.\test.ps1 -Verbose

# Show help
.\test.ps1 -Help
```

### Exit Codes

- `0` - All tests passed
- `1` - One or more tests failed

---

## Common Workflows

### Validate Before Use

```powershell
cd .planckatron\scripts
.\validate.ps1
```

### Full Health Check

```powershell
cd .planckatron\scripts
.\test.ps1 -Verbose
```

### Install to New Project

```powershell
cd .planckatron\scripts
.\install.ps1 -Target "C:\Projects\NewProject" -IncludeReadme
```

---

## Troubleshooting

### "Script not recognized"

Ensure you're running from PowerShell and the script has execution permissions:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "Missing required files"

Run validation to identify missing files:

```powershell
.\validate.ps1
```

### Version Mismatch Warning

If test.ps1 reports version mismatch, `config.json` is the authoritative source. Update other files to match.

---

## Cross-Platform Notes

These scripts are designed for Windows PowerShell but use standard PowerShell constructs that work with PowerShell Core (pwsh) on macOS and Linux.

For Unix-like systems:

```bash
pwsh -File validate.ps1
pwsh -File test.ps1
pwsh -File install.ps1 -Target "/home/user/projects/myapp"
```

---

## Part of Planckatron Universal

Quantum Multi-Agent Orchestration System
