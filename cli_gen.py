# Entry point to get into src properly, made this way for possible future pip installation process

import os
import sys

# Ensure the src / directory is in the module path
ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
SRC_DIR = os.path.join(ROOT_DIR, "src")
if SRC_DIR not in sys.path:
    sys.path.insert(0, SRC_DIR)

# Import and run the real entrypoint
from cli_toolbox_generator.main import main

if __name__ == "__main__":
    main()
