# 🔧 Registry Automator

Sistema professionale di automazione per la gestione del Registro di Sistema di Windows tramite configurazioni JSON.

## 📁 Struttura del Progetto

```
Script/
│
├── Registry-Automator.ps1          # Script principale
│
├── config/                          # Cartella configurazioni
│   ├── gaming_performance.json
│   ├── network_optimization.json
│   ├── memory_management.json
│   ├── ui_responsiveness.json
│   ├── privacy_optimization.json
│   ├── default_gaming.json         # Rollback gaming
│   └── default_ui.json             # Rollback UI
│
└── logs/                            # Cartella log (creata automaticamente)
    └── registry_execution.log
```

## ⚙️ Requisiti

- **Windows 10/11**
- **PowerShell 5.1** o superiore
- **Privilegi di Amministratore** (obbligatorio)

## 🚀 Installazione

1. Crea la struttura delle cartelle:
   ```
   Script/
   ├── config/
   └── logs/
   ```

2. Posiziona `Registry-Automator.ps1` nella cartella `Script/`

3. Copia tutti i file `.json` nella cartella `config/`

## 📖 Utilizzo

### Avvio dello Script

1. **Clicca destro** su `Registry-Automator.ps1`
2. Seleziona **"Esegui con PowerShell"** come Amministratore

   *oppure*

   Apri PowerShell come Amministratore e digita:
   ```powershell
   cd "C:\percorso\alla\cartella\Script"
   .\Registry-Automator.ps1
   ```

### Workflow Operativo

1. **Menu Principale**: Visualizza tutti i profili disponibili
2. **Selezione Profilo**: Digita il numero corrispondente
3. **Anteprima Modifiche**: Lo script mostra:
   - Path delle chiavi di registro
   - Valori attuali vs nuovi valori
   - Tipo di operazione (CREAZIONE/MODIFICA)
   - Descrizione di ogni modifica
4. **Conferma**: Digita `S` per applicare o `N` per annullare
5. **Esecuzione**: Applicazione automatica con logging
6. **Report Finale**: Riepilogo successi/errori

## 📋 Profili Disponibili

### 🎮 Gaming Performance
**File**: `gaming_performance.json`

Ottimizzazioni complete per il gaming competitivo:
- Disabilita GameDVR (riduce overhead CPU/GPU)
- Priorità GPU massima (valore 8)
- Priorità CPU elevata per i giochi
- Disabilita network throttling
- Massima reattività del sistema

**⚠️ Richiede riavvio**

---

### 🌐 Network Optimization
**File**: `network_optimization.json`

Riduce la latenza di rete:
- Rimuove limitazioni bandwidth
- Priorità massima ai processi in primo piano

**⚠️ Richiede riavvio**

---

### 💾 Memory Management (16GB)
**File**: `memory_management.json`

Gestione ottimizzata della RAM per sistemi con 16GB:
- Alloca 1GB ai processi di sistema
- Kernel sempre residente in RAM
- Prefetching e Superfetch attivi

**⚠️ Richiede riavvio**

---

### 🖥️ UI Responsiveness
**File**: `ui_responsiveness.json`

Velocizza l'interfaccia:
- Menu istantanei (8ms invece di 400ms)
- Riduce timeout app bloccate
- Chiusura automatica app allo spegnimento

**✅ Non richiede riavvio**

---

### 🔒 Privacy & Clean UI
**File**: `privacy_optimization.json`

Migliora privacy e pulisce l'interfaccia:
- Disabilita ricerca Bing nel menu Start
- Rimuove Windows Spotlight
- Elimina pubblicità dalla lock screen

**✅ Non richiede riavvio**

---

### ⬅️ Profili di Rollback

- **default_gaming.json**: Ripristina impostazioni gaming predefinite
- **default_ui.json**: Ripristina interfaccia predefinita

## 🛡️ Sicurezza

### Prima di Usare lo Script

1. **Crea un Punto di Ripristino**:
   - Start → Cerca "Crea punto di ripristino"
   - Clicca su "Crea"
   - Assegna un nome (es. "Pre Registry Automator")

2. **Backup del Registro** (opzionale ma consigliato):
   ```
   Esegui regedit → File → Esporta → Salva backup completo
   ```

### Garanzie dello Script

- ✅ **Validazione dei dati** prima dell'applicazione
- ✅ **Logging completo** di ogni operazione
- ✅ **Gestione errori** robusta con try-catch
- ✅ **Anteprima obbligatoria** prima delle modifiche
- ✅ **Creazione automatica** dei path mancanti

## 📊 Sistema di Logging

Ogni esecuzione viene registrata in `logs/registry_execution.log`:

```
[2024-12-23 14:30:15] [INFO] === AVVIO REGISTRY AUTOMATOR ===
[2024-12-23 14:30:22] [INFO] Inizio applicazione del profilo: Gaming Performance
[2024-12-23 14:30:22] [SUCCESS] Impostato GameDVR_Enabled = 0 in HKCU:\System\GameConfigStore
[2024-12-23 14:30:22] [SUCCESS] Impostato GPU Priority = 8 in HKLM:\SOFTWARE\...
[2024-12-23 14:30:23] [INFO] Applicazione completata: 9 successi, 0 errori
```

### Livelli di Log

- **INFO**: Operazioni normali
- **SUCCESS**: Modifiche applicate con successo
- **WARN**: Avvisi non bloccanti
- **ERROR**: Errori durante l'esecuzione

## 🔄 Come Creare Nuovi Profili

1. Crea un nuovo file `.json` in `config/`
2. Usa questa struttura:

```json
{
  "profile_name": "Nome del Profilo",
  "description": "Breve descrizione",
  "category": "categoria",
  "requires_reboot": true,
  "registries": [
    {
      "path": "HKEY_LOCAL_MACHINE\\Path\\Completo",
      "name": "NomeChiave",
      "value": 0,
      "type": "DWord",
      "description": "Cosa fa questa modifica"
    }
  ]
}
```

### Tipi di Valore Supportati

- `String`: Testo
- `DWord`: Numero intero 32-bit
- `QWord`: Numero intero 64-bit
- `Binary`: Dati binari
- `MultiString`: Array di stringhe
- `ExpandString`: Stringa con variabili d'ambiente

## ⚠️ Avvertenze

- Lo script richiede **privilegi di Amministratore**
- Alcune modifiche necessitano di **riavvio** per essere applicate
- Crea sempre un **punto di ripristino** prima dell'uso
- Testa le modifiche su una **macchina non critica** prima
- I valori ottimali possono variare in base all'**hardware**

## 🐛 Risoluzione Problemi

### Errore: "Impossibile caricare il file di configurazione"
- Verifica che il file JSON sia nella cartella `config/`
- Controlla la sintassi JSON (usa un validatore online)

### Errore: "Accesso negato"
- Assicurati di eseguire PowerShell come **Amministratore**

### Modifiche non applicate
- Controlla il file `logs/registry_execution.log`
- Alcuni profili richiedono un **riavvio del sistema**

### Come Annullare le Modifiche
1. Usa i profili di rollback (`default_*.json`)
2. Oppure ripristina dal punto di ripristino di Windows
3. Oppure importa il backup del registro

## 📚 Risorse Aggiuntive

- Documentazione Microsoft sul Registro: https://docs.microsoft.com/windows/registry
- Backup e ripristino: https://support.microsoft.com/windows/backup

## 🤝 Contributi

Per aggiungere nuovi profili o miglioramenti:
1. Documenta accuratamente ogni modifica
2. Testa su ambiente controllato
3. Includi sempre un profilo di rollback

## 📝 License

Questo progetto è fornito "as-is" senza garanzie. Usalo a tuo rischio.

---

**Versione**: 1.0  
**Ultimo aggiornamento**: Dicembre 2024