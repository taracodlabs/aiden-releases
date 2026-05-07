<#
.SYNOPSIS
  Aiden installer for Windows.

.DESCRIPTION
  Verifies Node.js 18+ is on PATH, installs aiden-runtime globally
  via npm, and verifies the `aiden` launcher is available.

.EXAMPLE
  iwr https://aiden.taracod.com/install.ps1 -useb | iex
  # -- or equivalently --
  Invoke-WebRequest https://aiden.taracod.com/install.ps1 -UseBasicParsing | Invoke-Expression
#>

$ErrorActionPreference = "Stop"

# ── Banner ────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "     █████╗ ██╗██████╗ ███████╗███╗   ██╗" -ForegroundColor Yellow
Write-Host "    ██╔══██╗██║██╔══██╗██╔════╝████╗  ██║" -ForegroundColor Yellow
Write-Host "    ███████║██║██║  ██║█████╗  ██╔██╗ ██║" -ForegroundColor Yellow
Write-Host "    ██╔══██║██║██║  ██║██╔══╝  ██║╚██╗██║" -ForegroundColor Yellow
Write-Host "    ██║  ██║██║██████╔╝███████╗██║ ╚████║" -ForegroundColor Yellow
Write-Host "    ╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝" -ForegroundColor Yellow
Write-Host ""
Write-Host "    Local-first AI engine for Windows" -ForegroundColor DarkGray
Write-Host "    aiden.taracod.com" -ForegroundColor DarkGray
Write-Host ""

$Package = "aiden-runtime"

# ── [1/4] Verify Node.js 18+ ─────────────────────────────────────────────────
Write-Host "  [1/4] " -ForegroundColor Yellow -NoNewline
Write-Host "Checking Node.js..."

$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
  Write-Host ""
  Write-Host "  [FAIL] Node.js is not installed." -ForegroundColor Red
  Write-Host ""
  Write-Host "  Aiden requires Node.js 18 or newer."
  Write-Host "  Install Node.js LTS from:"
  Write-Host "    https://nodejs.org/en/download" -ForegroundColor Yellow
  Write-Host ""
  Write-Host "  Or via winget:"
  Write-Host "    winget install OpenJS.NodeJS.LTS" -ForegroundColor Yellow
  Write-Host ""
  Write-Host "  After installing, open a NEW PowerShell and re-run this installer."
  exit 1
}

try {
  $nodeVersion = (& node --version) -replace '^v', ''
  $nodeMajor   = [int]($nodeVersion.Split('.')[0])
} catch {
  Write-Host ""
  Write-Host "  [FAIL] Could not read Node.js version: $_" -ForegroundColor Red
  exit 1
}

if ($nodeMajor -lt 18) {
  Write-Host ""
  Write-Host "  [FAIL] Node.js $nodeVersion detected. Aiden requires 18+." -ForegroundColor Red
  Write-Host ""
  Write-Host "  Upgrade Node.js LTS from:"
  Write-Host "    https://nodejs.org/en/download" -ForegroundColor Yellow
  Write-Host ""
  Write-Host "  Or via winget:"
  Write-Host "    winget install OpenJS.NodeJS.LTS --force" -ForegroundColor Yellow
  exit 1
}
Write-Host "         Node.js   : v$nodeVersion" -ForegroundColor Green

$npm = Get-Command npm -ErrorAction SilentlyContinue
if (-not $npm) {
  Write-Host ""
  Write-Host "  [FAIL] npm not found on PATH." -ForegroundColor Red
  Write-Host "  npm ships with Node.js — try reinstalling Node.js LTS."
  exit 1
}
$npmVersion = (& npm --version)
Write-Host "         npm       : v$npmVersion" -ForegroundColor Green
Write-Host ""

# ── [2/4] Install aiden-runtime globally via npm ─────────────────────────────
Write-Host "  [2/4] " -ForegroundColor Yellow -NoNewline
Write-Host "Installing $Package globally (this takes 30-60 seconds)..."
Write-Host ""

# npm writes deprecation warnings to stderr even on a successful install.
# With `$ErrorActionPreference = "Stop"` set at the top of the script, any
# stderr write from a native command becomes a terminating exception
# (NativeCommandError). Locally relax the preference around the npm call
# so warnings are captured into $npmOutput without throwing — we still
# decide pass/fail from $LASTEXITCODE below.
$npmOutput   = ""
$npmExitCode = 0
$prevEAP     = $ErrorActionPreference
$ErrorActionPreference = "Continue"
try {
  $npmOutput   = & npm install -g $Package 2>&1 | Out-String
  $npmExitCode = $LASTEXITCODE
} catch {
  $npmExitCode = 1
  $npmOutput   = "$($npmOutput)`n[ps-catch] $($_.Exception.Message)"
} finally {
  $ErrorActionPreference = $prevEAP
}

if ($npmExitCode -ne 0) {
  Write-Host ""
  Write-Host "  [FAIL] npm install exited with code $npmExitCode." -ForegroundColor Red
  Write-Host ""

  if ($npmOutput -match "EACCES|EPERM|access denied|Permission denied") {
    Write-Host "  Permission error detected. Two ways to fix:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Option 1 (recommended) — switch npm to a user-writable prefix:"
    Write-Host "    mkdir `"$env:LOCALAPPDATA\npm`""
    Write-Host "    npm config set prefix `"$env:LOCALAPPDATA\npm`""
    Write-Host "    Add `"$env:LOCALAPPDATA\npm`" to your User PATH."
    Write-Host "    Then re-run this installer."
    Write-Host ""
    Write-Host "  Option 2 — re-run PowerShell as Administrator and try again."
  } elseif ($npmOutput -match "ENOTFOUND|getaddrinfo|ECONNREFUSED|network") {
    Write-Host "  Network error. Check your internet connection." -ForegroundColor Yellow
    Write-Host "  If behind a corporate proxy, configure npm:"
    Write-Host "    npm config set proxy http://your-proxy:port"
    Write-Host "    npm config set https-proxy http://your-proxy:port"
  } else {
    Write-Host "  --- npm output ---" -ForegroundColor DarkGray
    Write-Host $npmOutput -ForegroundColor DarkGray
    Write-Host "  ------------------" -ForegroundColor DarkGray
  }
  exit 1
}

Write-Host "         Install complete" -ForegroundColor Green
Write-Host ""

# ── [3/4] Verify aiden is on PATH ────────────────────────────────────────────
Write-Host "  [3/4] " -ForegroundColor Yellow -NoNewline
Write-Host "Verifying installation..."

# Refresh PATH from registry so newly-installed bin is visible in this session.
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "User") + ";" +
            [System.Environment]::GetEnvironmentVariable("PATH", "Machine")

$aidenCmd = Get-Command aiden -ErrorAction SilentlyContinue
$aidenVersion = $null
if ($aidenCmd) {
  try {
    $aidenVersion = (& aiden --version 2>&1 | Out-String).Trim()
  } catch {
    $aidenVersion = $null
  }
}
Write-Host ""

if ($aidenCmd -and $aidenVersion) {
  Write-Host "  ================================================" -ForegroundColor Green
  Write-Host "  SUCCESS  " -ForegroundColor Green -NoNewline
  Write-Host "$Package $aidenVersion installed"
  Write-Host "  ================================================" -ForegroundColor Green
  Write-Host ""
  Write-Host "    Launcher: $($aidenCmd.Source)"
  Write-Host ""

  # ── [4/4] Quick-start prompt ───────────────────────────────────────────────
  Write-Host "  [4/4] " -ForegroundColor Yellow -NoNewline
  Write-Host "How would you like to start Aiden?"
  Write-Host ""
  Write-Host "    [1] " -ForegroundColor Yellow -NoNewline
  Write-Host "Start now      (launch the chat REPL in this terminal)"
  Write-Host "    [2] " -ForegroundColor Yellow -NoNewline
  Write-Host "Later          (I'll start it myself)"
  Write-Host ""
  $choice = Read-Host "  Enter choice (1/2)"

  switch ($choice) {
    '1' {
      Write-Host ""
      Write-Host "  Starting Aiden..." -ForegroundColor Green
      & aiden
    }
    default {
      Write-Host ""
      Write-Host "  Ready when you are." -ForegroundColor DarkGray
      Write-Host "  Open a new terminal and type: " -NoNewline
      Write-Host "aiden" -ForegroundColor Yellow
      Write-Host ""
      Write-Host "  Docs:    https://aiden.taracod.com" -ForegroundColor DarkGray
      Write-Host "  GitHub:  https://github.com/taracodlabs/aiden" -ForegroundColor DarkGray
      Write-Host "  Discord: https://discord.gg/gMZ3hUnQTm" -ForegroundColor DarkGray
      Write-Host ""
    }
  }
} else {
  Write-Host "  ================================================"
  Write-Host "  INSTALLED  " -ForegroundColor Yellow -NoNewline
  Write-Host "$Package installed but 'aiden' is not on PATH yet"
  Write-Host "  ================================================"
  Write-Host ""
  Write-Host "  npm installed the package globally, but the bin directory" -ForegroundColor Yellow
  Write-Host "  is not on this session's PATH yet."
  Write-Host ""
  Write-Host "  Open a NEW PowerShell window and type: " -NoNewline
  Write-Host "aiden" -ForegroundColor Yellow
  Write-Host ""
  Write-Host "  If 'aiden' is still not found, the npm global bin directory"
  Write-Host "  needs to be added to PATH. Find it with:"
  Write-Host "    npm config get prefix"
  Write-Host "  Add that path (or its parent on Windows) to your User PATH."
  Write-Host ""
  Write-Host "  Docs:    https://aiden.taracod.com" -ForegroundColor DarkGray
  Write-Host "  GitHub:  https://github.com/taracodlabs/aiden" -ForegroundColor DarkGray
  Write-Host "  Discord: https://discord.gg/gMZ3hUnQTm" -ForegroundColor DarkGray
  Write-Host ""
}
