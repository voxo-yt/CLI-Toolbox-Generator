
# {{project_name}} — Usage Guide
_Auto-generated on {{date}} by CLI Toolbox Generator_

Welcome to **{{project_name}}** — a fully generated, extensible Python CLI project.

This guide walks you through:

- Project layout  
- How the generated menu tree works  
- Where and how to add your own command logic  
- Built-in UI utilities  
- Included QoL plugins  
- How to extend or customize your CLI  

---

# Project Structure

Your generated project is organized as follows:

```
{{project_name}}/
│
├── cli_main.py                       ← CLI entrypoint | Move it into your main project's root
│
├── menus/                        ← Auto-generated menu classes
│    ├── <root_name>_menu.py    ← Root menu (named after your root menu)
│    ├── ...submenus...           ← Child menus based on your menu tree
│
├── ui/
│    └── ui_manager.py            ← Header, formatting, tables, pause helpers
│   
├── utilities/                    ← Built-in QoL utilities
│    ├── display.py
│    ├── arrow_selector.py
│    ├── arrow_multi_select.py
│    └── ...other utilities...
│
├── plugins/                      ← Optional plugin modules
│    ├── example_plugin.py
│    └── ...additional plugins...
│
└── debug/                        ← Debug tools
     ├── debug_menu.py
     ├── debug_inspector.py
     └── ...
```

---

# Running the CLI

Move the cli_main to your main project's root:

```
python cli_main.py
```

The CLI automatically loads your menu tree and uses the UI manager for consistent formatting.

---

# Menu System

Each menu is represented by its own class:

```python
class ExampleMenu:
    def display(self):
        # Renders header + options
        ...

    def handle(self):
        # Routes selection to command handlers
        ...
```

Commands follow the generated pattern:

```python
def cmd_do_something(self):
    # TODO: implement this command
    ...
```

---

# UI Utilities (UIManager)

Every menu has access to a shared `UIManager` instance:

```python
self.ui.header("Title")
self.ui.clear()
self.ui.pause()
self.ui.line()
self.ui.print_kv("Label", "Value")
```

---

# Selectors: Single & Multi-Pick

Arrow‑key navigation is built-in:

### Single-select
```python
choice = select("Pick one:", ["Option A", "Option B"])
```

### Multi-select
```python
choices = multi_select("Pick all that apply:", ["A", "B", "C"])
```

---

# Extending the CLI

To expand your CLI:

1. **Add a new menu**  
   Create a `.py` file in `menus/` and follow any generated menu class.

2. **Add new commands**  
   Add new `cmd_*` methods inside the appropriate menu file.

3. **Add custom helpers**  
   Place reusable modules in `utilities/` or `plugins/`.

4. **Modify UI appearance**  
   Edit `ui/ui_manager.py` for global formatting changes.

---

# Happy Building!

Generated with ❤️ by **CLI Toolbox Generator**
