#!/usr/bin/env bash
set -euo pipefail

# Aiden Linux/WSL installer
# Usage: curl -fsSL aiden.taracod.com/install.sh | bash

REPO="taracodlabs/aiden"
INSTALL_DIR="${AIDEN_INSTALL_DIR:-$HOME/.local/share/aiden}"
BIN_DIR="${AIDEN_BIN_DIR:-$HOME/.local/bin}"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[aiden]${NC} $*"; }
warn()  { echo -e "${YELLOW}[aiden]${NC} $*"; }
error() { echo -e "${RED}[aiden]${NC} $*" >&2; }

# Platform check
if [[ "$OSTYPE" != "linux-gnu"* && "$OSTYPE" != "darwin"* ]]; then
  error "Unsupported platform: $OSTYPE"
  error "Aiden Linux installer supports Linux and WSL only."
  error "For Windows, use: irm aiden.taracod.com/install.ps1 | iex"
  exit 1
fi

# Prerequisites
info "Checking prerequisites..."

if ! command -v git >/dev/null 2>&1; then
  error "git not found. Please install: sudo apt install git"
  exit 1
fi

if ! command -v node >/dev/null 2>&1; then
  error "Node.js not found. Install Node.js 20+ from:"
  error "  https://nodejs.org  OR  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt install nodejs"
  exit 1
fi

NODE_MAJOR=$(node -v | sed 's/v\([0-9]*\).*/\1/')
if [[ "$NODE_MAJOR" -lt 20 ]]; then
  error "Node.js 20+ required. You have: $(node -v)"
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  error "npm not found. Please install npm."
  exit 1
fi

info "Prerequisites OK: git, node $(node -v), npm $(npm -v)"

# Clone or update
if [[ -d "$INSTALL_DIR/.git" ]]; then
  info "Updating existing installation at $INSTALL_DIR..."
  cd "$INSTALL_DIR"
  git fetch origin main
  git reset --hard origin/main
else
  info "Cloning Aiden to $INSTALL_DIR..."
  mkdir -p "$(dirname "$INSTALL_DIR")"
  git clone --depth 1 "https://github.com/${REPO}.git" "$INSTALL_DIR"
  cd "$INSTALL_DIR"
fi

# Install dependencies
info "Installing dependencies (this may take a few minutes)..."
npm install --silent

# Build
info "Building..."
npm run build

# Install binary symlink
mkdir -p "$BIN_DIR"
cat > "$BIN_DIR/aiden" <<EOF
#!/usr/bin/env bash
export AIDEN_HEADLESS=true
cd "$INSTALL_DIR"
exec node "$INSTALL_DIR/dist-bundle/cli.js" "\$@"
EOF
chmod +x "$BIN_DIR/aiden"

# Check PATH
if ! echo ":$PATH:" | grep -q ":$BIN_DIR:"; then
  warn "Add $BIN_DIR to your PATH:"
  warn "  echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.bashrc"
  warn "  source ~/.bashrc"
fi

echo
info "Aiden installed at $INSTALL_DIR"
info "Binary: $BIN_DIR/aiden"
echo
info "Next steps:"
echo "  1. Start Ollama:            curl -fsSL https://ollama.com/install.sh | sh"
echo "                              ollama serve &"
echo "                              ollama pull gemma2:2b"
echo "  2. Start the API server:    cd $INSTALL_DIR && AIDEN_HEADLESS=true npm start"
echo "  3. In another terminal:     aiden       (launches CLI)"
echo
info "Docs: https://github.com/$REPO"
info "Discord: https://discord.gg/gMZ3hUnQTm"
