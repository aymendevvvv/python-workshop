# Challenge: Using an MCP Server with a Local SQLite Database

This challenge introduces you to using an MCP server with a local SQLite database.

Instead of documents, the AI will interact with structured relational data and produce useful insights by querying the database through MCP. This simulates a real-world local MCP use case backed by a relational database.

## Overview

Your task is to:

1. **Set up the database** — Create a local SQLite database file
2. **Populate the database** — Execute a SQL file that creates tables and inserts data
3. **Implement an MCP database server** — Try to implement it on your own 
4. **Prompt the AI for useful insights** — Use Claude Desktop to query and analyze the database

---

## ⚠️ Important

Try to complete this challenge by yourself first before reading further. The sections below guide you toward a working solution.

## Prerequisites

- **Node.js** 18 or higher
- **SQLite** 3
- **Claude Desktop** (latest version)
- **Basic SQL knowledge**
- **Terminal/Command line** familiarity

## Installing SQLite

### Linux

#### Debian / Ubuntu
```bash
sudo apt install -y sqlite3
```

### Windows

#### Manual Installation
1. Download SQLite tools from [sqlite.org/download.html](https://www.sqlite.org/download.html)
2. Extract the archive to a folder (e.g., `C:\sqlite`)
3. Add the folder to your system PATH:
   - Press `Win + X` → Select "System"
   - Click "Advanced system settings"
   - Click "Environment Variables"
   - Under "System variables", select "Path" and click "Edit"
   - Click "New" and add your SQLite folder path
   - Click "OK" and restart your terminal

#### Verify Installation
```cmd
sqlite3 --version
```

---

## Step 1: Set Up and Populate the Database

We first need data to work with, so we'll create and populate a local SQLite database.

### What You Need to Do

1. Download the SQL initialization file: [init.sql](init.sql)
2. Open your terminal or command line (not powershell) and navigate to this directory
3. Run the following command:

```bash
sqlite3 database.db < init.sql
```

### Verification

If successful, you should see a new file called [database.db](database.db) in your current directory. You can verify it was populated:

```bash
sqlite3 database.db "SELECT count(*) as table_count FROM sqlite_master WHERE type='table';"
```

The output should be : 8

Alternatively, if you have a pre-populated [database.db](database.db) file already available, you can use that instead.

---

## Step 2: Download the Package & Configure Claude Desktop

In this step, you'll configure Claude Desktop to run the MCP database server.

Install the MCP database server:
npm install -g @executeautomation/database-server

Configure Claude Desktop:

1. Open Claude Desktop
2. Go to:
   Settings -> Developer -> Edit Config
3. Update the configuration file to look like this:
```json
{
  "mcpServers": {
    "sqlite": {
      "command": "npx",
      "args": [
        "-y",
        "@executeautomation/database-server",
        "PATH/TO/YOUR/database.db"
      ]
    }
  }
}
```

Replace PATH/TO/YOUR/database.db with the absolute path to your database file.

---

IMPORTANT

After editing the config:
- Fully close Claude Desktop
- Reopen it

Windows:
- You may need to end all Claude processes from Task Manager

Linux:
- Ensure no Claude processes are still running

This is required for the MCP server to start correctly.

---

## Step 3: Interact with the Database Using Claude Desktop

Now comes the fun part.

Using Claude Desktop, interact with the database through MCP.

Do not think in raw SQL first.
Think in intent and let the AI translate that intent into database queries.

---

## Example Use Cases

### Use Case 1: Project Health Overview

Assess the overall health of projects by analyzing task completion, priorities, and blockers.

**What to analyze:**
- Task completion status per project
- High-priority unfinished tasks
- Blocked work items

**Prompt to try:**
> "Rank the projects from healthiest to riskiest. For each, summarize task completion status, highlight any high-priority unfinished work, and identify blocked tasks. Support your ranking with data."

---

### Use Case 2: Team Workload Analysis

Evaluate workload distribution across team members and identify capacity issues.

**What to analyze:**
- Assigned tasks per team member
- Estimated vs actual logged hours
- Task priority and status

**Prompts to try:**
> "Compare total estimated hours to actual logged hours for each team member. Who appears overloaded or underutilized? Explain using the data."

> "Identify any team members with mismatches between estimated and actual hours. What does this tell us?"

---

### Use Case 3: Manager-Level Decision Support

Generate a weekly status update with actionable recommendations based on data.

**What to prepare:**
- Current project progress summary
- Risk identification (blocked tasks, high-priority work, uneven workload)
- Concrete risk mitigation actions

**Prompt to try:**
> "Prepare a weekly status update. First, summarize current progress for each active project. Then identify the top 3 risks: blocked tasks, high-priority unfinished work, and workload imbalances. Finally, recommend 2–3 concrete actions to reduce risk this week. Support each point with data."

---


Take your time, experiment, and push Claude with higher-level questions
