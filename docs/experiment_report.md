# 基于 OpenFPGA 与安路 HX4S20 的自定义 FPGA 流水灯实验报告

## 一、实验题目

基于 OpenFPGA 的自定义 FPGA 结构生成与安路 HX4S20 平台部署验证。

## 二、实验目的

本实验的目标不是在 FPGA 开发板上直接实现一个普通流水灯，而是完成一条从自定义 FPGA 结构生成到物理 FPGA 板级验证的完整流程。通过本实验，需要达到以下目的：

1. 理解 FPGA 的基本组成，包括可配置逻辑块、可配置互连网络、IO 结构和配置链。
2. 掌握使用 OpenFPGA 生成自定义 FPGA fabric 的基本流程。
3. 将一个简单用户电路映射到自定义 FPGA fabric 中，并生成对应配置 bitstream。
4. 将 OpenFPGA 生成的 soft FPGA fabric 移植到国产安路 HX4S20 FPGA 上进行综合、布局布线和下载验证。
5. 通过 LED 流水灯实验现象验证自定义 FPGA 的配置与运行结果。

## 三、实验平台与工具

### 3.1 硬件平台

实验使用安路 HX4S20 FPGA 开发板作为物理承载平台。开发板提供板载时钟输入和 4 路 LED 输出，本实验将 OpenFPGA 生成的自定义 FPGA fabric 综合到 HX4S20 芯片中运行。

本实验使用的板级 IO 如下：

| 信号 | 管脚 | 说明 |
| --- | --- | --- |
| `CLOCK` | `R7` | 板载时钟输入 |
| `LED[0]` | `A4` | 板载 LED 输出 |
| `LED[1]` | `A3` | 板载 LED 输出 |
| `LED[2]` | `C10` | 板载 LED 输出 |
| `LED[3]` | `B12` | 板载 LED 输出 |

### 3.2 软件平台

实验使用的软件和工具包括：

| 工具 | 作用 |
| --- | --- |
| WSL | 运行 OpenFPGA 编译与生成流程 |
| OpenFPGA | 生成自定义 FPGA fabric、配置链和 bitstream |
| Anlogic TD | 对 HX4S20 工程进行综合、布局布线、bitstream 生成和下载 |
| Git / GitHub | 管理和开源实验工程 |

## 四、实验原理

### 4.1 普通 FPGA 实现与本实验实现方式的区别

普通流水灯实验通常直接使用 Verilog 描述计数器和移位寄存器，再由 FPGA 厂商工具综合到物理芯片内部。此时用户逻辑直接由物理 FPGA 的 LUT、触发器和布线资源实现。

本实验采用不同方式：先使用 OpenFPGA 生成一个自定义 FPGA fabric，再把这个 fabric 作为普通 Verilog 逻辑综合到安路 HX4S20 芯片中。流水灯用户电路不是直接由 HX4S20 的原生资源实现，而是先被 OpenFPGA 映射到自定义 FPGA fabric 内部，再通过 fabric bitstream 配置后运行。

因此，本实验中存在两层 FPGA：

1. 物理 FPGA：安路 HX4S20，用于承载整个 soft FPGA。
2. 自定义 FPGA：OpenFPGA 生成的 soft FPGA fabric，用于承载流水灯用户电路。

### 4.2 自定义 FPGA fabric 的组成

本实验中的自定义 FPGA 主要由以下部分组成：

- **CLB（Configurable Logic Block）**：可配置逻辑块，是实现组合逻辑和时序逻辑的核心单元。
- **FLE / LUT / FF**：每个逻辑单元内部包含查找表和触发器，用于实现具体逻辑函数和寄存器。
- **Routing Channel**：可配置布线通道，用于连接不同逻辑块和 IO。
- **Switch Block / Connection Block**：实现布线资源之间、布线资源与逻辑块之间的可配置连接。
- **IO Ring**：连接 fabric 内部信号与外部板级 IO。
- **CCFF 配置链**：用于写入配置 bitstream，决定 LUT 内容、互连选择和用户电路功能。

### 4.3 配置 bitstream 的作用

OpenFPGA 生成的 `fabric_bitstream.bit` 用于配置自定义 FPGA fabric。该 bitstream 通过 wrapper 中的配置控制逻辑写入 CCFF 配置链。配置完成后，fabric 内部的 LUT、触发器和互连网络被设置为目标用户电路，即 LED 流水灯逻辑。

### 4.4 顶层封装的作用

本实验在 OpenFPGA 生成的 `fpga_top` 外部增加了 `anlogic_openfpga_wrapper`。该模块是 TD 工程中的顶层模块，主要完成以下功能：

- 接收开发板时钟输入。
- 对运行时钟进行分频，使 LED 变化速度肉眼可见。
- 控制 fabric 的复位和配置加载过程。
- 将内置 bitstream 写入 OpenFPGA fabric。
- 将 fabric 输出映射到板载 LED。

## 五、实验工程结构

本项目已经整理为可开源的 GitHub 工程，主要目录如下：

```text
openfpga-anlogic-hx4s20-led/
├── td/
│   ├── anlogic_openfpga_onehot_led.v
│   └── anlogic_openfpga_wrapper.adc
├── openfpga_artifacts/
│   ├── fpga_top.v
│   ├── fabric_bitstream.bit
│   └── fabric_independent_bitstream.xml
├── native_led_test/
│   ├── hx4s20_led_chase.v
│   └── hx4s20_led_chase.adc
├── docs/
│   ├── custom_fpga_structure_diagram.svg
│   ├── custom_fpga_structure_diagram.md
│   ├── resource_usage.md
│   ├── workflow.md
│   └── experiment_report.md
├── README.md
├── LICENSE
└── .gitignore
```

其中，TD 工程中实际需要导入的文件是：

- `td/anlogic_openfpga_onehot_led.v`
- `td/anlogic_openfpga_wrapper.adc`

顶层模块应设置为：

```verilog
anlogic_openfpga_wrapper
```

## 六、实验步骤

### 6.1 编写用户电路

首先设计一个 4 路 LED 流水灯用户电路。该电路的目标是让 4 个 LED 按固定顺序依次点亮，形成 one-hot 流水灯效果，即任意时刻主要只有一个 LED 被点亮。

该用户电路作为 OpenFPGA flow 的输入设计，后续会被映射到自定义 FPGA fabric 中。

### 6.2 使用 OpenFPGA 生成自定义 FPGA

在 WSL 环境中运行 OpenFPGA flow，将用户电路映射到指定 FPGA 架构。生成的关键文件包括：

| 文件 | 作用 |
| --- | --- |
| `fpga_top.v` | OpenFPGA 生成的自定义 FPGA fabric 顶层 |
| `fabric_bitstream.bit` | 配置 fabric 的 bitstream |
| `fabric_independent_bitstream.xml` | 与 fabric 无关或半独立的 bitstream 描述 |
| `openfpgashell.log` | OpenFPGA shell 运行日志 |
| `vpr_stdout.log` | VPR 映射、布局、布线输出日志 |

本实验最终保留了核心可复现实验文件，并将其整理到 `openfpga_artifacts/` 目录。

### 6.3 面向 TD 进行兼容化处理

OpenFPGA 原始生成的 Verilog 结构较复杂，并且其中部分语法或建模方式不适合直接导入 TD 综合。实验过程中对生成文件进行了以下处理：

1. 将 OpenFPGA 生成的多文件 netlist 合并为 TD 便于导入的单文件。
2. 避免 TD 对 `include` 路径解析不一致造成的文件缺失问题。
3. 处理三态、高阻和 pass-gate 风格 mux 等综合兼容问题。
4. 移除测试平台、随机行为等不应进入综合工程的内容。
5. 增加安路板级 wrapper，使 OpenFPGA fabric 能在 HX4S20 开发板上完成配置和可视化输出。
6. 将 LED 输出调整为 one-hot 显示方式，使实验现象更符合“流水灯”要求。

最终得到 TD 可直接导入的文件：

```text
td/anlogic_openfpga_onehot_led.v
```

### 6.4 创建 TD 工程

在 Anlogic TD 中新建工程，选择与开发板一致的 HX4S20 器件型号。随后导入 Verilog 源文件：

```text
td/anlogic_openfpga_onehot_led.v
```

设置工程顶层模块为：

```text
anlogic_openfpga_wrapper
```

顶层模块的含义是：TD 从该模块开始分析整个硬件设计。由于 `anlogic_openfpga_wrapper` 内部例化了 OpenFPGA 生成的 `fpga_top`，并负责板级时钟、复位、配置和 LED 映射，所以它必须作为 TD 工程顶层。

### 6.5 添加约束文件

向 TD 工程中添加 ADC 约束文件：

```text
td/anlogic_openfpga_wrapper.adc
```

该约束文件指定了时钟和 LED 对应的物理管脚：

```text
set_pin_assignment { CLOCK } { LOCATION = R7; IOSTANDARD = LVCMOS33; PULLTYPE = PULLUP; }
set_pin_assignment { LED[0] } { LOCATION = A4; IOSTANDARD = LVCMOS33; DRIVESTRENGTH = 8; PULLTYPE = NONE; }
set_pin_assignment { LED[1] } { LOCATION = A3; IOSTANDARD = LVCMOS33; DRIVESTRENGTH = 8; PULLTYPE = NONE; }
set_pin_assignment { LED[2] } { LOCATION = C10; IOSTANDARD = LVCMOS33; DRIVESTRENGTH = 8; PULLTYPE = NONE; }
set_pin_assignment { LED[3] } { LOCATION = B12; IOSTANDARD = LVCMOS33; DRIVESTRENGTH = 8; PULLTYPE = NONE; }
```

### 6.6 综合、布局布线与下载

完成源文件和约束文件导入后，在 TD 中依次执行：

1. Synthesis：综合。
2. Place & Route：布局布线。
3. Generate Bitstream：生成下载文件。
4. Program Device：将 bitstream 下载到 HX4S20 开发板。

下载完成后观察板载 LED 的变化。

## 七、实验结果

### 7.1 板级现象

下载完成后，开发板上 4 个 LED 按规律依次闪烁。经过调整后，实验现象满足 one-hot 流水灯要求：每次主要只有一个 LED 点亮，随后按顺序切换到下一个 LED。

该现象说明：

1. TD 工程能够正确综合 OpenFPGA 生成的 soft FPGA fabric。
2. `anlogic_openfpga_wrapper` 能够完成配置加载和运行控制。
3. `fabric_bitstream.bit` 已正确写入自定义 FPGA fabric 的配置链。
4. 用户流水灯电路已经在自定义 FPGA 内部运行，并通过板载 LED 输出。

### 7.2 资源占用

TD 报告中的主要资源占用如下：

| 资源 | 数量 |
| --- | ---: |
| LUT | 1741 |
| Sequential cells | 2043 |
| Pads | 5 |
| BRAM | 0 |
| DSP | 0 |
| Packed mslices | 631 |
| Packed lslices | 632 |
| 面积利用率 | 约 16% |

需要注意的是，这些资源并不代表一个普通 LED 流水灯的资源开销。普通流水灯只需要少量计数器和寄存器，而本实验综合的是整个自定义 FPGA fabric、配置链、路由网络和 wrapper。因此资源消耗主要来自 soft FPGA 本身。

## 八、问题与解决过程

### 8.1 下载后未出现预期流水灯现象

最初工程下载到板子后没有出现流水灯，主要排查方向包括：

- 顶层模块是否设置正确。
- 是否导入了正确版本的 Verilog 文件。
- 是否导入了 ADC 管脚约束。
- TD 工程中是否误加入了测试平台文件。
- OpenFPGA 生成的 Verilog 是否存在 TD 不兼容语法。

最终确认应使用 `anlogic_openfpga_wrapper` 作为顶层，并只导入经过 TD 兼容化处理的单文件 Verilog。

### 8.2 TD 工程导入文件混乱

OpenFPGA 会生成多个源文件、测试平台和中间文件。如果全部导入 TD，容易导致顶层识别错误、重复定义或综合无关模块。解决方法是整理出 TD 专用文件：

```text
td/anlogic_openfpga_onehot_led.v
td/anlogic_openfpga_wrapper.adc
```

TD 工程只导入这两个关键文件，避免把测试平台或旧版本 wrapper 混入工程。

### 8.3 LED 不是单灯依次点亮

实验中曾出现多个 LED 按规律同时闪烁的现象。该现象虽然说明 fabric 内部逻辑在运行，但不符合预期的流水灯表现。后续通过修改 LED 映射和显示逻辑，将输出调整为 one-hot 方式，使 4 个 LED 依次单独点亮。

### 8.4 OpenFPGA Verilog 与 TD 兼容性问题

OpenFPGA 生成的部分结构更偏向通用 Verilog 仿真或其他综合工具，不一定完全适合 TD。实验中针对 TD 做了兼容化处理，包括：

- 处理高阻和三态相关逻辑。
- 将 pass-gate mux 改写为普通逻辑 mux。
- 避免综合测试平台代码。
- 合并源文件，减少路径和 include 解析问题。

这些处理是本实验能够在安路平台上运行的关键步骤。

## 九、实验分析

### 9.1 本实验中“自定义 FPGA”的体现

本实验的自定义 FPGA 不是指安路 HX4S20 芯片本身，而是指由 OpenFPGA 生成并部署在 HX4S20 内部的一套 soft FPGA fabric。它具有自己的逻辑块、互连资源、IO 映射和配置链。

流水灯用户电路先被 OpenFPGA 映射到该 fabric 中，再通过 `fabric_bitstream.bit` 配置 fabric 后运行。因此，LED 的变化现象是自定义 FPGA 被正确配置后的结果。

### 9.2 与直接 Verilog 流水灯的区别

如果直接编写 Verilog 流水灯，TD 会直接把计数器和 LED 输出综合到 HX4S20 的原生 LUT 和触发器中。

而本实验中，TD 综合的是一个“可配置硬件平台”。流水灯逻辑被编码进 OpenFPGA 的 bitstream，并在这个 soft FPGA 内部运行。因此，本实验更接近“设计一个小型 FPGA 并在真实 FPGA 上验证它”的流程。

### 9.3 可移植性分析

理论上，OpenFPGA 生成的 soft FPGA fabric 是普通 Verilog 描述，因此可以移植到其他 FPGA 厂商平台。但是实际迁移时需要修改或重新验证以下内容：

- 顶层 wrapper 的时钟、复位和配置控制。
- 管脚约束文件，例如 ADC、XDC、SDC、QSF 等。
- IO 电平标准和板级资源连接。
- 综合工具对 Verilog 语法和结构的支持情况。
- 时序约束和时钟资源。
- 下载流程和 bitstream 生成方式。

因此，该项目具有跨厂商迁移可能性，但不能直接无修改部署到所有平台。

## 十、实验结论

本实验完成了从 OpenFPGA 自定义 FPGA 生成，到安路 HX4S20 平台综合、布局布线、下载验证的完整流程。实验最终实现了 4 路 LED one-hot 流水灯效果，验证了 OpenFPGA 生成的 soft FPGA fabric 能够在国产安路 FPGA 上运行。

通过本实验可以得出以下结论：

1. OpenFPGA 可以生成具有可配置逻辑、可配置互连和配置链的自定义 FPGA fabric。
2. 该 fabric 可以作为普通 Verilog 逻辑综合到物理 FPGA 中。
3. 通过 wrapper 可以实现板级时钟、复位、配置加载和 IO 映射。
4. 用户电路可以通过 OpenFPGA bitstream 配置到自定义 FPGA 中运行。
5. 在具体 FPGA 厂商工具中部署时，需要处理综合兼容性、约束文件和板级适配问题。

本实验的核心意义在于，它不只是完成了一个流水灯，而是验证了一条“自定义 FPGA 架构生成、用户电路映射、bitstream 配置、物理 FPGA 承载运行”的完整技术路线。

## 十一、开源地址

本实验工程已整理并上传到 GitHub：

```text
https://github.com/Nizhenghang/openfpga-anlogic-hx4s20-led
```

仓库中包含 TD 可导入文件、OpenFPGA 关键生成物、资源占用说明、结构示意图和实验流程文档。
