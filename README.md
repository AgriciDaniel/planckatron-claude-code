# Planckatron

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
```

**Hierarchical Multi-Agent Orchestration System (v3.0)**

Build ANY project faster with parallel AI agents that never conflict.

---

## What's New in v3.0

```
+----------------------+---------------------------------------------+
|       FEATURE        |               DESCRIPTION                   |
+----------------------+---------------------------------------------+
| Hierarchical Agents  | Orchestrator -> Team Leads -> Mini-Agents   |
| Visual Planning      | ASCII flow diagrams for plans               |
| Progress Boards      | Miro-style task tracking                    |
| Parallel Execution   | All agents run simultaneously               |
| AskUserQuestion      | Native Claude Code suggestions              |
| Robustness           | Retry logic, validation gates               |
+----------------------+---------------------------------------------+
```

---

## Architecture

```
              ORCHESTRATOR (Claude)
                     |
       +-------------+-------------+
       |             |             |
       v             v             v
   +-------+     +-------+     +-------+
   | ALPHA |     | BETA  |     | GAMMA |
   | Lead  |     | Lead  |     | Lead  |
   +---+---+     +---+---+     +---+---+
       |             |             |
    +--+--+       +--+--+       +--+--+
    |a1|a2|       |b1|b2|       |g1|g2|
    +--+--+       +--+--+       +--+--+
     mini          mini          mini
    agents        agents        agents
```

**Key:** Team Leads analyze tasks and spawn mini-agents. Maximum parallelism.

---

## Visual Planning

When you use Planckatron, you get visual flow diagrams:

```
+==============================================================+
|                    QUANTUM PLAN v3.0                         |
+==============================================================+
|  Request: "Build user authentication"                        |
|  Type: backend            Stack: Node.js + Express           |
+==============================================================+

REQUEST: "Build user auth"
              |
              v
+-------------+-------------+-------------+
|             |             |             |
v             v             v             v
+--------+  +--------+  +--------+
| ALPHA  |  |  BETA  |  | GAMMA  |
| models |  | service|  | routes |
+--------+  +--------+  +--------+
    |           |           |
    v           v           v
 [a-1,a-2]   [b-1]      [g-1,g-2]

+==============================================================+
|  Mode: PARALLEL          Est. Agents: 8                      |
+==============================================================+
```

---

## Progress Boards

Real-time task tracking:

```
+------------------+------------------+------------------+
|      ALPHA       |       BETA       |      GAMMA       |
+------------------+------------------+------------------+
| Status: WORKING  | Status: WORKING  | Status: PENDING  |
+------------------+------------------+------------------+
| [*] models/user  | [*] userService  | [ ] routes/user  |
| [*] models/post  | [ ] postService  | [ ] routes/post  |
| [ ] schemas      | [ ] middleware   | [ ] controllers  |
+------------------+------------------+------------------+
| Mini-agents: 2   | Mini-agents: 1   | Mini-agents: 0   |
+------------------+------------------+------------------+

Progress: [=========>          ] 45%
```

---

## Project Types

```
+-------------+------------------+------------------+------------------+
|    TYPE     |      ALPHA       |       BETA       |      GAMMA       |
+-------------+------------------+------------------+------------------+
| frontend    | layout, styles   | components       | pages            |
| backend     | models, schemas  | services, utils  | routes, ctrl     |
| fullstack   | api, server      | components       | pages            |
| automation  | scripts, core    | utils, config    | cli, entry       |
| agentic     | agents, memory   | tools, prompts   | orchestrator     |
| library     | core, lib        | types, utils     | exports          |
| monorepo    | packages/shared  | packages/ui      | apps/**          |
+-------------+------------------+------------------+------------------+
```

---

## Quick Start

```
+-------------------------+
|      Just say:          |
|                         |
|      "Planckatron"      |
|                         |
+-------------------------+
         |
         v
+-------------------------+
|   Splash screen shows   |
|   Describe your feature |
+-------------------------+
         |
         v
+-------------------------+
|   Visual plan created   |
|   Approve to execute    |
+-------------------------+
         |
         v
+-------------------------+
|   Agents spawn          |
|   Progress board shows  |
+-------------------------+
         |
         v
+-------------------------+
|   Complete!             |
|   Quality checks pass   |
+-------------------------+
```

---

## Execution Flow

```
TIMELINE:
=========

T0: Orchestrator spawns Team Leads (parallel)
    |
    +---> ALPHA ---> analyzes ---> spawns a-1, a-2
    +---> BETA  ---> analyzes ---> spawns b-1
    +---> GAMMA ---> analyzes ---> executes directly
    |
T1: All mini-agents working in parallel
    |
    +---> a-1: creates models/user.ts
    +---> a-2: creates models/post.ts
    +---> b-1: creates services/user.ts
    +---> GAMMA: creates routes/index.ts
    |
T2: Mini-agents complete
    |
T3: Team Leads report
    |
T4: Integration & quality checks
```

---

## Completion Report

```
+==============================================================+
|               PLANCKATRON COMPLETE                           |
+==============================================================+

Type: backend

+------------------+------------------+------------------+
|      ALPHA       |       BETA       |      GAMMA       |
+------------------+------------------+------------------+
| [*] COMPLETE     | [*] COMPLETE     | [*] COMPLETE     |
| 3 files          | 2 files          | 3 files          |
| 2 mini-agents    | 1 mini-agent     | 0 mini-agents    |
+------------------+------------------+------------------+

TOTALS:
+------------------------------------------+
| Files created:    8                      |
| Agents spawned:   6 (3 leads + 3 mini)   |
| Quality checks:   PASSED                 |
+------------------------------------------+

+==============================================================+
```

---

## Robustness

```
RETRY FLOW:                      VALIDATION GATES:

Agent Failed                     +---------+     +---------+
     |                           | Agent   | --> | Check   |
     v                           | done?   |     | files   |
+----+----+                      +---------+     +---------+
| Retry 1 | --> Success?              |              |
+----+----+                           v              v
     |                           +---------+    +---------+
     v                           | Valid?  |--->| Continue|
+----+----+                      +---------+    +---------+
| Retry 2 | --> Success?              |
+----+----+                           v
     |                           +---------+
     v                           | Fix     |
  Report                         | Agent   |
                                 +---------+
```

---

## Commands

```
+-------------------------+---------------------------+
|       COMMAND           |        DESCRIPTION        |
+-------------------------+---------------------------+
| Planckatron             | Start (auto-detect type)  |
| Planckatron backend     | Start with backend type   |
| Planckatron frontend    | Start with frontend type  |
| Planckatron fullstack   | Start with fullstack type |
| Planckatron agentic     | Start with agentic type   |
| Planckatron status      | Show current progress     |
| Planckatron resume      | Resume interrupted build  |
+-------------------------+---------------------------+
```

---

## Directory Structure

```
your-project/
+-- .planckatron/
|   +-- SKILL.md           # v3.0 skill definition
|   +-- templates/         # Worker templates
|
+-- CLAUDE.md              # Activation trigger
```

---

## Requirements

- Claude Code CLI or VS Code extension
- Node.js 18+ (for quality checks)

---

## Version History

```
+----------+-----------------------------+
| VERSION  |         FEATURES            |
+----------+-----------------------------+
| v3.0.0   | Hierarchical + Visual       |
| v2.1.0   | Universal Edition           |
| v2.0.0   | Frontend Edition            |
+----------+-----------------------------+
```

---

## License

MIT

---

## Credits

Created by Daniel Agrici

```
     "More agents, more speed, zero conflicts."
              - Planckatron v3.0
```

**GitHub:** https://github.com/AgriciDaniel/planckatron-claude-code
