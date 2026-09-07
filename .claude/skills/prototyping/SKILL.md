---
name: prototyping
description: Use when the user asks to build the smallest runnable, playable, testable or demonstrable version of an idea; a proof of concept, vertical slice, prototype, spike, MVP, or 'just make it work first'. Use after concept decisions are sufficiently clear.
---

# Prototyping

## Goal
Produce evidence quickly with the smallest implementation that tests the important uncertainty.

## Process
1. State the hypothesis the prototype must test.
2. Define a clear success condition.
3. Choose the smallest architecture and dependency set that can reach it.
4. Build one end-to-end path before adding breadth.
5. Use placeholders for art/content/infrastructure unless they are themselves under test.
6. Run the prototype.
7. Record what the prototype proves, disproves, and leaves unknown.

## Scope control
Do not add accounts, cloud infrastructure, persistence, analytics, generalized frameworks, elaborate settings, content pipelines or polish unless required by the hypothesis.

## Handoff
- Use `playtesting` to observe the result.
- Use `debugging` when runtime behavior is wrong.
- Use `code-review` only after the slice behaves correctly.
