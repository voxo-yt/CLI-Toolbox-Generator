from cli_toolbox_generator.wizard.wizard_generator import GeneratorWizard
from cli_toolbox_generator.utilities.ui_tools import clear_screen


def main():
    clear_screen()
    GeneratorWizard().run()


if __name__ == "__main__":
    main()
