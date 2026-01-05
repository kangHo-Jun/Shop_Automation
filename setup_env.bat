@echo off
setlocal
cd /d "%~dp0"

echo ==================================================
echo 🛠️  Shop Automation Setup Tool (V8.1)
echo ==================================================

:: 1. Check for Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python not found. Please install Python first.
    pause
    exit /b 1
)

:: 2. Create Virtual Environment
if not exist .venv (
    echo [1/4] Creating virtual environment (.venv)...
    python -m venv .venv
) else (
    echo [1/4] Virtual environment (.venv) already exists. Skipping.
)

:: 3. Setup .env file
if not exist .env (
    if exist .env.example (
        echo [2/4] Creating .env from .env.example...
        copy .env.example .env
    ) else (
        echo [WARN] .env.example not found. Please create .env manually.
    )
) else (
    echo [2/4] .env file already exists. Skipping.
)

:: 4. Install Requirements
echo [3/4] Installing dependencies from requirements.txt...
call .venv\Scripts\activate
pip install --upgrade pip
pip install -r requirements.txt

:: 5. Finish
echo [4/4] Setup complete!
echo ==================================================
echo ▶ You can now run the server using 'run_v8_server.bat'
echo ==================================================
pause
