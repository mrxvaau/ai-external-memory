# AI Snapshot System

The **AI Snapshot System** enables terminal-based AI agents (QuinnCode,
Gemini CLI, Claude CLI, Cursor, etc.) to *persist project state* by
reading a single `BOOTSTRAP.txt` file and writing structured snapshots
to the `snapshots/` directory.

This system provides a simple, secure, and repo-friendly way for AI
agents to maintain context across sessions without modifying project
files directly.

## Features

-   **Single-source project instructions** via `BOOTSTRAP.txt`.
-   **Automatic snapshot generation** in `snapshots/` (JSON + text
    summary).
-   **Git-safe workflow** --- snapshots are added to `.gitignore`.
-   **Security-aware redaction** of secrets.
-   **Rollback plans** using safe Git commands only.
-   Compatible with **multiple terminal AI tools**.

## Project Structure

    project/
    │
    ├── BOOTSTRAP.txt      # Master instruction file for the AI (read-only)
    ├── snapshots/         # Auto-generated snapshot files (ignored by Git)
    │     ├── <ISO8601>.json
    │     └── <ISO8601>-summary.txt
    │
    ├── setup.bat          # Windows setup script
    └── setup.sh           # macOS/Linux setup script

## Installation & Setup

### 1. Add the bootstrap file

Place `BOOTSTRAP.txt` in the **root** of your project.

### 2. Run a setup script

-   **Windows:**

    ``` bat
    setup.bat
    ```

-   **macOS/Linux:**

    ``` sh
    ./setup.sh
    ```

This will: - Create the `snapshots/` directory - Add `snapshots/` to
`.gitignore` if not already present

## Using with Terminal AI Agents

### 1. Start your AI tool

Open QuinnCode, Claude CLI, Cursor, Gemini CLI, etc.

### 2. Paste the system prompt

Use this **exact** system prompt *before* sending the AI your
`BOOTSTRAP.txt`:

    SYSTEM: READ-ONLY BOOTSTRAP MODE. Parse BOOTSTRAP.txt exactly and DO NOT modify repo files while reading. After parsing, output JSON boot-report {"ready": true|false, "summary":"...", "observations":[], "questions":[]}.

    When user says: SNAPSHOT commit: "<message>" version: "<ver|auto>", create snapshots/<ISO8601>.json and snapshots/<ISO8601>-summary.txt following the snapshot schema. Redact secrets; include safe rollback_plan with git commands only.

### 3. Paste `BOOTSTRAP.txt`

The AI will parse and produce a `boot-report`.

### 4. Create a snapshot

Tell the AI:

    SNAPSHOT commit: "test snapshot" version: auto

A new snapshot should appear in `snapshots/`.

## Snapshot Contents

Each snapshot consists of:

1.  **JSON state file** (`snapshots/<ISO8601>.json`)
2.  **Readable summary file** (`snapshots/<ISO8601>-summary.txt`)

Snapshots must include: - current project state - structured findings -
decisions made by the AI - sanitized configuration details - **rollback
plan using only Git commands** - **redacted secrets**

## Security Guidelines

-   **Never store passwords, API keys, or database credentials** in
    `BOOTSTRAP.txt`.
-   Provide sensitive credentials **interactively** if your AI agent
    requests them.
-   Snapshots must **redact**:
    -   secrets
    -   tokens
    -   environment variables
    -   any sensitive operational data
-   Agents should not write or modify repository files *during the
    bootstrap phase*.

## License

MIT License.
