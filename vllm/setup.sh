#!/bin/bash
# Common setup script for all LLM inference benchmarks

set -e  # Exit on error

# Install system dependencies
echo "Installing system dependencies..."
sudo apt-get update -y
sudo apt-get install -y git-lfs

curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | sudo bash -s -- --to /usr/local/bin || true

# Create benchmark directories
echo "Creating benchmark directories..."
mkdir -p ~/benchmark_results

# Clone the vLLM benchmark repository
echo "Cloning vLLM-Benchmark repository..."
git clone https://github.com/simon-mo/vLLM-Benchmark ~/vLLM-Benchmark
cd ~/vLLM-Benchmark

echo "Cloning vLLM benchmarks directory..."
just clone-vllm-benchmarks
uv pip install -r requirements-benchmark.txt

# Setup environment and download datasets
echo "Setting up environment and downloading datasets..."
just list-versions  # This will set up the environment
just download-dataset sharegpt

# Download model if MODEL is defined
if [ ! -z "$MODEL" ]; then
  echo "Downloading model: $MODEL"
  just download-model "$MODEL"
fi

echo "Setup complete!" 
