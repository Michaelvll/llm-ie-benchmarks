# LLM Inference Engine Benchmarks

This is a collection of open-source LLM inference engine benchmarks, created by different inference engine teams. It aims to create a fair and reproducible scripts to test the inference performance of different inference engines.

We use [SkyPilot](https://github.com/skypilot-ai/skypilot) YAML to run the benchmarks on different infrastructure, making sure the benchmarks are reproducible and fair.

## Installation

```bash
pip install -U skypilot
```

Setup cloud credentials. See [SkyPilot docs](https://docs.skypilot.co/en/latest/getting-started/installation.html).

## vLLM

vLLM created a [benchmark](https://github.com/simon-mo/vLLM-Benchmark/tree/main) for vLLM vs SGLang and TRT-LLM.

To run the benchmarks:

> [!NOTE]
> vLLM team runs the benchmarks on Nebius H200 machines, so we use `--cloud nebius` below.

```bash
cd ./vllm

# Run the benchmarks
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=vllm

sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=sgl

sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=trt
```


## SGLang

TO BE UPDATED
