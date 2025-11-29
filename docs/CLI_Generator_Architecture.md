# CLI Generator – Architectural Overview

This document provides a complete architectural overview of the CLI Generator system, including high‑level structure, internal engine subsystems, the full project generation process, and the output architecture. All diagrams are written in Mermaid and will render when possible.

---

## 1. High‑Level Architecture Overview

```mermaid
flowchart LR

    UserInput["User Input"]
    Config["ProjectConfig<br>(parses project definition)"]
    TreeBuilder["MenuTreeBuilder<br>(builds menu hierarchy)"]
    BuildContext["BuildContext<br>(stores parsed state)"]

    UserInput --> Config
    Config --> TreeBuilder
    Config --> BuildContext
    TreeBuilder --> BuildContext

    Pipeline["BuilderPipeline<br>(executes generation stages)"]
    BuildContext --> Pipeline

    subgraph Engine[Internal Engine Subsystems]
        Writers["Writer System"]
        Templates["Template System"]
        Wizard["Wizard System"]
    end

    Pipeline --> Engine

    Output["Generated Project Output<br>(final folder + code tree)"]
    Engine --> Output
```

---

## 2. Full Project Generation Process

```mermaid
flowchart TD

    %% INPUT + CONFIG
    UserInput["User Input"]
    Config["ProjectConfig<br>(parses user input)"]
    TreeBuilder["MenuTreeBuilder<br>(constructs menu structure)"]
    BuildContext["BuildContext<br>(collects all generation data)"]

    UserInput --> Config
    Config --> TreeBuilder
    Config --> BuildContext
    TreeBuilder --> BuildContext

    %% PIPELINE
    subgraph PipelineBox[BuilderPipeline stages]

        CoreDir["Folder Layout<br>(CoreDirectoryStage)"]
        UtilStage["Utility Modules<br>(UtilitiesWriterStage)"]
        MenuStage["Menu Tree and Handlers<br>(MenuWriterStage)"]
        MainStage["Main Entry Script<br>(MainWriterStage)"]
        DocStage["Documentation Files<br>(DocumentationStage)"]
        FeatureStage["Extra Features<br>(OptionalFeatureStages)"]

    end

    BuildContext --> CoreDir
    CoreDir --> UtilStage
    UtilStage --> MenuStage
    MenuStage --> MainStage
    MainStage --> DocStage
    DocStage --> FeatureStage

    %% OUTPUT
    Output["Final Project Output<br>(folders, utilities, menus, docs)"]
    FeatureStage --> Output
```

---

## 3. Internal Engine Subsystems (High Detail)

```mermaid
flowchart LR

    %% WRITERS
    subgraph WritersBlock[Writer System]
        WriterBase["Writer Base<br>(shared write helpers)"]
        UtilWriter["Utility Writer<br>(writes utility modules)"]
        MenuWriter["Menu Writer<br>(writes menu tree + handlers)"]
        MainWriter["Main Writer<br>(writes main entry script)"]
        DocWriter["Documentation Writer<br>(writes README + docs)"]
    end

    %% TEMPLATES
    subgraph TemplatesBlock[Template System]
        PyTemplates["Python File Templates"]
        MenuTemplates["Menu Templates"]
        DocTemplates["Documentation Templates"]
        ConfigTemplates["Config Default Templates"]
    end

    %% WIZARD
    subgraph WizardBlock[Wizard System]
        WizardFlow["Wizard Flow<br>(main wizard controller)"]
        InputPrompts["Input Prompts<br>(user project questions)"]
        MenuWizard["Menu Creation Wizard<br>(menus + commands)"]
        FeatureWizard["Feature Wizard<br>(optional features)"]
    end

    %% RELATIONSHIPS
    WriterBase --> UtilWriter
    WriterBase --> MenuWriter
    WriterBase --> MainWriter
    WriterBase --> DocWriter

    WriterBase --> PyTemplates
    WriterBase --> MenuTemplates
    WriterBase --> DocTemplates
    WriterBase --> ConfigTemplates

    WizardFlow --> InputPrompts
    WizardFlow --> MenuWizard
    WizardFlow --> FeatureWizard

    InputPrompts --> WriterBase
    MenuWizard --> MenuWriter
    FeatureWizard --> DocWriter
```

---

## 4. Output Architecture

```mermaid
flowchart TD

    subgraph OutputBlock[Generated Project Output]

        Root["Project Root Folder"]

        subgraph UtilFolder[Utilities Folder]
            DisplayUtil["display.py<br>(print helpers)"]
            SystemUtil["system.py<br>(system functions)"]
            ArrowSel["arrow_selector.py"]
            MultiSel["multi_select.py"]
            UiQol["ui_qol.py"]
        end

        subgraph MenuFolder[Menu System Folder]
            MenuTree["menu_tree.py<br>(menu structure)"]
            Handlers["handlers.py<br>(menu command handlers)"]
            UserCode["user_code sections<br>(developer-implemented areas)"]
        end

        EntryFile["main.py<br>(entry script)"]
        Readme["README<br>(auto-generated documentation)"]

    end

    Root --> UtilFolder
    Root --> MenuFolder
    Root --> EntryFile
    Root --> Readme
    MenuFolder --> UserCode
```
