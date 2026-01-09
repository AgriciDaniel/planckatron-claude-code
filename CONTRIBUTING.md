# Contributing to Planckatron Universal

```
                        ·  *  ·
                       ╭─────╮
                       │◉   ◉│
                       │ αβγ │
                       ╰─────╯
```

Thank you for your interest in contributing to Planckatron Universal! This document provides guidelines and instructions for contributing to this quantum multi-agent orchestration system.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Pull Request Guidelines](#pull-request-guidelines)
- [Code Style](#code-style)
- [Adding New Project Types](#adding-new-project-types)
- [Modifying Worker Templates](#modifying-worker-templates)

---

## Code of Conduct

We are committed to providing a welcoming and inclusive experience for everyone. Please be respectful and constructive in all interactions.

---

## Getting Started

Planckatron Universal is a Claude Code skill that enables quantum multi-agent orchestration. Before contributing, familiarize yourself with:

1. **CLAUDE.md** - Entry point and quick reference
2. **.planckatron/SKILL.md** - Core orchestration logic
3. **.planckatron/templates/** - Worker templates for different project types

---

## Development Setup

### Prerequisites

- Claude Code CLI installed
- Git for version control
- A text editor with Markdown support

### Local Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/your-org/planckatron-universal.git
   cd planckatron-universal
   ```

2. Review the directory structure:
   ```
   .
   ├── CLAUDE.md                 # Entry point
   ├── .planckatron/
   │   ├── SKILL.md              # Core orchestration
   │   ├── templates/            # Worker templates
   │   └── scripts/              # Utility scripts
   └── .github/                  # GitHub templates
   ```

3. Test your changes by activating Planckatron in Claude Code:
   ```
   Planckatron
   ```

---

## How to Contribute

### Reporting Bugs

1. Check existing issues to avoid duplicates
2. Use the [bug report template](.github/ISSUE_TEMPLATE/bug_report.md)
3. Include your Planckatron version, project type, and reproduction steps

### Suggesting Features

1. Use the [feature request template](.github/ISSUE_TEMPLATE/feature_request.md)
2. Explain the use case and proposed implementation
3. Indicate which project types would benefit

### Contributing Code

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes following the code style guidelines
4. Test thoroughly with different project types
5. Submit a pull request

---

## Pull Request Guidelines

### Before Submitting

- [ ] Test with at least 2 different project types
- [ ] Update documentation if needed
- [ ] Follow the markdown formatting guidelines
- [ ] Ensure no conflicts with existing zone assignments

### PR Title Format

Use conventional commit style:
- `feat: add new project type for mobile apps`
- `fix: resolve zone conflict in fullstack mode`
- `docs: update contributing guidelines`
- `refactor: simplify worker spawning logic`

### PR Description

Use the [pull request template](.github/PULL_REQUEST_TEMPLATE.md) and include:
- Clear description of changes
- Type of change (feature, bugfix, docs, etc.)
- Testing performed
- Screenshots if applicable

---

## Code Style

### Markdown Formatting

All Planckatron files use Markdown. Follow these conventions:

1. **Headers**: Use ATX-style headers (`#`, `##`, `###`)
2. **Code Blocks**: Use fenced code blocks with language identifiers
   ````markdown
   ```javascript
   const example = "code";
   ```
   ````
3. **Tables**: Align columns for readability
   ```markdown
   | Column 1 | Column 2 | Column 3 |
   |----------|----------|----------|
   | Value 1  | Value 2  | Value 3  |
   ```
4. **Lists**: Use `-` for unordered lists, `1.` for ordered lists
5. **Line Length**: Wrap at 80 characters when possible
6. **ASCII Art**: Preserve exact spacing for visual elements

### Template Variables

Use consistent placeholder syntax:
- `{{PROJECT_PATH}}` - Absolute project path
- `{{PROJECT_TYPE}}` - Detected or specified type
- `{{WORKER_ID}}` - ALPHA, BETA, or GAMMA
- `{{ZONE_FILES}}` - Glob patterns for file ownership

---

## Adding New Project Types

To add a new project type (e.g., `mobile`):

### Step 1: Update CLAUDE.md

Add the new type to the command table:
```markdown
| `Planckatron mobile` | Mobile app project |
```

### Step 2: Update SKILL.md

Add zone assignments in the project type section:
```markdown
### mobile
- **ALPHA**: screens/, navigation/
- **BETA**: components/, hooks/, services/
- **GAMMA**: assets/, config/, utils/
```

### Step 3: Create Worker Templates (if needed)

If the project type requires specialized worker behavior, create templates:
```
.planckatron/templates/mobile/
├── ALPHA.md
├── BETA.md
└── GAMMA.md
```

### Step 4: Test Thoroughly

1. Activate with: `Planckatron mobile`
2. Verify zone detection works correctly
3. Test worker spawning with a sample project
4. Ensure no zone conflicts

### Step 5: Document

Update the README with:
- New project type description
- Recommended use cases
- Zone assignment explanation

---

## Modifying Worker Templates

Worker templates define how ALPHA, BETA, and GAMMA behave for each project type.

### Template Location

```
.planckatron/templates/{{project_type}}/
├── ALPHA.md    # First worker template
├── BETA.md     # Second worker template
└── GAMMA.md    # Third worker template
```

### Template Structure

Each template should include:

```markdown
# Worker {{WORKER_ID}} - {{ROLE_NAME}}

PROJECT: {{PROJECT_PATH}}
TYPE: {{PROJECT_TYPE}}

YOUR ZONE (files you OWN):
- pattern1/**
- pattern2/**

FORBIDDEN (other teams own):
- other-pattern/**

YOUR TASKS:
1. Task description
2. Task description

STANDARDS:
- Code style requirements
- Quality expectations

WHEN DONE: Report completion status
```

### Best Practices

1. **Clear Zone Boundaries**: Ensure no overlap between workers
2. **Specific Tasks**: Define concrete, actionable tasks
3. **Standards**: Include relevant quality requirements
4. **Completion Criteria**: Define what "done" means

### Testing Template Changes

1. Modify the template
2. Activate Planckatron with the relevant project type
3. Spawn workers and verify behavior
4. Check for zone conflicts or unclear instructions

---

## Questions?

If you have questions about contributing:

1. Check existing documentation
2. Open a discussion issue
3. Reach out to maintainers

We appreciate your contributions to making Planckatron Universal better!

```
         ·  *  ·
        ╭─────╮
        │◉   ◉│
        │ αβγ │
        ╰─────╯
   Thank you for contributing!
```
