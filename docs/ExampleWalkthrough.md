# Building a Task Tracker With CLI Toolbox Generator

This example demonstrates how to turn the generator’s output into a **real working CLI application** that uses:

- JSON storage
- Single and multi-select commands
- The provided Data Conversion / JSON utilities
- Generated menus and UI helpers

This matches the real workflow of a user who:
1. Generated a project (with the Data_Conversion_Tools plugin enabled)
2. Moved only the *generated CLI* folder elsewhere  
3. Deleted the generator  
4. Is now working solely inside the new project directory  

---

# 1. Project Structure After Generation

```
TaskTracker/
    data/ <-- We add ourselves
        tasks.json <-- We add ourselves
    debug/
    menus/
    plugins/
    ui/
    utilities/
    main.py
    USAGE_GUIDE.d
```

> ⭐ After generation, **you only have this folder** — no generator required.

---

# 2. Initial JSON File

Inside `TaskTracker/data/tasks.json`, initialize:

```json
[]
```

The program will manage this list.

---

# 3. Using the Provided JSON Utilities

You already have:

```python
from plugins.Data_Conversion.data_convert import json_to_dict, dict_to_json
```

These handle safe reading/writing of JSON. Add this line to the top
of `menus/tasktracker_menu.py`.

---

# 4. Setting Up The Datafile Access

Inside `menus/tasktracker_menu.py`, add:

```python
import os

TASK_FILE = os.path.join("data", "tasks.json")
```

This is how we'll access our JSON.

---

# 5. Implementing “Add Task”

```python
def cmd_add_task(self):
    self.ui.clear()

    task_text = input("Enter a new task: ").strip()
    if not task_text:
        print_warning("No task entered.")
        self.ui.pause("Press Enter...")
        return

    tasks = json_to_dict(TASK_FILE) or []
    tasks.append({"task": task_text, "done": False})
    dict_to_json(tasks, TASK_FILE)

    print_success(f"Task added: {task_text}")
    self.ui.pause("Press Enter to return...")
```

---

# 6. Implementing “View Tasks”

```python
def cmd_view_tasks(self):
    self.ui.clear()

    tasks = json_to_dict(TASKFILE) or []

    if not tasks:
        print_warning("No tasks yet.")
        self.ui.pause("Press Enter...")
        return

    self.ui.header("Your Tasks:")
    print("---------------------------")
    for i, t in enumerate(tasks, start=1):
        status = "✓" if t["done"] else "•"
        print(f"{i}. [{status}] {t['task']}")

    print()
    self.ui.pause("Press Enter to return...")
```

---

# 7. Implementing Multi-Select “Mark Tasks Complete”

```python
def cmd_multi_mark_tasks_complete(self):
    self.ui.clear()

    tasks = json_to_dict(TASK_FILE) or []
    incomplete = [t for t in tasks if not t["done"]]

    if not incomplete:
        print_warning("No incomplete tasks to mark.")
        self.ui.pause("Press Enter...")
        return

    labels = [t["task"] for t in incomplete]

    selected = self.ui.choose_multi(labels, title="Select tasks to mark complete")
    if not selected:
        return

    for task in tasks:
        if task["task"] in selected:
            task["done"] = True

    dict_to_json(tasks, TASK_FILE)

    self.ui.clear()
    print_success("Marked complete:")
    for s in selected:
        print(" -", s)

    self.ui.pause("Press Enter to return...")
```

---

# 8. Running the Program

From inside the TaskTracker directory:

```
python main.py
```

You now have:

- A persistent JSON-backed task list  
- Menu-driven navigation  
- Real add/view operations  
- A fully functional multi-select batch command  

All from a generated output that required **minimal editing**.

---

# 9. Summary - Your New Task Tracking Program

This example showed you:

- How generated stubs are extended at a basic level
- How utilities integrate naturally (using display.py for print_warning/print_success)
- How multi-select logic works  
- How your generator enables real-world tools with almost no boilerplate
- How to use the ui manager's built in formatting  

---

# 10. Resulting View

If you added "Make this walkthrough" and "Check for syntax errors in walkthrough" as tasks -> Marked "Make this walkthrough" as completed -> Viewed Tasks, you'd get this:
```
┌──────────────┐
│  Your Tasks  │
└──────────────┘

----------------------------
1. [✓] Make this walkthrough
2. [•] Check for syntax errors in walkthrough

Press Enter to return...
```