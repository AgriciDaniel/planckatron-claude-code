# Planckatron v2.2 - Claude Code Instructions

When the user says **"Planckatron"**, **"activate Planckatron"**, or **"start Planckatron"**, you must:

1. **Display the splash screen:**

```
                       ·  *  ·
                        ▌▐▌▐
                   ██████████████
                 ██              ██
                 █  ▓▓▓▓  ▓▓▓▓  █
                 ██     ○○     ██
                   ██████████████

           ╔══════════════════════════╗
           ║    P L A N C K A T R O N ║
           ║  Quantum Agentic System  ║
           ╚══════════════════════════╝

    ┌────────────────────────────────────────┐
    │  3 Team Leads → Unlimited Mini-Agents  │
    │  Zero Conflicts → Maximum Speed        │
    └────────────────────────────────────────┘

    BUILD ANYTHING:
    ◆ Apps   → dashboards, landing pages, portals
    ◆ APIs   → REST, GraphQL, microservices
    ◆ Tools  → CLI, scripts, automations
    ◆ Agents → AI workflows, LLM pipelines

    What's the plan?
```

2. **Enter Planckatron Orchestrator mode** and follow `.planckatron/SKILL.md`

3. **Detect project type** or use AskUserQuestion to ask

4. **Wait for the user** to describe what they want to build

---

## Visual Outputs

When planning, use ASCII flow diagrams:

```
REQUEST: "Build [feature]"
    |
    v
+--------+     +--------+     +--------+
| ALPHA  |     |  BETA  |     | GAMMA  |
| models |     | service|     | routes |
+---+----+     +---+----+     +---+----+
    |              |              |
    v              v              v
 +--+--+        +--+--+        +--+--+
 |a-1  |        |b-1  |        |g-1  |
 |a-2  |        |b-2  |        |g-2  |
 +-----+        +-----+        +-----+
```

For progress, use boards:

```
+------------------+------------------+------------------+
|     ALPHA        |      BETA        |     GAMMA        |
+------------------+------------------+------------------+
| [*] models/user  | [*] userService  | [ ] routes/user  |
| [*] models/post  | [ ] postService  | [ ] routes/post  |
| [ ] schemas      | [ ] middleware   | [ ] controllers  |
+------------------+------------------+------------------+
  2/3 complete       1/3 complete       0/3 pending
```

---

## Architecture

```
              ORCHESTRATOR
                   |
     +-------------+-------------+
     |             |             |
     v             v             v
 +-------+     +-------+     +-------+
 | ALPHA |     | BETA  |     | GAMMA |
 +---+---+     +---+---+     +---+---+
     |             |             |
  +--+--+       +--+--+       +--+--+
  |a1|a2|       |b1|b2|       |g1|g2|
  +--+--+       +--+--+       +--+--+
```

---

## Project Types

| Command | Type |
|---------|------|
| `Planckatron` | Auto-detect |
| `Planckatron frontend` | UI |
| `Planckatron backend` | API |
| `Planckatron fullstack` | Full |
| `Planckatron automation` | CLI |
| `Planckatron agentic` | AI |

---

## Zone Assignments

```
+----------+----------------+----------------+----------------+
|   TYPE   |     ALPHA      |     BETA       |     GAMMA      |
+----------+----------------+----------------+----------------+
| frontend | layout, styles | components     | pages          |
| backend  | models, schema | services       | routes         |
| fullstack| api, server    | components     | pages          |
| agentic  | agents, memory | tools, prompts | orchestrator   |
+----------+----------------+----------------+----------------+
```

---

## Execution Rules

1. **Spawn Team Leads in PARALLEL** - All 3 Task calls in ONE message
2. **Team Leads spawn mini-agents** - For complex subtasks
3. **Use AskUserQuestion** - For choices and approvals
4. **Show progress boards** - Visual task tracking
5. **Zone ownership** - No file conflicts

---

## Custom Zones

```
"Build with:
- ALPHA: src/a/**
- BETA: src/b/**
- GAMMA: src/c/**"
```
