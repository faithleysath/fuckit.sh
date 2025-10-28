<h1 align="center">fuckit.sh</h1>

<p align="center">
  <a href="./README.en.md">English</a> | <strong>简体中文</strong>
</p>

<p align="center">
  <a href="https://github.com/faithleysath/fuckit.sh/stargazers">
    <img src="https://img.shields.io/github/stars/faithleysath/fuckit.sh?style=social" alt="GitHub Stars">
  </a>
  <a href="https://github.com/faithleysath/fuckit.sh/network/members">
    <img src="https://img.shields.io/github/forks/faithleysath/fuckit.sh?style=social" alt="GitHub Forks">
  </a>
  <a href="https://github.com/faithleysath/fuckit.sh/commits/main">
    <img src="https://img.shields.io/github/last-commit/faithleysath/fuckit.sh" alt="GitHub last commit">
  </a>
  <a href="https://github.com/faithleysath/fuckit.sh/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/faithleysath/fuckit.sh" alt="License">
  </a>
</p>

> [!IMPORTANT]
> **本项目正在重构中**
> 受[Linux.do佬友们](https://linux.do/t/topic/1099746)的启发和建议，此项目将用[Amber](https://amber-lang.com)语言重构，并加入完善的版本管理、更新提示，以及自定义custom，自定义alias、个人偏好设置、ui风格（猫娘、御姐等）等更多新功能。

**我他妈忘了那条命令了。**

`fuckit.sh` 是一个基于 AI 的命令行工具，它能将你的自然语言描述直接转换成可执行的 Shell 命令。

当你懒得去查 `man` 手册或者在 Google 上搜索时，直接 `fuck` 就完事了。

**本项目完全免费，你无需提供自己的 OpenAI API Key 即可直接使用。**


## 预览

![预览](preview.gif)


## 功能特性

*   **自然语言转换**: 直接将你的日常语言转换成可执行的 Shell 命令。
*   **AI 驱动**: 利用大语言模型的强大能力，理解复杂指令。
*   **交互式确认**: 在执行任何命令之前，都会显示并请求你的确认，确保安全。
*   **双模式运行**: 支持一键安装以长期使用，也支持无需安装的临时运行模式。
*   **跨平台支持**: 可在 macOS 和主流 Linux 发行版上运行。
*   **多语言**: 提供完整的中英文双语体验。
*   **智能上下文**: 自动检测操作系统、包管理器等信息，为 AI 提供更准确的上下文。
*   **轻松卸载**: 一条命令即可将脚本从你的系统中完全移除。

---

## 快速安装

选择你喜欢的语言版本，在终端里运行以下命令即可。

### 英文版 (fuckit.sh)

```bash
curl -sS https://fuckit.sh | bash
```

### 中文版 (zh.fuckit.sh)

```bash
curl -sS https://zh.fuckit.sh | bash
```

> [!WARNING]
> **安全提示**
> 
> 如果你不信任直接在 `| bash` 中运行脚本，可以分步操作：
> 1.  **下载**: `curl -o fuckit.sh https://fuckit.sh`
> 2.  **瞅一眼**: `less fuckit.sh`
> 3.  **运行**: `bash fuckit.sh`

安装完成后，请重启你的终端或运行 `source ~/.bashrc` / `source ~/.zshrc` 来让命令生效。

---

## 使用方法

使用起来非常简单，格式如下：

```bash
fuck <你的需求>
```

AI 会返回它认为正确的命令，你确认后即可执行。

**示例:**

```bash
# 查找当前目录下所有大于 10MB 的文件
fuck find all files larger than 10MB in the current directory

# 安装 git (自动识别 apt/yum/brew 等)
fuck install git

# 卸载 git (同样会自动识别)
fuck uninstall git
```

### 卸载脚本

如果你不想用我了，随时可以滚蛋：

```bash
fuck uninstall
```

---

### 临时使用 (无需安装)

如果你不想安装脚本，只想临时用一下，也可以直接通过 `curl` 运行。

**英文版:**
```bash
curl -sS https://fuckit.sh | bash -s "你的需求"
```

**中文版:**
```bash
curl -sS https://zh.fuckit.sh | bash -s "你的需求"
```

**示例:**
```bash
# 查找所有大于 10MB 的文件
curl -sS https://fuckit.sh | bash -s "find all files larger than 10MB"
```

这种方式不会在你的系统上安装任何文件，命令会直接执行。

---

## 工作原理

1.  你在终端输入 `fuck <你的需求>`。
2.  脚本将你的需求和一些基本的系统信息（如操作系统、包管理器）发送到 Cloudflare Worker。
3.  Cloudflare Worker 调用 OpenAI API（或其他大语言模型）并将你的需求作为提示。
4.  AI 返回生成的 Shell 命令。
5.  脚本在终端显示这条命令，并等待你确认。
6.  你输入 `y`，命令被执行。世界和平。

---

## 开发者指南

如果你想自己部署这个项目，或者想对它进行修改，请遵循以下步骤。

### 环境要求

*   [Cloudflare](https://www.cloudflare.com/) 账号
*   [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/install-and-update/)
*   OpenAI API 密钥 (或其他兼容 OpenAI 格式的 API 服务) **(仅在自行部署时需要)**

### 部署步骤

1.  **克隆仓库**

    ```bash
    git clone https://github.com/faithleysath/fuckit.sh.git
    cd fuckit.sh
    ```

2.  **配置 `wrangler.toml`**

    你可以根据需要修改 `wrangler.toml` 文件中的 Worker 名称和路由。

3.  **配置环境变量**

    你需要将你的 OpenAI API 密钥配置到 Cloudflare Worker 的环境变量中。

    ```bash
    npx wrangler secret put OPENAI_API_KEY
    ```

    你还可以设置可选的环境变量：
    *   `OPENAI_API_MODEL`: 指定使用的模型，默认为 `gpt-4-turbo`。
    *   `OPENAI_API_BASE`: 指定 API 的基础 URL，默认为 `https://api.openai.com/v1`。

4.  **构建 `worker.js`**

    `worker.js` 文件需要将 `main.sh` 和 `zh_main.sh` 的内容以 Base64 编码的形式嵌入。我们提供了一个构建命令来自动完成这个过程。

    **macOS:**
    ```bash
    B64_EN=$(base64 -i main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT =.*#const INSTALLER_SCRIPT = b64_to_utf8(\`${B64_EN}\`);#" worker.js && \
    B64_ZH=$(base64 -i zh_main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT_ZH =.*#const INSTALLER_SCRIPT_ZH = b64_to_utf8(\`${B64_ZH}\`);#" worker.js && \
    rm worker.js.bak
    ```

    **Linux:**
    ```bash
    B64_EN=$(base64 -w 0 main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT =.*#const INSTALLER_SCRIPT = b64_to_utf8(\`${B64_EN}\`);#" worker.js && \
    B64_ZH=$(base64 -w 0 zh_main.sh) && sed -i.bak "s#^const INSTALLER_SCRIPT_ZH =.*#const INSTALLER_SCRIPT_ZH = b64_to_utf8(\`${B64_ZH}\`);#" worker.js && \
    rm worker.js.bak
    ```

5.  **发布 Worker**

    ```bash
    npx wrangler deploy
    ```

部署成功后，你的 Worker 就会在你配置的域名上运行。

---

## 许可证

本项目采用 MIT 许可证。详情请见 [LICENSE](LICENSE) 文件。

---

## Star History

[![Star History Chart](https://app.repohistory.com/api/svg?repo=faithleysath/fuckit.sh&type=Date&background=FFFFFF&color=f86262)](https://app.repohistory.com/star-history)
