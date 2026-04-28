# Aiden Releases

Official installer releases for [Aiden](https://github.com/taracodlabs/aiden)
— local-first AI OS for Windows & Linux.

## Latest: v3.15.0

[![Download](https://img.shields.io/github/v/release/taracodlabs/aiden-releases?color=f97316&label=download)](https://github.com/taracodlabs/aiden-releases/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/taracodlabs/aiden-releases/total?color=f97316)](https://github.com/taracodlabs/aiden-releases/releases)
[![License](https://img.shields.io/badge/license-AGPL--3.0-orange)](https://aiden.taracod.com)
[![Discord](https://img.shields.io/badge/chat-discord-7289da)](https://discord.gg/gMZ3hUnQTm)

---

## Install

### Windows

```powershell
irm aiden.taracod.com/install.ps1 | iex
```

Or [download the installer](https://github.com/taracodlabs/aiden-releases/releases/latest)
manually. Windows 10/11, 64-bit, ~150 MB.

### Linux / WSL / macOS

```bash
curl -fsSL aiden.taracod.com/install.sh | bash
```

Requires Node.js 20+. Installs to `~/.local/share/aiden`.

---

## What's in v3.15.0

- 🌐 **Browser bridge** — centralised Playwright session, persistent context, new `browser_get_url` tool
- 📤 **LocalSend skill** — AirDrop-style LAN file transfer to phone/laptop over WiFi
- 🔒 **Security scanner skill** — opt-in Decepticon integration for your own servers
- 👥 **OSS contributor infrastructure** — CONTRIBUTING.md, issue templates, public roadmap, good-first-issues
- 🛡️ 9 npm audit vulnerabilities fixed; security headers on aiden.taracod.com
- 🔧 CLI fixes: `/sandbox` color error, `/failed` TypeScript error

[Full changelog →](https://github.com/taracodlabs/aiden/blob/main/CHANGELOG.md)

---

## All releases

| Version | Date | Highlights |
|---|---|---|
| [v3.15.0](https://github.com/taracodlabs/aiden-releases/releases/tag/v3.15.0) | 2026-04-28 | Playwright bridge, LocalSend, security scanner, OSS infra |
| [v3.14.0](https://github.com/taracodlabs/aiden-releases/releases/tag/v3.14.0) | 2026-04-27 | OpenAI-compatible API, agentskills.io, streaming tool output |
| [v3.13.0](https://github.com/taracodlabs/aiden-releases/releases/tag/v3.13.0) | 2026-04-27 | Skill registry, deep GEPA, user modeling, Docker sandbox |
| [v3.12.0](https://github.com/taracodlabs/aiden-releases/releases/tag/v3.12.0) | 2026-04-26 | GEPA-lite, memory distillation, real subagents, streaming verbs |
| [v3.11.0](https://github.com/taracodlabs/aiden-releases/releases/tag/v3.11.0) | 2026-04-25 | Custom provider routing, Claude Haiku 4.5 |
| [v3.10.0](https://github.com/taracodlabs/aiden-releases/releases/tag/v3.10.0) | 2026-04-09 | Earlier releases |

---

## Platform support

| Platform | Status | Install method |
|---|---|---|
| Windows 10/11 | ✅ Stable | .exe installer or PowerShell one-liner |
| Linux x64 | ✅ Stable | AppImage / .deb / `install.sh` |
| WSL2 | ✅ Stable | `install.sh` (headless mode) |
| macOS | Planned | — |

---

## Source

[github.com/taracodlabs/aiden](https://github.com/taracodlabs/aiden) —
AGPL-3.0 core · Apache-2.0 skills

---

## Support

- 💝 [Sponsor Aiden](https://razorpay.me/@taracod)
- 💬 [Discord](https://discord.gg/gMZ3hUnQTm)
- 🐛 Release issues (bad installer, signature): open an issue in this repo
- 🐛 Everything else: [taracodlabs/aiden issues](https://github.com/taracodlabs/aiden/issues)

---

Copyright © 2025–2026 Taracod Labs. AGPL-3.0-only.
Built by [Shiva Deore](https://taracod.com) · [Taracod](https://taracod.com)
