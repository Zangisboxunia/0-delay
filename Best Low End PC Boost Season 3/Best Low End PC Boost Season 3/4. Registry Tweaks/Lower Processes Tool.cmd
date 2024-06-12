:by leStripeZ:

@echo off
setlocal EnableDelayedExpansion

:: Check for administrative privileges
:CheckPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' (goto gotPrivileges) else (goto getPrivileges)

:getPrivileges
echo.
echo Requesting administrative privileges...
echo.
PowerShell -Command "Start-Process '%0' -ArgumentList '%*' -Verb RunAs"
exit /B

:gotPrivileges
echo.
echo Administrative privileges confirmed.
echo.

:: List of services and descriptions
echo Services to be disabled:
echo.
echo WSearch - Windows Search: Indexes files for faster search results.
echo SysMain - Superfetch: Preloads frequently used apps into memory.
echo wuauserv - Windows Update: Automatically updates Windows.
echo BITS - Background Intelligent Transfer Service: Transfers files in the background using idle network bandwidth.
echo DiagTrack - Connected User Experiences and Telemetry: Collects usage and performance data.
echo TermService - Remote Desktop Services: Enables remote access to your computer.
echo RemoteRegistry - Remote Registry: Allows remote registry editing.
echo WerSvc - Windows Error Reporting Service: Reports errors to Microsoft.
echo seclogon - Secondary Logon: Enables starting processes under different user credentials.
echo DPS - Diagnostic Policy Service: Detects and troubleshoots issues.
echo CscService - Offline Files: Enables offline file access.
:: Removed WIA as per your requirement
echo Spooler - Print Spooler: Manages print jobs.
echo Fax - Fax: Manages fax services.
echo bthserv - Bluetooth Support Service: Manages Bluetooth devices.
echo WbioSrvc - Windows Biometric Service: Manages biometric devices like fingerprint scanners.
echo TabletInputService - Touch Keyboard and Handwriting Panel Service: Manages touch keyboard and handwriting panel.
echo TrkWks - Distributed Link Tracking Client: Maintains links between NTFS files within a network.
echo iphlpsvc - IP Helper: Provides tunnel connectivity using IPv6 transition technologies.
echo PcaSvc - Program Compatibility Assistant Service: Monitors programs for compatibility issues.
echo.

:: Menu system
:menu
echo Select an option:
echo [1] Apply performance tweaks
echo [2] Revert to default settings
set /p choice=Enter your choice (1 or 2): 

if '%choice%' == '1' (goto DisableServices) 
if '%choice%' == '2' (goto EnableServices) 
goto menu

:: Function to disable services
:DisableServices
echo Disabling services for higher performance...
sc config WSearch start= disabled
net stop WSearch
sc config SysMain start= disabled
net stop SysMain
sc config wuauserv start= disabled
net stop wuauserv
sc config BITS start= disabled
net stop BITS
sc config DiagTrack start= disabled
net stop DiagTrack
sc config TermService start= disabled
net stop TermService
sc config RemoteRegistry start= disabled
net stop RemoteRegistry
sc config WerSvc start= disabled
net stop WerSvc
sc config seclogon start= disabled
net stop seclogon
sc config DPS start= disabled
net stop DPS
sc config CscService start= disabled
net stop CscService
:: Removed WIA as per your requirement
sc config Spooler start= disabled
net stop Spooler
sc config Fax start= disabled
net stop Fax
sc config bthserv start= disabled
net stop bthserv
sc config WbioSrvc start= disabled
net stop WbioSrvc
sc config TabletInputService start= disabled
net stop TabletInputService
sc config TrkWks start= disabled
net stop TrkWks
sc config iphlpsvc start= disabled
net stop iphlpsvc
sc config PcaSvc start= disabled
net stop PcaSvc
goto end

:: Function to enable services
:EnableServices
echo Reverting services to default settings...
sc config WSearch start= delayed-auto
net start WSearch
sc config SysMain start= auto
net start SysMain
sc config wuauserv start= auto
net start wuauserv
sc config BITS start= delayed-auto
net start BITS
sc config DiagTrack start= auto
net start DiagTrack
sc config TermService start= demand
sc config RemoteRegistry start= demand
sc config WerSvc start= manual
net start WerSvc
sc config seclogon start= demand
sc config DPS start= auto
net start DPS
sc config CscService start= auto
net start CscService
:: Removed WIA as per your requirement
sc config stisvc start= demand
sc config Spooler start= auto
net start Spooler
sc config Fax start= demand
sc config bthserv start= demand
sc config WbioSrvc start= demand
sc config TabletInputService start= demand
sc config TrkWks start= auto
net start TrkWks
sc config iphlpsvc start= auto
net start iphlpsvc
sc config PcaSvc start= auto
net start PcaSvc
goto end

:end
echo.
echo Operation completed.
pause
exit /B
