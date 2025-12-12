# AI Snapshot System

This small package lets terminal AI agents (QuinnCode, Gemini CLI, Claude CLI, Cursor, etc.) "remember" project state by reading a single `BOOTSTRAP.txt` and writing snapshots to `snapshots/`.

## Files
- `BOOTSTRAP.txt` — master instruction file the AI reads first.
- `snapshots/` — directory where the AI will save JSON snapshots and summary text files.
- `setup.bat` — Windows setup script (creates snapshots folder and updates .gitignore).
- `setup.sh` — macOS/Linux setup script.

## Quick setup
1. Place `BOOTSTRAP.txt` in your project root.
2. Run `setup.bat` on Windows or `./setup.sh` on macOS/Linux to create the snapshots folder and add it to `.gitignore`.
3. Start your terminal AI, paste the system prompt (see below), then paste `BOOTSTRAP.txt`.
4. Ask the AI: `SNAPSHOT commit: "test snapshot" version: auto`. Inspect `snapshots/` for results.

## System prompt (paste into your CLI agent before BOOTSTRAP.txt)
```
SYSTEM: READ-ONLY BOOTSTRAP MODE. Parse BOOTSTRAP.txt exactly and DO NOT modify repo files while reading. After parsing, output JSON boot-report {"ready": true|false, "summary":"...", "observations":[], "questions":[]}.
When user says: SNAPSHOT commit: "<message>" version: "<ver|auto>", create snapshots/<ISO8601>.json and snapshots/<ISO8601>-summary.txt following the snapshot schema. Redact secrets; include safe rollback_plan with git commands only.
```

## Security
Do not store passwords or secrets in BOOTSTRAP.txt. Provide DB credentials interactively when needed and ensure snapshots redact sensitive values.

## License
MIT
