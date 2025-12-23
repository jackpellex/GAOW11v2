#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Registry Automator - Sistema di gestione automatizzata del Registro di Windows
.DESCRIPTION
    Script PowerShell per applicare modifiche al registro tramite file JSON configurabili
.NOTES
    Autore: Registry Automator Project
    Versione: 1.0
    Requisiti: Privilegi di Amministratore
#>

# ============================================================================
# CONFIGURAZIONE GLOBALE
# ============================================================================

$Script:LogPath = Join-Path $PSScriptRoot "logs\registry_execution.log"
$Script:ConfigPath = Join-Path $PSScriptRoot "config"

# ============================================================================
# FUNZIONI DI LOGGING
# ============================================================================

function Write-Log {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('INFO', 'WARN', 'ERROR', 'SUCCESS')]
        [string]$Level = 'INFO'
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] [$Level] $Message"
    
    # Crea la cartella logs se non esiste
    $logDir = Split-Path $Script:LogPath -Parent
    if (-not (Test-Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
    }
    
    # Scrivi su file
    Add-Content -Path $Script:LogPath -Value $logEntry
    
    # Output colorato su console
    switch ($Level) {
        'INFO'    { Write-Host $logEntry -ForegroundColor Cyan }
        'WARN'    { Write-Host $logEntry -ForegroundColor Yellow }
        'ERROR'   { Write-Host $logEntry -ForegroundColor Red }
        'SUCCESS' { Write-Host $logEntry -ForegroundColor Green }
    }
}

# ============================================================================
# FUNZIONI DI VALIDAZIONE
# ============================================================================

function Test-RegistryValue {
    param(
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [string]$Type
    )
    
    $validTypes = @('String', 'DWord', 'QWord', 'Binary', 'MultiString', 'ExpandString')
    
    if ($Type -notin $validTypes) {
        throw "Tipo di registro non valido: $Type. Tipi validi: $($validTypes -join ', ')"
    }
    
    # Valida il path del registro
    if ($Path -notmatch '^HK(EY_)?(LOCAL_MACHINE|CURRENT_USER|CLASSES_ROOT|USERS|CURRENT_CONFIG)') {
        throw "Path del registro non valido: $Path"
    }
    
    return $true
}

function Get-RegistryChanges {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Config
    )
    
    $changes = @()
    
    foreach ($reg in $Config.registries) {
        $currentValue = $null
        $exists = $false
        
        try {
            # Converti il path in formato PowerShell
            $psPath = $reg.path -replace '^HKEY_LOCAL_MACHINE', 'HKLM:' `
                                 -replace '^HKEY_CURRENT_USER', 'HKCU:' `
                                 -replace '^HKLM\\', 'HKLM:\' `
                                 -replace '^HKCU\\', 'HKCU:\'
            
            if (Test-Path $psPath) {
                $prop = Get-ItemProperty -Path $psPath -Name $reg.name -ErrorAction SilentlyContinue
                if ($prop) {
                    $exists = $true
                    $currentValue = $prop.$($reg.name)
                }
            }
        }
        catch {
            # La chiave o il valore non esistono
        }
        
        $change = [PSCustomObject]@{
            Path = $reg.path
            Name = $reg.name
            CurrentValue = if ($exists) { $currentValue } else { "(non esistente)" }
            NewValue = $reg.value
            Type = $reg.type
            Action = if ($exists) { "MODIFICA" } else { "CREAZIONE" }
            Description = $reg.description
        }
        
        $changes += $change
    }
    
    return $changes
}

# ============================================================================
# FUNZIONI DI APPLICAZIONE
# ============================================================================

function Set-RegistryValue {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        
        [Parameter(Mandatory=$true)]
        [string]$Name,
        
        [Parameter(Mandatory=$true)]
        [object]$Value,
        
        [Parameter(Mandatory=$true)]
        [string]$Type
    )
    
    try {
        # Converti il path
        $psPath = $Path -replace '^HKEY_LOCAL_MACHINE', 'HKLM:' `
                        -replace '^HKEY_CURRENT_USER', 'HKCU:' `
                        -replace '^HKLM\\', 'HKLM:\' `
                        -replace '^HKCU\\', 'HKCU:\'
        
        # Crea il path se non esiste
        if (-not (Test-Path $psPath)) {
            Write-Log "Creazione del percorso: $psPath" -Level INFO
            New-Item -Path $psPath -Force | Out-Null
        }
        
        # Imposta il valore
        Set-ItemProperty -Path $psPath -Name $Name -Value $Value -Type $Type -Force
        Write-Log "Impostato $Name = $Value in $psPath" -Level SUCCESS
        
        return $true
    }
    catch {
        Write-Log "Errore durante l'impostazione di $Name in $Path : $($_.Exception.Message)" -Level ERROR
        return $false
    }
}

function Apply-RegistryConfig {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Config
    )
    
    $successCount = 0
    $errorCount = 0
    
    Write-Log "Inizio applicazione del profilo: $($Config.profile_name)" -Level INFO
    
    foreach ($reg in $Config.registries) {
        Test-RegistryValue -Path $reg.path -Name $reg.name -Value $reg.value -Type $reg.type | Out-Null
        
        $result = Set-RegistryValue -Path $reg.path -Name $reg.name -Value $reg.value -Type $reg.type
        
        if ($result) {
            $successCount++
        } else {
            $errorCount++
        }
    }
    
    Write-Log "Applicazione completata: $successCount successi, $errorCount errori" -Level INFO
    
    return [PSCustomObject]@{
        Success = $successCount
        Errors = $errorCount
    }
}

# ============================================================================
# FUNZIONI UI
# ============================================================================

function Show-Menu {
    Clear-Host
    Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║         REGISTRY AUTOMATOR - Menu Principale            ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    
    $configs = Get-ChildItem -Path $Script:ConfigPath -Filter "*.json" -ErrorAction SilentlyContinue
    
    if ($configs.Count -eq 0) {
        Write-Host "Nessun file di configurazione trovato in: $Script:ConfigPath" -ForegroundColor Red
        return $null
    }
    
    Write-Host "Profili disponibili:" -ForegroundColor Yellow
    Write-Host ""
    
    for ($i = 0; $i -lt $configs.Count; $i++) {
        $configContent = Get-Content $configs[$i].FullName -Raw | ConvertFrom-Json
        Write-Host "  [$($i+1)] " -NoNewline -ForegroundColor Green
        Write-Host "$($configContent.profile_name)" -NoNewline -ForegroundColor White
        Write-Host " ($($configs[$i].Name))" -ForegroundColor DarkGray
        if ($configContent.description) {
            Write-Host "      └─ $($configContent.description)" -ForegroundColor Gray
        }
    }
    
    Write-Host ""
    Write-Host "  [0] Esci" -ForegroundColor Red
    Write-Host ""
    
    return $configs
}

function Show-ChangesPreview {
    param(
        [Parameter(Mandatory=$true)]
        [array]$Changes,
        
        [Parameter(Mandatory=$true)]
        [string]$ProfileName
    )
    
    Clear-Host
    Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
    Write-Host "║              ANTEPRIMA MODIFICHE                         ║" -ForegroundColor Yellow
    Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Profilo: " -NoNewline -ForegroundColor Cyan
    Write-Host $ProfileName -ForegroundColor White
    Write-Host ""
    Write-Host "Verranno applicate le seguenti modifiche:" -ForegroundColor Yellow
    Write-Host ""
    
    foreach ($change in $Changes) {
        Write-Host "─────────────────────────────────────────────────────────" -ForegroundColor DarkGray
        
        if ($change.Action -eq "CREAZIONE") {
            Write-Host "  [NUOVA CHIAVE]" -ForegroundColor Green
        } else {
            Write-Host "  [MODIFICA]" -ForegroundColor Yellow
        }
        
        Write-Host "  Path: " -NoNewline -ForegroundColor Cyan
        Write-Host $change.Path -ForegroundColor White
        
        Write-Host "  Nome: " -NoNewline -ForegroundColor Cyan
        Write-Host $change.Name -ForegroundColor White
        
        Write-Host "  Valore attuale: " -NoNewline -ForegroundColor Cyan
        Write-Host $change.CurrentValue -ForegroundColor Gray
        
        Write-Host "  Nuovo valore: " -NoNewline -ForegroundColor Cyan
        Write-Host "$($change.NewValue) ($($change.Type))" -ForegroundColor Green
        
        if ($change.Description) {
            Write-Host "  Info: " -NoNewline -ForegroundColor Cyan
            Write-Host $change.Description -ForegroundColor Gray
        }
        Write-Host ""
    }
    
    Write-Host "─────────────────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host ""
}

# ============================================================================
# MAIN
# ============================================================================

function Main {
    Write-Log "=== AVVIO REGISTRY AUTOMATOR ===" -Level INFO
    
    while ($true) {
        $configs = Show-Menu
        
        if ($null -eq $configs) {
            Write-Host "Premi un tasto per uscire..."
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            exit
        }
        
        Write-Host 'Seleziona un profilo (0 per uscire): ' -NoNewline -ForegroundColor Cyan
        $selection = Read-Host
        
        if ($selection -eq "0") {
            Write-Log "=== CHIUSURA REGISTRY AUTOMATOR ===" -Level INFO
            exit
        }
        
        $index = [int]$selection - 1
        
        if ($index -lt 0 -or $index -ge $configs.Count) {
            Write-Host "Selezione non valida!" -ForegroundColor Red
            Start-Sleep -Seconds 2
            continue
        }
        
        $selectedConfig = $configs[$index]
        
        try {
            $configData = Get-Content $selectedConfig.FullName -Raw | ConvertFrom-Json
            
            # Mostra anteprima modifiche
            $changes = Get-RegistryChanges -Config $configData
            Show-ChangesPreview -Changes $changes -ProfileName $configData.profile_name
            
            Write-Host "Vuoi procedere con queste modifiche? (S/N): " -NoNewline -ForegroundColor Yellow
            $confirm = Read-Host
            
            if ($confirm -eq "S" -or $confirm -eq "s") {
                Write-Host ""
                Write-Host "Applicazione in corso..." -ForegroundColor Cyan
                
                $result = Apply-RegistryConfig -Config $configData
                
                Write-Host ""
                Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Green
                Write-Host "║                  OPERAZIONE COMPLETATA                   ║" -ForegroundColor Green
                Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Green
                Write-Host ""
                Write-Host "  Modifiche applicate con successo: " -NoNewline -ForegroundColor Cyan
                Write-Host $result.Success -ForegroundColor Green
                Write-Host "  Errori riscontrati: " -NoNewline -ForegroundColor Cyan
                Write-Host $result.Errors -ForegroundColor $(if ($result.Errors -gt 0) { "Red" } else { "Green" })
                Write-Host ""
                Write-Host "  Log disponibile in: $Script:LogPath" -ForegroundColor Gray
                Write-Host ""
                
                if ($configData.requires_reboot) {
                    Write-Host "⚠️  ATTENZIONE: Questo profilo richiede un RIAVVIO del sistema per applicare le modifiche." -ForegroundColor Yellow
                    Write-Host ""
                }
            } else {
                Write-Host "Operazione annullata." -ForegroundColor Yellow
            }
            
        }
        catch {
            Write-Log "Errore critico: $($_.Exception.Message)" -Level ERROR
            Write-Host "Errore durante il caricamento del profilo: $($_.Exception.Message)" -ForegroundColor Red
        }
        
        Write-Host ""
        Write-Host "Premi un tasto per tornare al menu..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}

# Avvia lo script
Main