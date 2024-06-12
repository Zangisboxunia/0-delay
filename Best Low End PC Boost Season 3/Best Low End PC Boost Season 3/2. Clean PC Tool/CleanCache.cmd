@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if %errorlevel% NEQ 0 (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:menu
cls
echo Select the cache you want to clear:
echo 1. Temporary Files
echo 2. Clear Specific Browser Cache
echo 3. Windows Update Cache
echo 4. Prefetch Files
echo 5. Windows Store Cache
echo 6. Windows Log Files
echo 7. Memory Dump Files
echo 8. Windows Delivery Optimization Files
echo 9. DirectX Shader Cache
echo 10. Exit
echo.
set /p choice="Enter your choice (1-10): "
echo.

if "%choice%"=="1" goto clear_temp
if "%choice%"=="2" goto browser_cache_menu
if "%choice%"=="3" goto clear_update
if "%choice%"=="4" goto clear_prefetch
if "%choice%"=="5" goto clear_store
if "%choice%"=="6" goto clear_logfiles
if "%choice%"=="7" goto clear_memorydump
if "%choice%"=="8" goto clear_optimization
if "%choice%"=="9" goto clear_shader
if "%choice%"=="10" exit

echo Invalid choice
pause
goto menu

:clear_temp
del /q /f /s %temp%\*
echo Temporary files cleared.
pause
goto menu

:browser_cache_menu
cls
echo Select the browser cache to clear:
echo 1. Google Chrome
echo 2. Mozilla Firefox
echo 3. Opera GX
echo 4. Brave
echo 5. Return to Main Menu
echo.
set /p browserchoice="Enter your choice (1-5): "
echo.

if "%browserchoice%"=="1" goto clear_chrome
if "%browserchoice%"=="2" goto clear_firefox
if "%browserchoice%"=="3" goto clear_opera
if "%browserchoice%"=="4" goto clear_brave
if "%browserchoice%"=="5" goto menu

echo Invalid choice
pause
goto browser_cache_menu

:clear_chrome
del /q /f /s "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*"
echo Google Chrome cache cleared.
pause
goto menu

:clear_firefox
start /wait "" "C:\Program Files\Mozilla Firefox\firefox.exe" -P "default" -no-remote -safe-mode -jsconsole -clearcache
echo Mozilla Firefox cache cleared.
pause
goto menu

:clear_opera
del /q /f /s "%AppData%\Opera Software\Opera GX Stable\Cache\*"
echo Opera GX cache cleared.
pause
goto menu

:clear_brave
del /q /f /s "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\Cache\*"
echo Brave cache cleared.
pause
goto menu

:clear_update
net stop wuauserv
del /q /f /s %windir%\SoftwareDistribution\Download\*
net start wuauserv
echo Windows Update service stopped, cache cleared, and service started.
pause
goto menu

:clear_prefetch
if exist %windir%\Prefetch\ (
    del /q /f /s %windir%\Prefetch\*
    echo Prefetch files cleared.
) else (
    echo Prefetch directory not found or empty.
)
pause
goto menu

:clear_store
wsreset
echo Windows Store cache cleared.
pause
goto menu

:clear_logfiles
del /q /f /s %windir%\Logs\*
echo Windows log files cleared.
pause
goto menu

:clear_memorydump
if exist %windir%\Minidump\ (
    del /q /f /s %windir%\Minidump\*
    echo Memory dump files cleared.
) else (
    echo Memory dump files directory not found or empty.
)
pause
goto menu

:clear_optimization
net stop dosvc
del /q /f /s %windir%\SoftwareDistribution\DeliveryOptimization\*
net start dosvc
echo Windows Delivery Optimization files cleared.
pause
goto menu

:clear_shader
del /q /f /s "%LocalAppData%\D3DSCache\*"
echo DirectX Shader Cache cleared.
pause
goto menu
