# Codex Agent Rules — CookFlow (non-negotiable)

## Truth / verification
- Never claim “added to Xcode target” unless you edited `*.xcodeproj/project.pbxproj` AND you show the diff.
- Never claim a command was run unless you paste full output.
- If unsure, say “unknown” and provide a verification step.

## Xcode safety
- DO NOT edit anything under `*.xcodeproj/` (including `project.pbxproj`).
- Do NOT create folder references (blue folders). Only “Create groups” instructions.

## Folder constraints
- Swift files ONLY in:
  - Shared/UI/
  - Shared/Purchases/
  - Shared/Models/
  - Features/Onboarding/
  - Features/Onboarding/Screens/
  - Features/Main/
  - Features/Home/
  - CookFlow/CookFlow/Shared/UI/
  - CookFlow/CookFlow/Shared/Auth/
  - CookFlow/CookFlow/Shared/Models/ (stores + models like CartStore, PlannerStore, Recipe types)
  - CookFlow/CookFlow/Features/Onboarding/
  - CookFlow/CookFlow/Features/Onboarding/Screens/
  - CookFlow/CookFlow/Features/Home/
  - CookFlow/CookFlow/Features/Search/
  - CookFlow/CookFlow/Features/Planner/
  - CookFlow/CookFlow/Features/Main/
  - CookFlow/CookFlow/Features/Cart/ (if you add a dedicated Cart screen)
  - CookFlow/CookFlow/Features/Menu/
  - JSON ONLY in:
  - Seed/
- No duplicate nesting like Features/Features or Shared/Shared.
- Do NOT create Components.swift (one component per file).

## UI constraints (v1)
- SF Pro only, fixed sizes. No `.scaleEffect()` on text, no geometry-based font scaling.
- Missing assets must not crash: always provide fallbacks.

## Required output for every ticket
1) Created/modified files (exact paths)
2) `git diff --stat`
3) Any commands run + full output
4) Manual Xcode steps: Target Membership checklist
