#!/bin/bash

# Install tfenv
git clone https://github.com/tfutils/tfenv.git venv/.tfenv || { echo "Failed to install tfenv."; exit 1; }

# Add tfenv to PATH and initialize
echo 'export PATH="venv/.tfenv/bin:$PATH"' >> venv/bin/activate || { echo "Failed to add tfenv to PATH."; exit 1; }
echo 'eval "$(tfenv init -)"' >> venv/bin/activate || { echo "Failed to initialize tfenv."; exit 1; }
# Add the tfenv directory to PATH
export PATH="$PATH:$(pwd)/venv/.tfenv/bin"

# Install latest version of TensorFlow
tfenv use latest || { echo "Failed to install or use the latest version of TensorFlow with tfenv."; exit 1; }

echo "Installation completed successfully."