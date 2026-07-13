$ErrorActionPreference = "SilentlyContinue"
$appDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$port = 5520
$url = "http://127.0.0.1:$port/index.html"

function Get-CommandPath($name) {
  $cmd = Get-Command $name -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }
  return $null
}

function Start-AppBrowser($url) {
  $edgePaths = @(
    "$env:ProgramFiles(x86)\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"
  )
  foreach ($edge in $edgePaths) {
    if (Test-Path -LiteralPath $edge) {
      Start-Process -FilePath $edge -ArgumentList @("--app=$url", "--new-window")
      return
    }
  }
  Start-Process $url
}

$pythonLauncher = Get-CommandPath "py"
$python = Get-CommandPath "python"

if ($pythonLauncher) {
  Start-Process -WindowStyle Hidden -FilePath $pythonLauncher -ArgumentList @("-3", "-m", "http.server", "$port", "--bind", "127.0.0.1", "--directory", "$appDir")
  Start-Sleep -Milliseconds 900
  Start-AppBrowser $url
  exit
}

if ($python) {
  Start-Process -WindowStyle Hidden -FilePath $python -ArgumentList @("-m", "http.server", "$port", "--bind", "127.0.0.1", "--directory", "$appDir")
  Start-Sleep -Milliseconds 900
  Start-AppBrowser $url
  exit
}

Start-Process (Join-Path $appDir "index.html")
