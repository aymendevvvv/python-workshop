PRAGMA foreign_keys = ON;

-- =====================
-- USERS
-- =====================
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT CHECK(role IN ('manager', 'developer', 'designer')) NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- =====================
-- PROJECTS
-- =====================
CREATE TABLE projects (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    start_date TEXT,
    end_date TEXT,
    owner_id INTEGER NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES users(id)
);

-- =====================
-- PROJECT MEMBERS (many-to-many)
-- =====================
CREATE TABLE project_members (
    project_id INTEGER,
    user_id INTEGER,
    joined_at TEXT DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (project_id, user_id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- =====================
-- TASK STATUS (normalized)
-- =====================
CREATE TABLE task_status (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

-- =====================
-- TASKS
-- =====================
CREATE TABLE tasks (
    id INTEGER PRIMARY KEY,
    project_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    status_id INTEGER NOT NULL,
    priority INTEGER CHECK(priority BETWEEN 1 AND 5),
    estimated_hours INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (status_id) REFERENCES task_status(id)
);

-- =====================
-- TASK ASSIGNMENTS (many-to-many)
-- =====================
CREATE TABLE task_assignments (
    task_id INTEGER,
    user_id INTEGER,
    assigned_at TEXT DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (task_id, user_id),
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- =====================
-- TASK COMMENTS
-- =====================
CREATE TABLE task_comments (
    id INTEGER PRIMARY KEY,
    task_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- =====================
-- TIME LOGS
-- =====================
CREATE TABLE time_logs (
    id INTEGER PRIMARY KEY,
    task_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    hours_spent REAL NOT NULL,
    log_date TEXT NOT NULL,
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- =====================
-- SEED DATA
-- =====================

-- Users
INSERT INTO users (name, email, role) VALUES
('Alice', 'alice@example.com', 'manager'),
('Bob', 'bob@example.com', 'developer'),
('Charlie', 'charlie@example.com', 'developer'),
('Diana', 'diana@example.com', 'designer');

-- Task statuses
INSERT INTO task_status (name) VALUES
('pending'),
('in_progress'),
('completed'),
('blocked');

-- Projects
INSERT INTO projects (name, description, start_date, owner_id) VALUES
('MCP Migration', 'Move legacy tools to MCP-based architecture', '2024-10-01', 1),
('Internal Dashboard', 'Company-wide analytics dashboard', '2024-11-15', 1),
('Developer Portal', 'Public-facing API documentation and tooling', '2025-01-10', 1),
('Design System', 'Reusable UI components and guidelines', '2025-02-01', 4);

-- Project members
INSERT INTO project_members (project_id, user_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 2), (2, 4),
(3, 1), (3, 2), (3, 3),
(4, 4), (4, 2);

-- Tasks
INSERT INTO tasks (project_id, title, description, status_id, priority, estimated_hours) VALUES
-- MCP Migration
(1, 'Design database schema', 'Initial relational design', 3, 2, 6),
(1, 'Implement MCP server', 'Node-based MCP database server', 2, 1, 14),
(1, 'Write documentation', 'README and usage examples', 1, 3, 5),
(1, 'Security review', 'Audit MCP permissions and data access', 1, 1, 8),
(1, 'Performance benchmarking', 'Measure query latency under load', 2, 2, 10),

-- Internal Dashboard
(2, 'Create UI mockups', 'Dashboard layout designs', 3, 2, 8),
(2, 'API integration', 'Connect backend services', 2, 1, 12),
(2, 'User feedback review', 'Analyze early feedback', 4, 4, 4),
(2, 'Add export feature', 'CSV and PDF export support', 1, 3, 6),
(2, 'Fix mobile layout issues', 'Responsive design fixes', 2, 2, 7),

-- Developer Portal
(3, 'API reference docs', 'Generate OpenAPI-based docs', 2, 1, 12),
(3, 'Authentication guide', 'Explain token-based auth', 1, 3, 5),
(3, 'Code examples', 'JS + Python usage samples', 1, 4, 6),

-- Design System
(4, 'Color palette definition', 'Primary, secondary, semantic colors', 3, 2, 4),
(4, 'Button components', 'Primary and secondary buttons', 2, 1, 6),
(4, 'Typography scale', 'Headings and body text styles', 1, 3, 5);

-- Task assignments
INSERT INTO task_assignments (task_id, user_id) VALUES
(1, 2),
(2, 2), (2, 3),
(3, 1),
(4, 3),
(5, 2),
(6, 4),
(7, 2),
(8, 1),
(9, 2),
(10, 4),
(11, 2),
(12, 3),
(13, 1),
(14, 4),
(15, 2),
(16, 4);

-- Task comments
INSERT INTO task_comments (task_id, user_id, comment) VALUES
(2, 2, 'Initial MCP wiring is done.'),
(2, 3, 'Need clarification on query permissions.'),
(4, 1, 'This must be done before public rollout.'),
(5, 2, 'Load tests show inconsistent latency.'),
(5, 3, 'We may need query caching.'),
(9, 2, 'Stakeholders requested export support.'),
(10, 4, 'Mobile breakpoints are inconsistent.'),
(11, 2, 'Docs generator is working locally.'),
(12, 3, 'Auth section should include token rotation.'),
(16, 4, 'Buttons need hover and disabled states.');

-- Time logs
INSERT INTO time_logs (task_id, user_id, hours_spent, log_date) VALUES
(1, 2, 4.5, '2024-10-03'),
(2, 2, 6.0, '2024-10-05'),
(2, 3, 3.5, '2024-10-06'),
(4, 3, 2.5, '2024-10-10'),
(5, 2, 4.0, '2024-10-12'),
(5, 3, 3.0, '2024-10-13'),
(6, 4, 7.0, '2024-11-20'),
(7, 1, 5.5, '2024-11-22'),
(9, 2, 2.0, '2024-11-25'),
(10, 4, 3.5, '2024-11-26'),
(11, 2, 6.0, '2025-01-12'),
(12, 3, 2.0, '2025-01-14'),
(14, 4, 3.5, '2025-02-03'),
(15, 2, 4.5, '2025-02-05');
