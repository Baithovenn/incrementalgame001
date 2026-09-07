---
name: code-review
description: Use when the user asks to review, inspect, clean up, simplify or assess implemented code, or after a meaningful completed slice when correctness, maintainability, duplication, architecture, security or regression risk should be checked. Do not use instead of runtime testing.
---

# Code Review

## Goal
Find material problems without manufacturing stylistic busywork.

## Review order
1. Correctness and broken behavior.
2. Data loss, security or destructive risks.
3. Missing validation and error handling.
4. Regression risks and inadequate tests.
5. Unnecessary complexity, coupling and duplication.
6. Naming/style only when it affects understanding or consistency.

## Output
For each finding include:
- severity: blocker / important / minor
- concrete location
- why it matters
- smallest reasonable fix

If there are no material findings, say so plainly.

## Guardrails
Do not propose rewrites merely because another architecture is fashionable. Existing working code has value.
