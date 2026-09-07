---
name: brainstorming
description: Use when the user has a new or underdefined software, game, feature, interaction, or product idea and wants to explore what should be built before implementation. Trigger on idea exploration, alternatives, requirements, scope, concept shaping, or 'I have an idea'. Do not use for a tiny already-specified edit.
---

# Brainstorming

## Goal
Turn an unclear idea into a small, testable direction without prematurely writing production code.

## Process
1. Inspect relevant existing project context first.
2. Identify the user's actual desired experience or outcome.
3. Ask at most one focused question at a time, and only when the answer materially changes the direction.
4. Offer 2-3 genuinely different approaches when there is a meaningful design choice.
5. State the strongest drawback of each approach, not just benefits.
6. Prefer reversible decisions and small scope.
7. End with a concrete proposed direction and the smallest useful next step.

## Handoff
- If the project is a game and mechanics need definition, also use `game-design`.
- If the direction is agreed and the user wants something runnable, hand off to `prototyping`.

## Guardrails
Do not create broad scaffolding, frameworks, databases, networking or elaborate architecture unless the chosen concept actually requires them.
