# LLM Inference Engine Benchmarks

![cover](./cover.png)

This is a collection of open-source inference engine benchmarks for LLMs, created by different inference engine teams. It aims to create a fair and reproducible scripts to test the inference performance of different inference engines.

We use [SkyPilot](https://github.com/skypilot-ai/skypilot) YAML to run the benchmarks on different infrastructure, making sure the benchmarks are reproducible and fair.


## Installation

```bash
pip install -U "skypilot[nebius]"
```

Setup cloud credentials. See [SkyPilot docs](https://docs.skypilot.co/en/latest/getting-started/installation.html).

## vLLM

vLLM created a [benchmark](https://github.com/simon-mo/vLLM-Benchmark/tree/main) for vLLM vs SGLang and TRT-LLM.

To run the benchmarks:

> [!NOTE]
> vLLM team runs the benchmarks on Nebius H200 machines, so we use `--cloud nebius` below.


### Run the benchmarks

```bash
cd ./vllm

# Run the benchmarks for vLLM
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=vllm

# Run the benchmarks for SGLang
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=sgl

# This is not supported yet
# sky launch --cloud nebius -c benchmark benchmark.yaml
#   --env HF_TOKEN
#   --env MODEL=deepseek-r1
#   --env ENGINE=trt
```

> [!NOTE]
> If you would like to run the benchmarks on different infrastructure, you can change `--cloud` to other clouds or your kubernetes cluster: `--cloud k8s`.


### Benchmark Results

#### DeepSeek-R1

**CPU**: Intel(R) Xeon(R) Platinum 8468
**GPU**: 8x NVIDIA H200

| Input Tokens | Output Tokens | vLLM | SGLang | 
| ------------ | ------------- | ------------ | 
│         1000 │          2000 │ 1108.74 │ 506.00 │ 
│         5000 │          1000 │  844.08 │ 387.10 │ 
│        10000 │           500 │  441.37 │ 206.57 │ 
│        30000 │           100 │   29.94 │  18.86 │ 
│     sharegpt │      sharegpt │ 1327.21 │ 535.85 │ 

**Output token throughput (tok/s)**

<details>
<summary>DeepSeek-R1 Benchmark Commands</summary>

**vLLM**
```bash
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=vllm
```

**SGLang**
```bash
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=sgl
```

**TRT-LLM**
```bash
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=trt
```
</details>


#### Llama-8B


**Output token throughput (tok/s)**

| Input Tokens | Output Tokens | vLLM | SGLang | TRT-LLM |
| ------------ | ------------- |
│         1000 │          2000 │ 4443.01 │
│         5000 │          1000 │ 2413.53 │
│        10000 │           500 │ 1140.73 │
│        30000 │           100 │  105.23 │
│     sharegpt │      sharegpt │ 1978.90 │


<details>
<summary>Llama-8B Benchmark Commands</summary>

**vLLM**
```bash
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=llama-8b
  --env ENGINE=vllm
```

**SGLang**
```bash
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=llama-8b
  --env ENGINE=sgl
```

**TRT-LLM**
```bash
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=llama-8b
  --env ENGINE=trt
```

</details>


## SGLang

SGLang created a [benchmark](https://github.com/deepseek-ai/sglang/tree/main/benchmark) for SGLang on random input and output.

### Run the benchmarks

```bash
cd ./sgl

sky launch --cloud nebius -c benchmark benchmark.yaml
```
