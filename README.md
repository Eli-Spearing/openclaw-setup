# 🐾 OpenClaw Quick Setup

One command to install everything you need to run [OpenClaw](https://docs.openclaw.ai) — your AI assistant that lives in Telegram.

## What it installs

| Tool | Why |
|------|-----|
| **Git** | Version control |
| **Python 3** | Scripting & automation |
| **Node.js** | Required runtime for OpenClaw |
| **OpenClaw** | Your AI assistant |

## Install

### Mac / Linux
Open Terminal and paste:
```bash
curl -fsSL https://raw.githubusercontent.com/Eli-Spearing/openclaw-setup/main/install.sh | bash
```

### Windows
Open PowerShell and paste:
```powershell
irm https://raw.githubusercontent.com/Eli-Spearing/openclaw-setup/main/install.ps1 | iex
```

That's it. One command.

## After install

1. Run `openclaw wizard` to set up your config
2. You'll need:
   - An **Anthropic API key** (or OpenRouter key) — [get one here](https://console.anthropic.com/)
   - A **Telegram Bot Token** — [create one with @BotFather](https://t.me/BotFather)
3. Start it: `openclaw start`
4. Message your bot on Telegram — you're live!

## Windows

Use [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows Subsystem for Linux), then run the same command above.

## Links

- 📖 [OpenClaw Docs](https://docs.openclaw.ai)
- 💬 [Discord Community](https://discord.com/invite/clawd)
- 🐙 [OpenClaw GitHub](https://github.com/openclaw/openclaw)
