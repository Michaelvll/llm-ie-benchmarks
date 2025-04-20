# LLM Inference Engine Benchmarks

![cover](./cover.png)

This is a collection of open-source inference engine benchmarks for LLMs, created by different inference engine teams. It aims to create a **fair and reproducible** scripts to test the inference performance of different inference engines.

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
sky launch --cloud nebius -c benchmark -d benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=vllm

# Run the benchmarks for SGLang
# Note: the first run of SGLang will have half of the throughput, likely due to
# the JIT code generation. In the benchmark.yaml, we discard the first run and
# run the sweeps again.
sky launch --cloud nebius -c benchmark -d benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=sgl


# This is not supported yet
# sky launch --cloud nebius -c benchmark benchmark.yaml
#   --env HF_TOKEN
#   --env MODEL=deepseek-r1
#   --env ENGINE=trt
```

Stop the cluster after the benchmarks are done: 

```bash
sky autostop benchmark
```

> [!NOTE]
> If you would like to run the benchmarks on different infrastructure, you can change `--cloud` to other clouds or your kubernetes cluster: `--cloud k8s`.


### Benchmark Results

#### DeepSeek-R1

**CPU**: Intel(R) Xeon(R) Platinum 8468
**GPU**: 8x NVIDIA H200

**Output token throughput (tok/s)**

| Input Tokens | Output Tokens | vLLM | SGLang |
| ------------ | ------------- | ------------ | ------------ |
|         1000 |          2000 | 1124.66 | 971.49 |
|         5000 |          1000 |  846.07 | 813.83 |
|        10000 |           500 |  440.85 | 390.35 |
|        30000 |           100 |   37.03 |  33.11 |
|     sharegpt |      sharegpt | 1323.74 | 836.45 |

After turning off [Nvidia GPU ECC mode](https://www.nvidia.com/content/Control-Panel-Help/vLatest/en-us/mergedProjects/3D%20Settings/To_turn_your_GPU_ECC_on_or_off.htm) (see `experimental.config_overrides.nvidia_gpus.disable_ecc`), the throughput is higher.

<!-- TODO -->


**vLLM**

Logs: [vllm_deepseek-r1.log](./vllm/logs/vllm-deepseek-r1.log)
Command:
```bash
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=vllm
```

**SGLang**

Logs: [sgl_deepseek-r1.log](./sgl/logs/sgl-deepseek-r1.log)
Command:
```bash
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=sgl
```


<!-- 
**TRT-LLM**
```bash
sky launch --cloud nebius -c benchmark benchmark.yaml
  --env HF_TOKEN
  --env MODEL=deepseek-r1
  --env ENGINE=trt
```
-->

<!-- 
#### Llama-8B


**Output token throughput (tok/s)**

| Input Tokens | Output Tokens | vLLM | SGLang |
| ------------ | ------------- | ------------ | 
|         1000 |          2000 | 4443.01 |
|         5000 |          1000 | 2413.53 |
|        10000 |           500 | 1140.73 |
|        30000 |           100 |  105.23 |
|     sharegpt |      sharegpt | 1978.90 |

 -->


## SGLang

SGLang created a [benchmark](https://github.com/deepseek-ai/sglang/tree/main/benchmark) for SGLang on random input and output.

### Run the benchmarks

```bash
cd ./sgl

sky launch --cloud nebius -c benchmark benchmark.yaml
```
