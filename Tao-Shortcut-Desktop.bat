@echo off
setlocal
set "TARGET_DIR=%~dp0"
set "TARGET_EXE=%TARGET_DIR%DeviceDriver.exe"
set "SHORTCUT_PATH=%USERPROFILE%\Desktop\S75Pro (Fixed 2.4G).lnk"

powershell -NoProfile -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SHORTCUT_PATH%'); $s.TargetPath = '%TARGET_EXE%'; $s.WorkingDirectory = '%TARGET_DIR%'; $s.Save()"
echo [OK] Da tao shortcut tren Desktop: S75Pro (Fixed 2.4G)
pause