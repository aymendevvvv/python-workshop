## Using MCP Server on a Local Database

This challenge introduces you to using an **MCP server with a local SQLite database**.
Instead of documents, the AI will interact with **structured relational data** and produce
useful insights by querying the database through MCP.

---

## Challenge Overview

Your task is to:

1. **Set up the database**
   - Create a local SQLite database file
2. **Populate the database**
   - Execute a SQL file that creates tables and inserts data
3. **Implement an MCP database server**
   - Try to implement  
     https://github.com/executeautomation/mcp-database-server  
     **on your own**
4. **Prompt the AI for useful insights**
   - Use Claude Desktop + Claude Code to query and analyze the database

⚠️ **Important:**  
Try to implement this challenge **by yourself first** before reading further.  
The sections below will guide you toward a working solution.

---

## Prerequisites

- Node.js 18+
- SQLite
- Claude Desktop
- Basic SQL knowledge

---

## Step 1: Set Up and Populate the Database

You will create a local SQLite database and populate it using a SQL file.

### What You Need to Do

- Create a file called `database.db`
- Execute the provided SQL script against it
- Verify that the tables and data exist

Example command:

```bash
sqlite3 database.db < init.sql
```

At this stage, you should have:
- Multiple tables
- Foreign key relationships
- Enough data to run analytical queries

👉 The SQL file is provided **at the end of this document**.

---

## Step 2: Configure Claude Desktop (Node MCP Server)

In this step, you will expose your SQLite database using an MCP server.

### Requirements

- The MCP server **must be a Node.js program**
- It should connect to your local SQLite database
- It should expose MCP tools that allow:
  - Listing tables
  - Inspecting schema
  - Running read-only SQL queries

You are encouraged to try implementing this yourself before checking the reference repository:

https://github.com/executeautomation/mcp-database-server

---

### Claude Desktop Configuration

Once your MCP server is running, configure Claude Desktop to recognize it.

Typical steps:
- Add the MCP server entry to Claude Desktop
- Ensure the server is reachable
- Verify it appears as **Ready** in `/mcp desc`

---

## Step 3: Interact With the Database Using Claude Code

Now comes the fun part.

Using **Claude Code**, interact with the database **through MCP**.

Do **not** think in raw SQL first — think in **intent**.

---

## Example MCP-Aligned Prompts

### Use Case 1: Schema Understanding

```
Inspect the database.
List all tables and explain how they are related.
```

---

### Use Case 2: Basic Data Exploration

```
List all projects and include the name of the user responsible for each one.
```

---

### Use Case 3: Aggregation & Insights

```
Calculate the total estimated workload per project.
Rank projects from most to least demanding.
```

---

### Use Case 4: Analytical Reasoning

```
Which user appears to be the most overloaded based on task estimates?
Explain your reasoning using the data.
```

---

## Optional Challenges

If you want to push further:

- Add indexes and re-test queries
- Add a fourth table (logs, comments, payments, etc.)
- Combine this MCP server with a PDF-based MCP server
- Ask the AI to correlate structured + unstructured data

---

## Success Criteria

You have completed this challenge if:

- Your SQLite database is correctly populated
- Your MCP server exposes the database successfully
- Claude can:
  - Inspect schema
  - Run joins and aggregations
  - Provide meaningful insights

🎯 **Goal:**  
Learn how MCP enables AI agents to reason over **local structured databases**, not just text.
