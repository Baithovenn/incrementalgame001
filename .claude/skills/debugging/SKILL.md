---
name: debugging
description: Use when there is a bug, crash, regression, error message, failing test, incorrect state, visual defect, gameplay problem, inconsistent behavior, or when the user says something does not work. Prefer evidence gathering over speculative fixes.
---

# Debugging

## Goal
Find the actual cause before changing code.

## Process
1. Reproduce the problem when possible.
2. Capture the smallest useful evidence: error, log, failing test, state, screenshot or exact behavior.
3. Separate symptom, trigger and likely subsystem.
4. Form a small number of hypotheses ranked by evidence.
5. Test the cheapest discriminating hypothesis first.
6. Make the smallest fix that addresses the cause.
7. Re-run the original reproduction plus relevant regression checks.
8. Explain the cause and evidence, not just the patch.

## Guardrails
- Do not shotgun-edit unrelated files.
- Do not silence errors unless the behavior is intentionally changed.
- Do not claim a fix without rerunning the reproduction when tools permit.

## Handoff
Use `playtesting` for interactive or visual confirmation.
