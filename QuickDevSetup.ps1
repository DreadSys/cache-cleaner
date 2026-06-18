# QuickDev Setup - Automated Environment Builder
# Author: DevOps Learner
Write-Host "--- Initializing Professional Dev Environment Setup ---" -ForegroundColor Cyan

# Function to check if program is installed
function Test-Program {
    param([string]$name)
    return (Get-Command $name -ErrorAction SilentlyContinue) -ne $null
}

# 1. Checking Git
Write-Host "Checking for Git..." -ForegroundColor Yellow
if (Test-Program "git") {
    Write-Host "Git is already installed." -ForegroundColor Green
} else {
    Write-Host "Git not found. Please install from: https://git-scm.com/" -ForegroundColor Red
}

# 2. Checking Python
Write-Host "Checking for Python..." -ForegroundColor Yellow
if (Test-Program "python") {
    Write-Host "Python is already installed." -ForegroundColor Green
} else {
    Write-Host "Python not found. Please install from: https://www.python.org/" -ForegroundColor Red
}

# 3. Checking VS Code
Write-Host "Checking for VS Code..." -ForegroundColor Yellow
if (Test-Program "code") {
    Write-Host "VS Code is already installed." -ForegroundColor Green
} else {
    Write-Host "VS Code not found. Please install from: https://code.visualstudio.com/" -ForegroundColor Red
}

Write-Host "-------------------------------------------------------" -ForegroundColor Cyan
Write-Host "Environment check complete. Ready to code." -ForegroundColor Green
Pause