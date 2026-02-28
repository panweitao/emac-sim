# MAC 仿真覆盖率说明

## 运行方式

在 `E:\ccode\superpowers\test\sim\run` 下执行 `run.bat` 即可完成仿真并生成覆盖率。

- 覆盖率数据库：`run/coverage.ucdb`
- 详细报告：`run/coverage_report.txt`
- 汇总报告（按实例）：`run/coverage_summary.txt`

## 当前覆盖率（hdl_filelist.v 设计代码）

- **分支覆盖率（Branch）**：约 **73.6%**（899/1222）
- **语句覆盖率（Statement）**：约 **82.2%**（1308/1591）

## 已增补的测试例（与 0100000064/0100000065 同格式）

| 测试例       | 说明 |
|-------------|------|
| 0100000066  | 100M，最小长度帧 64 字节 |
| 0100000067  | 1000M，最大长度帧 1518 字节 |
| 0100000068  | 100M，使能广播过滤（broadcast_filter_en + bucket） |
| 0100000069  | 100M，使能流控暂停帧（pause_frame_send_en/tx_pause_en） |
| 0100000070  | 主机读 Speed/Line_loop_en + RMON 读触发 + 收包 |
| 0100000071  | 100M，使能 CRC 校验（CRC_chk_en） |
| 0100000072  | 100M，混合长度 64/128/256/512/1518 |
| 0100000073  | 1000M，混合长度 64/512/1518 |
| 0100000074  | 100M，xoff_cpu/xon_cpu 流控 |
| 0100000075  | 主机多寄存器读（0–29, 33, 34）+ 收包 |
| 0100000076  | 100M，Rx_er 注入帧（BFM 新增 send_frame_100M_rxerr） |

## 未达 95% 的主要原因

以下模块分支/语句占比较大且多为难触发或需特殊环境，拉低整体覆盖率：

- **MAC_rx_ctrl / MAC_tx_ctrl**：部分分支为长度错误、CRC 错误、异常结束等，需更细的错误注入或边界条件。
- **Ramdon_gen**：与重传退避（Init/RetryCnt）相关，当前全双工无碰撞，难以自然触发。
- **Tx_RMON_addr_gen**：与发送统计计数与读顺序相关，部分地址/状态需更多 TX 场景配合。
- **eth_shiftreg / eth_miim**：MII 管理（MDC/MDIO），需主机侧发起 MIIM 访问才会执行，当前 testbench 未做该激励。

若需逼近或达到 95%，可考虑：

1. 在 BFM 中增加更多错误/边界激励（如 CRC 错、超长/超短帧、持续 Rx_er 等）。
2. 增加半双工/碰撞/重传场景以激活 Ramdon_gen 与 MAC_tx 重试路径。
3. 在 testbench 中增加 MII 管理读写，以覆盖 eth_miim/eth_shiftreg。
4. 对不可达或仅防御性代码做**覆盖率豁免**（waiver），再以豁免后设计计算 95% 目标。
