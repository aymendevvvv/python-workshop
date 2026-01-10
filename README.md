# Python Workshop: MCP Servers with Claude

A comprehensive workshop covering Model Context Protocol (MCP) servers and their integration with Claude for AI-powered applications.

---

## Overview
This workshop explores practical applications of MCP servers, focusing on:

- **MCP Server Fundamentals** — Understanding the MCP architecture and how AI agents interact with external tools
- **Local Database Integration** — Building MCP servers that query SQLite databases
- **Document Processing** — Indexing and searching PDF/Markdown files with AI-powered retrieval
- **Real-world Use Cases** — Practical examples for project management, knowledge bases, and data analysis

---

## Workshop Structure

### 1. MCP Server Demo

Get started with a basic MCP server setup using `uv` and the MCP CLI.

**Prerequisites:**
- Python 3.11+ installed
- `uv` package installed (`pip install uv`)
- MCP package installed with CLI support (`pip install mcp[cli]`)
- Your `main.py` server file ready

**Configuration Example:**

```json
{
  "mcpServers": {
    "mcp-server-demo": {
      "command": "uv",
      "args": [
        "run",
        "--with",
        "mcp[cli]",
        "mcp",
        "run",
        "C:\\Users\\DELL\\Documents\\mcpserver\\main.py"
      ]
    }
  }
}
```

---

### 2. Challenge: SQLite Database MCP Server

Build an MCP server that interfaces with a local SQLite database and query it using natural language through Claude.

**📌 [See Full Challenge Guide →](./challenge/README.md)**

---

### 3. Practical Use Case: PDF Knowledge Base

Index local PDF and Markdown files to extend Claude's context using Docker-based embeddings and semantic search.

**📌 [See Full Setup Guide →](./PDF-knowledge-base/README.md)**

---




## Useful Resource :

- [Useful Mcp Servers](https://github.com/punkpeye/awesome-mcp-servers)

