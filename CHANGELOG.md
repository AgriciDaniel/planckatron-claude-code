# Changelog

All notable changes to Planckatron Universal will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

```
                        ·  *  ·
                       ╭─────╮
                       │◉   ◉│
                       │ αβγ │
                       ╰─────╯
         Quantum Multi-Agent Evolution
```

---

## [3.0.0] - 2026-01-09

### Highlights

Version 3.0 introduces the **Hierarchical Architecture** with Team Leads, visual planning phases, and mini-agent support for maximum parallelization.

### Added

- **Team Lead System**: Dedicated ALPHA, BETA, and GAMMA team leads with specialized roles
  - ALPHA: Core architecture and infrastructure
  - BETA: Components, utilities, and shared modules
  - GAMMA: Pages, routes, and integration points
- **Visual Planning Phase**: ASCII-based visual representation of architecture before execution
- **Mini-Agent Support**: Each team lead can spawn focused sub-workers for granular tasks
- **Hierarchical Zone Ownership**: Clear file ownership with forbidden zone enforcement
- **Progress Tracking**: Real-time status reporting from each worker
- **Integration Phase**: Coordinated merge and conflict resolution
- **Professional Documentation**: CONTRIBUTING.md, CHANGELOG.md, and GitHub templates

### Changed

- Refactored SKILL.md with enhanced orchestration logic
- Improved project type detection with fallback to frontend
- Enhanced zone assignment tables for all project types
- Better error handling and conflict prevention

### Fixed

- Zone overlap issues in fullstack mode
- Worker communication bottlenecks
- Template variable substitution edge cases

---

## [2.1.0] - 2025-11-15

### Highlights

The **Universal Edition** expands Planckatron beyond frontend to support any project type with intelligent detection and adaptive zone assignments.

### Added

- **Universal Project Type Support**:
  - `frontend` - UI projects (React, Vue, Svelte, etc.)
  - `backend` - API projects (Express, FastAPI, etc.)
  - `fullstack` - Combined frontend and backend
  - `automation` - Scripts, CLI tools, pipelines
  - `agentic` - AI agents and LLM workflows
  - `library` - npm packages and SDKs
  - `monorepo` - Multi-package repositories
- **Auto-Detection**: Intelligent project type inference from codebase
- **Custom Zone Assignments**: User-specified file ownership patterns
- **Command Variations**: `Planckatron backend`, `Planckatron fullstack`, etc.
- **Adaptive Templates**: Project-type-specific worker behaviors

### Changed

- CLAUDE.md now serves as entry point with quick reference
- Zone assignment tables adapted per project type
- Worker roles dynamically assigned based on project needs
- Improved splash screen with version number

### Fixed

- Worker spawning race conditions
- File pattern matching for nested directories
- Documentation inconsistencies

---

## [2.0.0] - 2025-09-01

### Highlights

The **Initial Release** of Planckatron introduces quantum multi-agent orchestration for frontend projects, enabling parallel development with three coordinated workers.

### Added

- **Quantum Multi-Agent Orchestration**: Three parallel workers (ALPHA, BETA, GAMMA)
- **Exclusive Zone Ownership**: Each worker owns specific file patterns
- **Frontend Focus**: Optimized for React/Vue/Svelte projects
- **Core Workflow**: ANALYZE -> PLAN -> EXECUTE -> INTEGRATE
- **Splash Screen**: Visual activation with ASCII art
- **Zone Assignments**:
  - ALPHA: Layout components, global styles
  - BETA: UI components, data fetching, state
  - GAMMA: Pages, routing, integration
- **Conflict Prevention**: Workers cannot modify each other's zones
- **Progress Reporting**: Completion status from each worker

### Technical Details

- Claude Code skill format
- Markdown-based configuration
- Template-driven worker spawning
- Task-based parallel execution

---

## [1.0.0] - 2025-07-01 (Internal)

### Added

- Initial proof of concept
- Single-agent orchestration
- Basic file zone concept
- Frontend-only support

---

## Roadmap

### Planned for v3.1.0

- [ ] Real-time collaboration mode
- [ ] Worker communication protocol
- [ ] Automated testing integration
- [ ] Performance metrics dashboard

### Planned for v4.0.0

- [ ] Dynamic worker scaling (3-7 workers)
- [ ] Cross-project orchestration
- [ ] Plugin system for custom behaviors
- [ ] Visual Studio Code extension

---

## Version History Summary

| Version | Release Date | Codename |
|---------|--------------|----------|
| 3.0.0   | 2026-01-09   | Hierarchical |
| 2.1.0   | 2025-11-15   | Universal |
| 2.0.0   | 2025-09-01   | Genesis |
| 1.0.0   | 2025-07-01   | Prototype |

---

```
         ·  *  ·
        ╭─────╮
        │◉   ◉│
        │ αβγ │
        ╰─────╯
   Evolving quantum orchestration
```
