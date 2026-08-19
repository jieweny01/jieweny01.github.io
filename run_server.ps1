Set-Location $PSScriptRoot

if (-not (Get-Command ruby -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Ruby not installed." -ForegroundColor Red
    Write-Host "1. Download Ruby+Devkit (x64): https://rubyinstaller.org/downloads/"
    Write-Host "2. Check 'Add Ruby to PATH' during setup"
    Write-Host "3. Open a NEW terminal, run: ridk install  (choose 1, then 3)"
    Write-Host "4. Run: gem install bundler"
    Write-Host "5. In this folder: bundle install"
    exit 1
}

if (-not (Get-Command bundle -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Run: gem install bundler" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path "Gemfile.lock")) {
    Write-Host "First run: installing gems (may take a few minutes)..."
    bundle install
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Write-Host ""
Write-Host "Open http://127.0.0.1:4000 in your browser" -ForegroundColor Green
Write-Host "Press Ctrl+C to stop." -ForegroundColor Gray
Write-Host ""

bundle exec jekyll serve --livereload --host 127.0.0.1
