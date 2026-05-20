# 资源占用

以下数据来自当前 TD 工程综合/布局布线报告。

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

## 说明

这些资源不是 LED 流水灯本身的直接开销，而是整个 OpenFPGA soft fabric 加上板级 wrapper 的开销。普通流水灯只需要极少量逻辑；本项目的重点是验证“在安路 FPGA 上承载一个自定义 FPGA fabric，并在该 fabric 上运行用户电路”。

因此，资源消耗主要来自：

- 自定义 FPGA 的可配置逻辑块。
- 可配置路由网络。
- CCFF 配置链。
- wrapper 中的配置加载、复位、时钟分频和 LED 映射逻辑。
