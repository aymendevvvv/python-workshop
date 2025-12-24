# MCP Server Demo Setup with Claude

This guide will help you set up and run the **Claude MCP server demo** using `uv` and the MCP CLI.

---

## Prerequisites

- Python 3.11+ installed
- `uv` package installed (`pip install uv`)
- MCP package installed with CLI support (`pip install mcp[cli]`)
- Your `main.py` server file ready (example path: `C:\Users\DELL\Documents\mcpserver\main.py`)

---

## Configuration

Here’s an example configuration to run the MCP server with Claude:

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
