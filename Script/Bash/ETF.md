# 📂 Script di Pulizia File Temporanei (ETF - Eliminazione Totalmente Focalizzata)

Questo documento descrive due versioni dello script Windows Batch (`.bat`) progettate per eliminare i file temporanei, i dump e la cache, al fine di migliorare le prestazioni del sistema.

---

## 🚀 1. ETF.bat (Versione Veloce, Senza Conteggio)

Questa versione è ottimizzata per la **velocità** e la **performance**. Il suo obiettivo primario è completare l'eliminazione dei file nel minor tempo possibile, visualizzando a terminale solo i messaggi di successo o gli errori di accesso (file in uso).

### Implementazione e Caratteristiche

* **Focus:** Massima velocità di esecuzione.
* **Visualizzazione:** Mostra solo i file che falliscono nell'eliminazione (`Accesso Negato`) e un riepilogo delle operazioni completate.
* **Codifica:** Utilizza `chcp 65001` per garantire la corretta visualizzazione dei caratteri e degli emoji nel terminale CMD.
* **Eliminazione Directory:** Per cartelle come `%TEMP%` e `C:\Windows\Temp`, lo script tenta di usare `RD /S /Q` (rimozione completa e ricreazione) per una pulizia più radicale e veloce, ignorando la necessità di contare i singoli file.
* **Comandi `DEL`:** Utilizza `DEL /S /F /Q` combinato con la redirezione degli errori (`2>&1`) per una rimozione silenziosa ma che riporta i fallimenti.
* **Pulizia Avanzata (PowerShell):** Sfrutta `PowerShell` per operazioni complesse come:
    * Eliminazione dei file generici `.tmp` e `.dmp` in più percorsi.
    * Pulizia specifica della cache di Chrome ed Edge.
    * Svuotamento del Cestino (`Clear-RecycleBin`).
    * Pulizia dei Log degli Eventi (`wevtutil`).

---

## 📊 2. ETF - Conteggiato.bat (Versione Report, Conteggio Massimizzato)

Questa versione è progettata per fornire una **reportistica** dettagliata. Sacrifica una certa velocità di esecuzione per contare con precisione quanti file o elementi vengono eliminati in quasi tutte le fasi della pulizia.

### Implementazione e Caratteristiche

* **Focus:** Accuratezza del conteggio e reportistica finale.
* **Tecnica di Conteggio:**
    * Abbandona la semplice differenza `DIR Before - DIR After` in Batch (che è lenta).
    * Introduce una funzione avanzata (`:clean_path_ps`) che usa **PowerShell** (`Get-ChildItem | Measure-Object`) prima e dopo la pulizia. Questo è il metodo più accurato per conteggiare i file su Windows in uno script misto Batch/PowerShell.
* **Conteggio Cestino e Cache:** Controlla e aggiunge al totale:
    * Il numero di elementi presenti nel Cestino prima di svuotarlo.
    * Una stima approssimativa degli elementi della cache dei browser prima di eliminarli (in quanto è impossibile contare gli elementi rimasti se il percorso viene eliminato).
* **Pulizia Cartelle:** Non usa `RD /S /Q` per `%TEMP%` e `C:\Windows\Temp`; usa invece la funzione `clean_path_ps` basata su `DEL` per poter contare ogni singolo file eliminato in queste directory.
* **Report Finale:** Stampa un `Totale elementi contati ed eliminati` alla fine, fornendo una visione completa del lavoro svolto.

---

## 🗒️ Avviso Importante per l'Esecuzione

**Entrambi gli script DEVONO essere eseguiti come Amministratore** per poter accedere e cancellare file nelle cartelle di sistema (come `C:\Windows\Temp`, `C:\Windows\SoftwareDistribution`) e per eseguire la pulizia dei Log degli Eventi (`wevtutil`).