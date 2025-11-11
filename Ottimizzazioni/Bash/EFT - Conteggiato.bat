@echo off
echo Pulizia dei file temporanei e dei file di registro...
echo.

:: Variabile contatore per i file cancellati
set /a totalFilesDeleted=0

:: Cancellazione dei file temporanei dell'utente
echo Cancellazione dei file temporanei dell'utente...
for /f %%A in ('dir /a /s /b "%temp%\*" 2^>nul ^| find /c /v ""') do set tempFilesBefore=%%A
if exist "%temp%\*" del /s /q "%temp%\*" 2>nul
for /f %%A in ('dir /a /s /b "%temp%\*" 2^>nul ^| find /c /v ""') do set tempFilesAfter=%%A
set /a tempFilesDeleted=%tempFilesBefore% - %tempFilesAfter%
set /a totalFilesDeleted+=%tempFilesDeleted%
echo File temporanei dell'utente cancellati.
echo.

:: Cancellazione dei file temporanei di Windows
echo Cancellazione dei file temporanei di Windows...
for /f %%A in ('dir /a /s /b "C:\Windows\Temp\*" 2^>nul ^| find /c /v ""') do set winTempFilesBefore=%%A
if exist "C:\Windows\Temp\*" del /s /q "C:\Windows\Temp\*" 2>nul
for /f %%A in ('dir /a /s /b "C:\Windows\Temp\*" 2^>nul ^| find /c /v ""') do set winTempFilesAfter=%%A
set /a winTempFilesDeleted=%winTempFilesBefore% - %winTempFilesAfter%
set /a totalFilesDeleted+=%winTempFilesDeleted%
echo File temporanei di Windows cancellati.
echo.

:: Pulizia avanzata delle cartelle temporanee
echo Pulizia avanzata delle cartelle temporanee...
if exist "C:\Windows\Temp" rd /s /q "C:\Windows\Temp" 2>nul
md "C:\Windows\Temp"
echo Ricreata la cartella C:\Windows\Temp.

if exist "%temp%" rd /s /q "%temp%" 2>nul
md "%temp%"
echo Ricreata la cartella temporanea dell'utente.
echo.

:: Cancellazione di file specifici
echo Cancellazione di file non necessari...
for /f %%A in ('dir /a /s /b "C:\Windows\ff*.tmp" 2^>nul ^| find /c /v ""') do set filesBefore=%%A
if exist "C:\Windows\ff*.tmp" del /s /q "C:\Windows\ff*.tmp" 2>nul
if exist "C:\Windows\history" rd /s /q "C:\Windows\history" 2>nul
if exist "C:\Windows\cookies" rd /s /q "C:\Windows\cookies" 2>nul
if exist "C:\Windows\recent" rd /s /q "C:\Windows\recent" 2>nul
if exist "C:\Windows\spool\printers" rd /s /q "C:\Windows\spool\printers" 2>nul
if exist "C:\WIN386.SWP" del "C:\WIN386.SWP" 2>nul
for /f %%A in ('dir /a /s /b "C:\Windows\ff*.tmp" 2^>nul ^| find /c /v ""') do set filesAfter=%%A
set /a specificFilesDeleted=%filesBefore% - %filesAfter%
set /a totalFilesDeleted+=%specificFilesDeleted%
echo File specifici cancellati.
echo.

:: Cancellazione dei file nella cartella SoftwareDistribution\Download
echo Cancellazione dei file scaricati per gli aggiornamenti di Windows...
for /f %%A in ('dir /a /s /b "C:\Windows\SoftwareDistribution\Download\*" 2^>nul ^| find /c /v ""') do set downloadFilesBefore=%%A
if exist "C:\Windows\SoftwareDistribution\Download\*" del /s /q "C:\Windows\SoftwareDistribution\Download\*" 2>nul
for /f %%A in ('dir /a /s /b "C:\Windows\SoftwareDistribution\Download\*" 2^>nul ^| find /c /v ""') do set downloadFilesAfter=%%A
set /a downloadFilesDeleted=%downloadFilesBefore% - %downloadFilesAfter%
set /a totalFilesDeleted+=%downloadFilesDeleted%
echo File degli aggiornamenti cancellati.
echo.

:: Cancellazione di file .tmp nel sistema
echo Cancellazione di file .tmp nel sistema...
for /f %%A in ('dir /a /s /b "C:\Windows\Temp\*.tmp" 2^>nul ^| find /c /v ""') do set tmpFilesBefore=%%A
PowerShell -Command "Get-ChildItem -Path 'C:\Windows\Temp', '%temp%', 'C:\ProgramData' -Recurse -Include *.tmp | Remove-Item -Force -ErrorAction SilentlyContinue" 2>nul
for /f %%A in ('dir /a /s /b "C:\Windows\Temp\*.tmp" 2^>nul ^| find /c /v ""') do set tmpFilesAfter=%%A
set /a tmpFilesDeleted=%tmpFilesBefore% - %tmpFilesAfter%
set /a totalFilesDeleted+=%tmpFilesDeleted%
echo File .tmp cancellati.
echo.

:: Cancellazione di file .dmp nel sistema
echo Cancellazione di file .dmp nel sistema...
for /f %%A in ('dir /a /s /b "C:\Windows\Temp\*.dmp" 2^>nul ^| find /c /v ""') do set dmpFilesBefore=%%A
PowerShell -Command "Get-ChildItem -Path 'C:\Windows\Temp', '%temp%', 'C:\ProgramData' -Recurse -Include *.dmp | Remove-Item -Force -ErrorAction SilentlyContinue" 2>nul
for /f %%A in ('dir /a /s /b "C:\Windows\Temp\*.dmp" 2^>nul ^| find /c /v ""') do set dmpFilesAfter=%%A
set /a dmpFilesDeleted=%dmpFilesBefore% - %dmpFilesAfter%
set /a totalFilesDeleted+=%dmpFilesDeleted%
echo File .dmp cancellati.
echo.

:: Pulizia della cache dei browser (Chrome, Edge)
echo Pulizia della cache del browser...
PowerShell -Command "Get-ChildItem -Recurse \"$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\" | Remove-Item -Recurse -Force" 2>nul
PowerShell -Command "Get-ChildItem -Recurse \"$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\" | Remove-Item -Recurse -Force" 2>nul
echo Cache del browser cancellata.
echo.

:: Svuotamento del cestino
echo Svuotamento del cestino...
PowerShell Clear-RecycleBin -Confirm:$false
echo Cestino svuotato.
echo.

:: Visualizza il totale dei file cancellati
echo Totale file cancellati: %totalFilesDeleted%
echo.

echo Pulizia completata.
pause

exit /b

:do_clear
echo Cancellazione del log degli eventi: %1
wevtutil.exe cl %1 2>nul