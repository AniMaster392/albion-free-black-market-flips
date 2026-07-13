@echo off
setlocal
cd /d "%~dp0"
if exist "dist\Albion Free Black Market Flips\Albion Free Black Market Flips.exe" (
  start "" "dist\Albion Free Black Market Flips\Albion Free Black Market Flips.exe"
  exit /b 0
)
where py >nul 2>nul
if not errorlevel 1 (
  py -3 app.py
  pause
  exit /b %errorlevel%
)
where python >nul 2>nul
if not errorlevel 1 (
  python app.py
  pause
  exit /b %errorlevel%
)
echo Python is required to run from source.
echo Download the Windows release zip for the no-install .exe version.
pause
exit /b 1
