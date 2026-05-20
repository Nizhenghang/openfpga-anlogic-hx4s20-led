# 自定义 FPGA 结构示意图

本图说明当前项目中“安路 HX4S20 物理 FPGA”和“OpenFPGA 生成的自定义 soft FPGA fabric”之间的层次关系。

```mermaid
flowchart TB
  subgraph BOARD["Anlogic HX4S20 开发板"]
    CLK["板载时钟 CLOCK / R7"]
    LED["板载 LED[3:0] / A4 A3 C10 B12"]

    subgraph WRAPPER["anlogic_openfpga_wrapper"]
      CTRL["配置控制状态机"]
      BIT["内置 fabric_bitstream"]
      DIV["运行时钟分频"]

      subgraph FABRIC["OpenFPGA 自定义 FPGA fabric / fpga_top"]
        CFG["CCFF 配置链"]
        IO["虚拟 GPIO / IO ring"]
        CLB["CLB 阵列：LUT + FF"]
        ROUTE["可配置互连：SB + CBX + CBY + routing channel"]
        USER["映射后的用户电路：led_shift"]
      end
    end
  end

  CLK --> CTRL
  CTRL --> BIT
  BIT --> CFG
  CTRL --> CFG
  DIV --> IO
  CFG --> CLB
  CFG --> ROUTE
  IO --> CLB
  ROUTE --> CLB
  CLB --> USER
  USER --> LED
```

## 层次说明

- HX4S20 是真实物理芯片，负责承载整个 soft FPGA。
- `anlogic_openfpga_wrapper` 是板级封装，负责时钟、复位、配置加载和 LED 映射。
- `fpga_top` 是 OpenFPGA 生成的自定义 FPGA fabric。
- `fabric_bitstream` 通过 CCFF 配置链写入 fabric，使 LUT、FF 和路由网络形成 LED 流水灯电路。
- LED 现象来自 soft FPGA 内部被配置后的用户电路，而不是普通 RTL 直接驱动 LED。
