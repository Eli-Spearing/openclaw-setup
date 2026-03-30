# ============================================
#  OpenClaw Quick Setup — Windows
#  One command: irm https://raw.githubusercontent.com/Eli-Spearing/openclaw-setup/main/install.ps1 | iex
# ============================================

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Blue
Write-Host "   🐾 OpenClaw Installer (Windows)" -ForegroundColor Blue
Write-Host "========================================" -ForegroundColor Blue
Write-Host ""

# Check if running as admin (some installs need it)
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# 1. Install winget if missing (Windows 10/11 should have it)
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "❌ winget not found. Please install 'App Installer' from the Microsoft Store first." -ForegroundColor Red
    Write-Host "   https://apps.microsoft.com/detail/9NBLGGH4NNS1" -ForegroundColor Yellow
    exit 1
}

# 2. Git
if (Get-Command git -ErrorAction SilentlyContinue) {
    $gitVer = git --version 2>&1
    Write-Host "✅ $gitVer" -ForegroundColor Green
} else {
    Write-Host "📦 Installing Git..." -ForegroundColor Yellow
    winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    Write-Host "✅ Git installed" -ForegroundColor Green
}

# 3. Python
if (Get-Command python3 -ErrorAction SilentlyContinue) {
    $pyVer = python3 --version 2>&1
    Write-Host "✅ $pyVer" -ForegroundColor Green
} elseif (Get-Command python -ErrorAction SilentlyContinue) {
    $pyVer = python --version 2>&1
    if ($pyVer -match "3\.") {
        Write-Host "✅ $pyVer" -ForegroundColor Green
    } else {
        Write-Host "📦 Installing Python 3..." -ForegroundColor Yellow
        winget install --id Python.Python.3.12 -e --accept-source-agreements --accept-package-agreements
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        Write-Host "✅ Python installed" -ForegroundColor Green
    }
} else {
    Write-Host "📦 Installing Python 3..." -ForegroundColor Yellow
    winget install --id Python.Python.3.12 -e --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    Write-Host "✅ Python installed" -ForegroundColor Green
}

# 4. Node.js
if (Get-Command node -ErrorAction SilentlyContinue) {
    $nodeVer = node --version 2>&1
    Write-Host "✅ Node.js $nodeVer" -ForegroundColor Green
} else {
    Write-Host "📦 Installing Node.js..." -ForegroundColor Yellow
    winget install --id OpenJS.NodeJS.LTS -e --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    Write-Host "✅ Node.js installed" -ForegroundColor Green
}

# Refresh PATH one more time
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# 5. OpenClaw
if (Get-Command openclaw -ErrorAction SilentlyContinue) {
    Write-Host "✅ OpenClaw already installed" -ForegroundColor Green
} else {
    Write-Host "📦 Installing OpenClaw..." -ForegroundColor Yellow
    npm install -g openclaw
    Write-Host "✅ OpenClaw installed" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "   ✅ All done!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Blue
Write-Host "  1. Close and reopen Terminal (so PATH updates)" -ForegroundColor White
Write-Host "  2. Run: openclaw wizard" -ForegroundColor White
Write-Host "  3. Start: openclaw start" -ForegroundColor White
Write-Host ""
Write-Host "Docs: https://docs.openclaw.ai" -ForegroundColor Yellow
Write-Host "Discord: https://discord.com/invite/clawd" -ForegroundColor Yellow
Write-Host ""
