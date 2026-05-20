# 项目完整流程

## 1. 设计用户电路

用户电路是一个 LED 流水灯逻辑，目标输出为 4 路 LED one-hot 变化。

## 2. OpenFPGA 映射

在 WSL 中使用 OpenFPGA flow，将用户电路映射到自定义 FPGA 架构。OpenFPGA 生成的关键结果包括：

- `fpga_top.v`：自定义 FPGA fabric 顶层。
- `fabric_bitstream.bit`：配置该 fabric 的 bitstream。
- `fabric_independent_bitstream.xml`：与具体 fabric 结构对应的配置描述。

## 3. 面向 TD 做兼容处理

原始 OpenFPGA Verilog 不能直接稳定导入 TD，因此进行了兼容化处理：

- 合并 OpenFPGA 生成的多文件 netlist。
- 移除或规避 TD 不支持的三态/高阻写法。
- 将 pass-gate 风格 mux 改为普通逻辑 mux。
- 去除综合中不适合的随机或测试平台行为。
- 增加安路板级 wrapper，用于配置加载和 LED 可视化。

最终 TD 只需要导入：

- `td/anlogic_openfpga_onehot_led.v`
- `td/anlogic_openfpga_wrapper.adc`

## 4. 在 TD 中实现

TD 工程设置：

- 顶层模块：`anlogic_openfpga_wrapper`
- Verilog 源：`td/anlogic_openfpga_onehot_led.v`
- 约束文件：`td/anlogic_openfpga_wrapper.adc`

完成综合、布局布线、bitstream 生成后下载到 HX4S20 开发板。

## 5. 实验验证

预期现象：4 个 LED 依次单独点亮，形成流水灯效果。

如果出现多个灯同时闪烁，优先检查：

- 是否导入了旧版本 Verilog 文件。
- 是否将顶层设置为 `anlogic_openfpga_wrapper`。
- 是否使用了本仓库 `td/` 目录下的 ADC 约束。
- TD 工程中是否混入了测试平台或旧 wrapper 文件。

## 6. 后续可扩展方向

- 替换 `led_shift` 为新的用户电路。
- 重新运行 OpenFPGA flow 生成新的 bitstream。
- 更新 wrapper 中内嵌或加载的 fabric bitstream。
- 根据目标板卡修改 ADC 管脚约束。
- 若切换 FPGA 厂商，重新处理约束文件、时钟资源、IO 规范和综合工具兼容问题。
