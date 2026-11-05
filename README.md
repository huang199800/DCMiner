<div align="center">

# DCMiner

**面向矿机、矿场与矿池节点的全链路管理方案**

[![Version](https://img.shields.io/github/v/release/huang199800/DCMiner)](https://github.com/huang199800/DCMiner/releases)
[![Install verification](https://github.com/huang199800/DCMiner/actions/workflows/release.yml/badge.svg)](https://github.com/huang199800/DCMiner/actions/workflows/release.yml)

[下载安装](#快速安装) · [版本下载](https://github.com/huang199800/DCMiner/releases) · [问题反馈](https://github.com/huang199800/DCMiner/issues)

</div>

## 项目介绍

DCMiner 是基于 先进 的定制发行版本，可用于传统矿池代理、矿机与矿场管理、多线路转发及矿池节点部署。本仓库托管安装脚本，主程序与 CLI 通过本仓库 GitHub Releases 分发。

介绍与算法列表参考 先进代理程序。本次迁移保持定制主程序原始字节，不表示其内部界面、授权、节点或业务服务全部迁移至本仓库。

## 核心能力

| 能力 | 说明 |
| --- | --- |
| 传统矿池代理 | 管理矿机连接、端口与转发策略 |
| 自建矿池节点 | 支持节点与矿场运维场景 |
| 自定义费率 | 根据业务需要配置钱包与比例 |
| 安全传输 | 可配合上游 RMS 客户端使用加密、压缩传输 |
| 可视化后台 | 查看运行状态、端口、矿工及统计信息 |
| 命令行管理 | 可选 CLI 管理工具与服务启停命令 |

## 快速安装

当前提供 **Linux x86_64 / amd64** 版本 `6.4.2`，推荐 Ubuntu，使用 root 运行。ARM、ARMV7 和 Windows 不在本次发行范围内。

```bash
bash <(curl -fsSL --retry 3 https://raw.githubusercontent.com/huang199800/DCMiner/main/install.sh)
```

也可使用 GitHub 仓库地址：

```bash
bash <(curl -fsSL --retry 3 https://github.com/huang199800/DCMiner/raw/refs/heads/main/install.sh)
```

选择语言后，输入 `1` 安装。安装完成后使用终端显示的地址访问后台。

默认账号：`qzpm19kkx`；默认密码：`xloqslz913`。首次登录后立即修改账号密码，限制后台端口访问。脚本保留上游关闭主机防火墙的行为；云服务器安全组仍需自行设置。

安装目录：`/root/DCMiner`。服务名称：`DCMinerservice`。使用 CLI 时，在安装菜单选择 `22`，确认后会关闭 Web 后台；安装完成后运行 `rustminer`。

```bash
rustminer start
rustminer stop
rustminer restart
```

脚本需要 `curl` 或 `wget`、`sha256sum`、`pgrep` 等常用工具。Ubuntu 若提示缺失，可执行：

```bash
apt-get update && apt-get install -y curl ca-certificates coreutils procps iproute2
```

## 下载与校验

主程序和 CLI 均从 [本仓库 Releases](https://github.com/huang199800/DCMiner/releases/tag/v6.4.2) 下载，安装时校验固定 SHA256。当前只提供 `6.4.2`，指定其他版本会提示未发布。

- 主程序：`DCMiner-6.4.2`
- 命令行工具：`RustMinerSystemCLI-0.1.0`
- 校验清单：`SHA256SUMS`

`release-manifest.json` 记录迁移来源与哈希，仅供维护发行使用；用户安装流程无需访问原作者的软件下载服务器。

## 文档

- [上游使用文档](https://minerproxy.org/zh/document)
- [上游 CLI 文档](https://minerproxy.org/zh/document/rustminersystem-cli)
- [RMS 配套客户端](https://github.com/EvilGenius-dot/RMS)
- [上游服务协议](https://rustminersystem.gitbook.io/rustminersystem/guan-yu/fu-wu-xie-yi)

## 支持算法与币种

以下列表引用上游介绍，实际可用范围取决于定制程序版本、配置和业务服务。

<details>
<summary>展开查看算法列表</summary>

| 算法 | 支持币种 |
| --- | --- |
| SHA256 | BTC、BCH、SPACE |
| ETHASH | ETC、ETHW、ETHF、OCTA、ETC+ZIL、ETHW+ZIL、ETHF+ZIL、CLORE、NEURAI、NEOXA、ZIL、CLO、UBQ、EGAZ、ELH、AVS、CAU、PAC、PWR、BTN、DUBX、XPB、REDEV2、RTH、DOGETHER |
| SCRYPT | LTC、BEL |
| KHEAVYHASH | KASPA、PYI、SDR |
| KARLSENHASH | KLS |
| BLAKE2S | KDA |
| BLAKE2B | SC、HNS |
| OCTOPUS | CFX |
| DYNEXSOLVE | DNX |
| EAGLESONG | CKB |
| EQUIHASH | ZEN、ZEC |
| LBRY | LBC |
| X11 | DASH、BLOCX |
| PROGPOW | SERO |
| BLAKE3 | ALPH、IRON |
| RANDOMX | XMR、ZEPH、NEVO |
| KAWPOW | RVN、MEWC、AIPG |
| SHA512256D | RXD |
| AUTOYKOS2 | ERG |
| NEXAPOW | NEXA |
| GHOSTRIDER | RTM、RTC、MECU、MAXE、NIKI、SUBI、NEVO |
| CUCKATOO32 | GRIN |

</details>


## 发行验证

GitHub Actions 在临时 Linux 容器中验证本仓库安装入口、主程序启动、Web 响应、CLI 安装及启停，Ubuntu 22.04 与 24.04 分别执行。验证通过不代表二进制程序经过完整安全审计。

## 来源与许可

介绍参考，保留 [上游 MIT 许可](LICENSE.upstream) 与版权声明。定制程序及其业务服务的使用仍应遵守对应服务协议。

