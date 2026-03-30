#!/bin/bash
# ============================================
#  OpenClaw Quick Setup
#  One command: curl -fsSL https://raw.githubusercontent.com/elispearing/openclaw-setup/main/install.sh | bash
# ============================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
BOLD='\033[1m'

echo ""
echo -e "${BLUE}${BOLD}========================================${NC}"
echo -e "${BLUE}${BOLD}   🐾 OpenClaw Installer${NC}"
echo -e "${BLUE}${BOLD}========================================${NC}"
echo ""

# Detect OS
OS="$(uname -s)"
ARCH="$(uname -m)"
echo -e "${YELLOW}Detected:${NC} $OS ($ARCH)"
echo ""

# ---- macOS ----
if [ "$OS" = "Darwin" ]; then

    # 1. Xcode Command Line Tools (includes Git)
    if ! xcode-select -p &>/dev/null; then
        echo -e "${YELLOW}📦 Installing Xcode Command Line Tools (includes Git)...${NC}"
        xcode-select --install
        echo -e "${YELLOW}⏳ A popup appeared — click 'Install' and wait for it to finish.${NC}"
        echo -e "${YELLOW}   Then re-run this script.${NC}"
        exit 0
    else
        echo -e "${GREEN}✅ Xcode CLI Tools (Git) already installed${NC}"
    fi

    # 2. Homebrew
    if ! command -v brew &>/dev/null; then
        echo -e "${YELLOW}📦 Installing Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add to path for Apple Silicon
        if [ "$ARCH" = "arm64" ]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo -e "${GREEN}✅ Homebrew already installed${NC}"
    fi

    # 3. Python
    if ! command -v python3 &>/dev/null; then
        echo -e "${YELLOW}📦 Installing Python...${NC}"
        brew install python
    else
        PYVER=$(python3 --version 2>&1)
        echo -e "${GREEN}✅ $PYVER already installed${NC}"
    fi

    # 4. Node.js (required for OpenClaw)
    if ! command -v node &>/dev/null; then
        echo -e "${YELLOW}📦 Installing Node.js...${NC}"
        brew install node
    else
        NODEVER=$(node --version 2>&1)
        echo -e "${GREEN}✅ Node.js $NODEVER already installed${NC}"
    fi

    # 5. OpenClaw
    if ! command -v openclaw &>/dev/null; then
        echo -e "${YELLOW}📦 Installing OpenClaw...${NC}"
        npm install -g openclaw
    else
        OCVER=$(openclaw --version 2>&1 || echo "installed")
        echo -e "${GREEN}✅ OpenClaw already installed ($OCVER)${NC}"
    fi

# ---- Linux ----
elif [ "$OS" = "Linux" ]; then

    # Detect package manager
    if command -v apt-get &>/dev/null; then
        PKG="apt"
    elif command -v dnf &>/dev/null; then
        PKG="dnf"
    elif command -v pacman &>/dev/null; then
        PKG="pacman"
    else
        echo -e "${RED}❌ Unsupported Linux distro. Install git, python3, nodejs, and npm manually, then run: npm install -g openclaw${NC}"
        exit 1
    fi

    echo -e "${YELLOW}📦 Updating packages...${NC}"

    if [ "$PKG" = "apt" ]; then
        sudo apt-get update -y
        sudo apt-get install -y git python3 python3-pip curl
        # Node.js via NodeSource
        if ! command -v node &>/dev/null; then
            curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
            sudo apt-get install -y nodejs
        fi
    elif [ "$PKG" = "dnf" ]; then
        sudo dnf install -y git python3 python3-pip curl nodejs npm
    elif [ "$PKG" = "pacman" ]; then
        sudo pacman -Syu --noconfirm git python python-pip curl nodejs npm
    fi

    echo -e "${GREEN}✅ Git, Python, Node.js installed${NC}"

    # OpenClaw
    if ! command -v openclaw &>/dev/null; then
        echo -e "${YELLOW}📦 Installing OpenClaw...${NC}"
        sudo npm install -g openclaw
    else
        echo -e "${GREEN}✅ OpenClaw already installed${NC}"
    fi

else
    echo -e "${RED}❌ Unsupported OS: $OS${NC}"
    echo -e "${YELLOW}For Windows, use WSL (Windows Subsystem for Linux) and re-run this script.${NC}"
    echo -e "${YELLOW}Or install manually: Git, Python, Node.js, then run: npm install -g openclaw${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}${BOLD}========================================${NC}"
echo -e "${GREEN}${BOLD}   ✅ All done!${NC}"
echo -e "${GREEN}${BOLD}========================================${NC}"
echo ""
echo -e "${BOLD}Installed:${NC}"
echo -e "  • Git:      $(git --version 2>&1)"
echo -e "  • Python:   $(python3 --version 2>&1)"
echo -e "  • Node.js:  $(node --version 2>&1)"
echo -e "  • npm:      $(npm --version 2>&1)"
echo -e "  • OpenClaw: $(openclaw --version 2>&1 || echo 'installed')"
echo ""
echo -e "${BLUE}${BOLD}Next steps:${NC}"
echo -e "  1. Run: ${BOLD}openclaw wizard${NC}"
echo -e "  2. Follow the prompts to connect Telegram, set your API key, etc."
echo -e "  3. Start it: ${BOLD}openclaw start${NC}"
echo ""
echo -e "${YELLOW}Docs: https://docs.openclaw.ai${NC}"
echo -e "${YELLOW}Discord: https://discord.com/invite/clawd${NC}"
echo ""
