# 📘 CLI Toolbox Generator -- Template Contributor/Creation Guide

Hello and welcome!\
This guide explains how to create, modify, and extend templates for the
**CLI Toolbox Generator**.

The generator is fully **template-driven**, meaning **every file** that
appears in a generated CLI project comes directly from a template file.
I wanted to make this process painless for whoever uses this (including future me).

There is:

-   **No writing of code in order to implement**
-   **No code-side feature registration**
-   **No variable interpolation in user templates**
-   **Nothing for the contributor to configure**

Just **add a `.tpl` file** in the right directory and the generator
handles the rest.

------------------------------------------------------------------------

## 🚀 TL;DR - A Quickstart for Template Authors

### ✔ To add a file to *every* generated CLI:

    templates/Core/<folder>/<file>.tpl

### ✔To add a file to an *optional* feature pack:

    templates/Optional/<feature_name>/<folder>/<file>.tpl

The generator will automatically:

-   Detect `<feature_name>`
-   Present it as a selectable feature during generation
-   Include or skip that template pack based on your choice(s)
-   This lets you decide your favorite default files and outline some optional ones

No code changes required! Just some basic folder navigation.

------------------------------------------------------------------------

## 🧱 1. Template System Overview

All templates live under:

    src/cli_toolbox_generator/templates/

Two major branches:

    templates/
        Core/       → Always included in every generated CLI
        Optional/   → Included only if the user chooses the feature

The folder structure inside each directory **defines the project
structure**.

**NOTE:** There is also a folder called Internal_Templates_NotReg/ 
these are templates the generator uses to generate your project. It is strongly advised
to not modify these unless you know what you're doing.

------------------------------------------------------------------------

## 📁 2. Template Folder Structure

### **2.1. Core Templates**

Core templates are always included in every generated project.

    templates/Core/
        utilities/
        ui/
        menu/
        main/
        documentation/
        debug/
        plugins/
        (or any new folders you add)

Example:

    templates/Core/utilities/input_utils.py.tpl
    → outputs to utilities/input_utils.py

✔ No toggles required\
✔ No changes to the generator\
✔ Perfect for shared building blocks & commonly used modules

------------------------------------------------------------------------

### **2.2. Optional Feature Templates**

Optional templates form **feature packs**:

    templates/Optional/<feature_name>/

Examples:

    templates/Optional/plugins/CLI_Text_Extras/
    templates/Optional/plugins/Data_Conversion_Tools/
    templates/Optional/my_features/confirm_dialog.py.tpl

-   `<feature_name>` is automatically detected\
-   The generator surfaces it in the user-facing feature selection UI\
-   If you enable the feature, all files under that folder are
    included\
-   If not, nothing under that folder appears in the generated project

✔ No Python code needed\
✔ No configuration steps\
✔ Fully modular

------------------------------------------------------------------------

## ✨ 3. Template Naming Rules

### ✔ Must end with `.tpl`

Example:

    myfile.py.tpl
    help.txt.tpl
    README.md.tpl

The `.tpl` suffix is removed automatically in the final output:

    help.txt.tpl → help.txt

### ✔ File extension before `.tpl` determines output type

-   `.py.tpl → .py`\
-   `.md.tpl → .md`\
-   `.json.tpl → .json`\
-   `.txt.tpl → .txt`\
-   Anything else is supported as long as it ends in `.tpl`

### ✔ Filename becomes output filename

No additional syntax, markers, or metadata required.

------------------------------------------------------------------------

## ❌ 4. No Variables, No Logic, No Special Syntax

(*Public Templates Only*)

User-contributed templates **cannot** use:

-   `{{ variables }}`
-   `{% logic %}`
-   Placeholder tokens
-   Macro syntax
-   Jinja-like constructs
-   Internal engine hooks

Those are strictly reserved for **Internal Templates** used by the
generator itself as they require dynamic writers.

> **User templates must be literal file content.**\
> What you write is exactly what gets generated. This may be reworked in the future.

------------------------------------------------------------------------

## 🏗 5. Output Path Rules

The folder structure under `Core/` or `Optional/<feature>/` determines
where files appear in the output project.

Examples:

    templates/Core/utilities/display.py.tpl
    → generated/utilities/display.py

    templates/Optional/colors/highlights.py.tpl
    → generated/colors/highlights.py
    (only if “colors” was chosen by the user)

✔ Contributors may freely create new directories\
✔ The generator mirrors structure automatically

------------------------------------------------------------------------

## 🧩 6. Adding Your Own Templates

### **Step 1: Choose Core or Optional**

**Always included:**

    templates/Core/<folder>/<file>.tpl

**Feature pack (user may enable during generation):**

    templates/Optional/<feature_name>/<folder>/<file>.tpl

------------------------------------------------------------------------

### **Step 2: Create your `.tpl` file**

Any content is acceptable.\
No variables allowed.\
No dynamic logic.\
Just plain text, Python, JSON, markdown, etc.

------------------------------------------------------------------------

### **Step 3: Done**

The generator will automatically:

-   detect your template\
-   include it or skip it (Optional only)\
-   strip `.tpl`\
-   write the resulting file to the appropriate path

No imports, writers, or registrations needed.

------------------------------------------------------------------------

## 🧪 7. Testing Your Template

Generate a project:

    python generate.py

Go through the feature selection prompts.\
Then inspect the generated project:

    <project_name>/
        utilities/
        ui/
        menu/
        plugins/
        (etc.)

Your file should be present exactly where expected.

------------------------------------------------------------------------

## 👑 8. Advanced Tips

### ⭐ 1. Organize optional features

Group related templates:

    templates/Optional/qol/
        borders.py.tpl
        menus.py.tpl
        animations.py.tpl

### ⭐ 2. Nested folders allowed

They map directly into the final project.

### ⭐ 3. Any file type allowed

Python, Markdown, JSON, YAML, text, assets, etc.

### ⭐ 4. Custom folders welcome

The generator does not enforce any naming scheme.\
Whatever you create becomes part of the generated project.

------------------------------------------------------------------------

## 🎉 9. Summary

This generator is:

-   **simple**
-   **modular**
-   **powerful**
-   **completely template-driven**
-   **zero-code for contributors**

Core templates = always included\
Optional templates = selectable feature packs

No variables, no conditionals, no syntax rules.\
Just templates.

**Templates ARE the generator.**

Happy building! Please let me know if you have any feedback or ideas for features!
