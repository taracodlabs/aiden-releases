# DevOS — Aiden Releases

Signed installers and install scripts for [DevOS — Aiden](https://github.com/taracodlabs/aiden),
the local-first AI operating system.

**Current:** v3.11.0 — custom provider routing + Claude Haiku 4.5  
**Platforms:** Windows 10/11 · Linux x64 (AppImage / .deb / source) · WSL2

---

## Download

**Latest release:** https://github.com/taracodlabs/aiden-releases/releases/latest

### Windows (signed installer)

```powershell
irm aiden.taracod.com/install.ps1 | iex
```

Or download `Aiden-Setup-3.11.0.exe` directly from the latest release above.

### Linux — native packages (recommended)

**AppImage (any distro, no install required):**

```bash
chmod +x Aiden-3.11.0.AppImage
./Aiden-3.11.0.AppImage
```

**Debian / Ubuntu (.deb):**

```bash
sudo dpkg -i devos-ai_3.11.0_amd64.deb
# Launch: Aiden (app menu) or /opt/Aiden/devos-ai
```

Download both from the [latest release](https://github.com/taracodlabs/aiden-releases/releases/latest).

### Linux / WSL — source / CLI install (fallback)

```bash
curl -fsSL aiden.taracod.com/install.sh | bash
```

Requires Node.js 20+. Installs to `~/.local/share/aiden`.
Symlinks binary to `~/.local/bin/aiden`. Runs in headless
mode (no Electron, just API + CLI).

---

## What is Aiden?

A local-first AI operating system with:

- **70+ skills** (trading, research, development, security, creative)
- **80+ tools** (file, shell, browser, vision, voice, git, web search)
- **14+ LLM providers** with self-healing fallback chain (Groq, Gemini, OpenRouter, Anthropic, OpenAI, Together, DeepSeek, Cerebras, Ollama, and more)
- **6-layer memory system** (semantic, episodic, entity graph, learning, facts, hot/cold)
- **Full offline mode** via Ollama
- **Multi-channel**: Discord, Slack, Webhook, WhatsApp, Signal, SMS, iMessage, Email
- Open source under AGPL-3.0

---

## Platform support

| Platform | Status | Install method | Skill count |
| -------- | ------ | -------------- | ----------- |
| Windows 10/11 | Stable | .exe installer | 70+ / 70+ |
| Linux x64 | Native | AppImage / .deb | 61 / 70+ |
| Linux x64 | Source | curl install.sh | 61 / 70+ |
| WSL2 | Source | curl install.sh | 61 / 70+ |
| macOS | Planned (v4.0+) | — | — |

On Linux/WSL, 9 Windows-specific skills are auto-gated at load:
`clipboard-history`, `defender-quickscan`, `onenote`, `outlook-native`,
`powershell-pro`, `taskscheduler`, `windows-registry`, `windows-services`,
`wsl-bridge`.

---

## Links

[![Latest Release](https://img.shields.io/github/v/release/taracodlabs/aiden-releases?color=f97316&label=latest)](https://github.com/taracodlabs/aiden-releases/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/taracodlabs/aiden-releases/total?color=f97316&label=downloads)](https://github.com/taracodlabs/aiden-releases/releases)
[![License](https://img.shields.io/badge/license-AGPL--3.0-orange)](https://aiden.taracod.com)
[![Discord](https://img.shields.io/badge/chat-discord-7289da)](https://discord.gg/gMZ3hUnQTm)

- **Source code:** https://github.com/taracodlabs/aiden
- **Landing page:** https://aiden.taracod.com
- **Discord:** https://discord.gg/gMZ3hUnQTm
- **Issues:** https://github.com/taracodlabs/aiden/issues
- **Contact:** contact@taracod.com

Release-specific issues (bad installer, signature problems,
corrupt download) — open an issue in this repo.  
Everything else — open an issue in the main [aiden](https://github.com/taracodlabs/aiden) repo.

---

Copyright © 2025–2026 Taracod Labs. AGPL-3.0-only.  
Built by [Shiva Deore](https://taracod.com) · [Taracod](https://taracod.com)
