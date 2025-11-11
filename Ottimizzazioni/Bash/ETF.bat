@echo off
:: Imposta la codifica UTF-8 (65001) per visualizzare correttamente gli emoji e i caratteri speciali
chcp 65001 >nul
setlocal enableDelayedExpansion

echo.
echo === Pulizia dei File Temporanei e Inutili ===
echo.
echo ⚠️ Lo script DEVE essere eseguito come Amministratore per completare tutte le operazioni (es. Log Eventi, C:\Windows\Temp).
echo.
echo I file eliminati e gli eventuali errori (es. file in uso) saranno visualizzati qui sotto.
echo.
echo --- Inizio Eliminazione ---

:: 1. Cancellazione dei file temporanei dell'utente
echo.
echo ## 🗑️ Eliminazione file in %%TEMP%% (Cartella Temporanea Utente)
if exist "%temp%\*" (
    :: Tenta di rimuovere e ricreare l'intera cartella (il metodo più pulito e veloce)
    rd /s /q "%temp%" 2>&1 | findstr /v /i "non riuscito" > nul
    if not exist "%temp%" (
        md "%temp%"
        echo ✅ Ricreata la cartella %temp%.
    ) else (
        echo ⚠️ Impossibile ricreare/rimuovere completamente la cartella %temp%, procedo con l'eliminazione dei contenuti.
        :: Rimozione dell'opzione /v per compatibilità e visualizzazione solo degli errori
        del /s /f /q "%temp%\*" 2>&1
    )
) else (
    echo Nessun file da eliminare in %%TEMP%%.
)

:: 2. Cancellazione dei file temporanei di Windows
echo.
echo ## 🗑️ Eliminazione file in C:\Windows\Temp
if exist "C:\Windows\Temp\*" (
    rd /s /q "C:\Windows\Temp" 2>&1 | findstr /v /i "non riuscito" > nul
    if not exist "C:\Windows\Temp" (
        md "C:\Windows\Temp"
        echo ✅ Ricreata la cartella C:\Windows\Temp.
    ) else (
        echo ⚠️ Impossibile ricreare/rimuovere completamente la cartella C:\Windows\Temp, procedo con l'eliminazione dei contenuti.
        :: Rimozione dell'opzione /v per compatibilità e visualizzazione solo degli errori
        del /s /f /q "C:\Windows\Temp\*" 2>&1
    )
) else (
    echo Nessun file da eliminare in C:\Windows\Temp.
)

:: 3. Cancellazione di file specifici (rimozione dell'opzione /v)
echo.
echo ## 🗑️ Eliminazione File e Cartelle Specifiche
echo ➡️ Eliminazione C:\Windows\ff*.tmp:
del /s /f /q "C:\Windows\ff*.tmp" 2>&1
echo ➡️ Eliminazione C:\WIN386.SWP:
del /f "C:\WIN386.SWP" 2>&1
echo ➡️ Eliminazione cartella C:\Windows\history:
rd /s /q "C:\Windows\history" 2>&1
echo ➡️ Eliminazione cartella C:\Windows\cookies:
rd /s /q "C:\Windows\cookies" 2>&1
echo ➡️ Eliminazione cartella C:\Windows\recent:
rd /s /q "C:\Windows\recent" 2>&1
echo ➡️ Eliminazione cartella C:\Windows\spool\printers (coda di stampa):
rd /s /q "C:\Windows\spool\printers" 2>&1
if not exist "C:\Windows\spool\printers" md "C:\Windows\spool\printers" 2>nul
echo.

:: 4. Cancellazione dei file nella cartella SoftwareDistribution\Download (rimozione dell'opzione /v)
echo.
echo ## 🗑️ Eliminazione file scaricati per gli aggiornamenti di Windows
del /s /f /q "C:\Windows\SoftwareDistribution\Download\*" 2>&1

:: 5. Pulizia della cache dei browser (Correzione del percorso PowerShell)
echo.
echo ## 🌐 Pulizia Cache Browser (Chrome, Edge)
echo ➡️ Pulizia cache Chrome...
:: Modificato: Elimina ricorsivamente il contenuto della cartella Cache, non solo la cartella Cache
PowerShell -Command "Get-ChildItem -Path \"$env:LOCALAPPDATA\Google\Chrome\User Data\Default\" -Recurse -Include Cache\* -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction Stop"
if %errorlevel% neq 0 (echo ❌ Errore nella pulizia della cache Chrome.) else (echo ✅ Cache Chrome pulita.)
echo ➡️ Pulizia cache Edge...
:: Modificato: Elimina ricorsivamente il contenuto della cartella Cache, non solo la cartella Cache
PowerShell -Command "Get-ChildItem -Path \"$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\" -Recurse -Include Cache\* -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction Stop"
if %errorlevel% neq 0 (echo ❌ Errore nella pulizia della cache Edge.) else (echo ✅ Cache Edge pulita.)
echo.

:: 6. Cancellazione di file .tmp e .dmp con PowerShell
echo.
echo ## 🧹 Pulizia File .TMP e .DMP con PowerShell
echo ➡️ Eliminazione file *.tmp...
PowerShell -Command "Get-ChildItem -Path 'C:\Windows\Temp', '%temp%', 'C:\ProgramData' -Recurse -Include *.tmp -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction Stop"
if %errorlevel% neq 0 (echo ❌ Errore nell'eliminazione di alcuni file .tmp. (vedi dettagli sopra)) else (echo ✅ File .tmp completata.)
echo ➡️ Eliminazione file *.dmp...
PowerShell -Command "Get-ChildItem -Path 'C:\Windows\Temp', '%temp%', 'C:\ProgramData' -Recurse -Include *.dmp -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction Stop"
if %errorlevel% neq 0 (echo ❌ Errore nell'eliminazione di alcuni file .dmp. (vedi dettagli sopra)) else (echo ✅ File .dmp completata.)
echo.

:: 7. Svuotamento del cestino
echo.
echo ## ♻️ Svuotamento del Cestino
PowerShell Clear-RecycleBin -Confirm:$false
if %errorlevel% neq 0 (echo ❌ Errore nello svuotamento del cestino. (vedi dettagli sopra)) else (echo ✅ Cestino svuotato.)
echo.

:: 8. Cancellazione Log Eventi (Richiede Amministratore)
echo.
echo ## 📝 Pulizia Log Eventi di Windows (System, Application, Security)
call :do_clear Application
call :do_clear System
call :do_clear Security
echo ✅ Pulizia dei log degli eventi completata.
echo.

echo --- Pulizia Completata ---
pause
endlocal
exit /b

:do_clear
echo ➡️ Cancellazione log degli eventi: %1
wevtutil.exe cl %1 2>&1
goto :eof