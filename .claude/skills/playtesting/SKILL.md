---
name: playtesting
description: Use when an interactive program or game must be run and observed to judge whether it actually works: controls, timing, collisions, layout, visual feedback, game state, responsiveness, console/runtime errors, or user flow. Use after implementation and alongside debugging for gameplay defects.
---

# Playtesting

## Goal
Evaluate the actual running product instead of inferring quality from source code alone.

## Process
1. Start the application/game in the closest available real environment.
2. Check startup/runtime errors before judging feel.
3. Exercise the exact path changed in the task.
4. Try at least one boundary or failure case.
5. Observe controls, feedback, timing, state transitions and visible defects.
6. Capture evidence using available screenshots, logs, state dumps or test output.
7. Compare behavior with the stated success condition.
8. If it fails, hand concrete evidence to `debugging` and repeat after the fix.

## Completion rule
For interactive work, passing compilation alone is not completion when runtime observation is available.
