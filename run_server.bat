@echo off
cd /d "%~dp0"

where ruby >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Ruby not found. Install Ruby+Devkit first:
  echo   https://rubyinstaller.org/downloads/
  echo Then open a NEW terminal and run: gem install bundler
  echo Then in this folder run: bundle install
  pause
  exit /b 1
)

where bundle >nul 2>&1
if errorlevel 1 (
  echo [ERROR] bundler not found. Run: gem install bundler
  pause
  exit /b 1
)

if not exist "Gemfile.lock" (
  echo Installing gems... This may take several minutes on first run.
  bundle install
  if errorlevel 1 (
    echo bundle install failed. See messages above.
    pause
    exit /b 1
  )
)

echo.
echo Starting Jekyll at http://127.0.0.1:4000
echo Press Ctrl+C to stop.
echo.

bundle exec jekyll serve --livereload --host 127.0.0.1
