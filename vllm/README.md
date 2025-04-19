# LLM Inference Engine Benchmark with SkyPilot

This directory contains SkyPilot YAML configurations to reproduce the benchmarks from [vLLM-Benchmark](https://github.com/simon-mo/vLLM-Benchmark).

## Overview

These benchmarks compare the performance of different inference engines:
- vLLM
- SGLang (SGL)
- TensorRT-LLM (TRT-LLM)

The benchmark measures throughput (output tokens/s) across different scenarios:
- Various input token lengths (1000, 5000, 10000, 30000)
- Various output token lengths (2000, 1000, 500, 100)
- ShareGPT conversations

## Prerequisites

- SkyPilot installed and configured
- Access to cloud resources with NVIDIA H100/H200 GPUs

## Usage

### Running benchmarks for a specific engine

```bash
# Run the vLLM benchmark
sky launch --cloud nebius benchmark.yaml \
    --env HF_TOKEN \
    --env ENGINE=vllm \
    --env MODEL=deepseek-r1

# Run the SGLang benchmark
sky launch --cloud nebius benchmark.yaml \
    --env HF_TOKEN \
    --env ENGINE=sgl \
    --env MODEL=deepseek-r1

# Run the TensorRT-LLM benchmark
sky launch --cloud nebius benchmark.yaml \
    --env HF_TOKEN \
    --env ENGINE=trtllm \
    --env MODEL=llama-8b
```

### Customizing benchmarks

You can modify the YAML files to:
- Change the model (default: deepseek-r1; qwq-32b, llama-8b, llama-3b, qwen-1.5b)
- Adjust the benchmark parameters
- Select different instance types

For example, to run with a different model:

```bash
sky launch benchmark.yaml --env MODEL=llama-8b
```
