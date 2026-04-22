# DevOS — Aiden Releases

Signed installers and install scripts for [DevOS — Aiden](https://github.com/taracodlabs/aiden),
the local-first AI operating system.

**Current:** v3.8.0 — Linux/WSL support (source install)  
**Platforms:** Windows 10/11 · Linux (Ubuntu 22.04+) · WSL2

---

## Download

**Latest release:** https://github.com/taracodlabs/aiden-releases/releases/latest

### Windows (signed installer)

```powershell
irm aiden.taracod.com/install.ps1 | iex
```

Or download `Aiden-Setup-x.y.z.exe` directly from the latest release above.

### Linux / WSL (source install)

```bash
curl -fsSL aiden.taracod.com/install.sh | bash
```

Requires Node.js 20+. Installs to `~/.local/share/aiden`.
Symlinks binary to `~/.local/bin/aiden`. Runs in headless
mode (no Electron, just API + CLI).

Native Linux AppImage / .deb packaging coming in v3.9.

---

## What is Aiden?

A local-first AI operating system with:

- **69 skills** (trading, research, development, security, creative)
- **80+ tools** (file, shell, browser, vision, voice, git, web search)
- **13 LLM providers** with self-healing fallback chain (Groq, Gemini, OpenRouter, Anthropic, OpenAI, Together, DeepSeek, Cerebras, Ollama, and more)
- **6-layer memory system** (semantic, episodic, entity graph, learning, facts, hot/cold)
- **Full offline mode** via Ollama
- **Multi-channel**: Discord, Slack, Webhook, WhatsApp, Signal, SMS, iMessage, Email
- Open source under AGPL-3.0

---

## Platform support

| Platform | Status | Skill count |
| -------- | ------ | ----------- |
| Windows 10/11 | Stable | 69 / 69 |
| Linux (Ubuntu 22.04+) | Source install | 58 / 69 |
| WSL2 | Source install | 58 / 69 |
| macOS | Planned (v3.9+) | — |

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