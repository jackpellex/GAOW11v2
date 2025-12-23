# Registry Automator

## Obiettivo del Progetto

Sviluppo di uno strumento di automazione basato su PowerShell per la gestione programmatica del Registro di Sistema di Windows tramite file di configurazione esterni in formato JSON.

## Architettura del Sistema

Il progetto si basa sulla separazione netta tra logica di esecuzione e dati di configurazione, seguendo i principi di modularità e manutenibilità del software.

### Componenti Core

* **Engine (PowerShell):** Motore di esecuzione che processa le istruzioni, gestisce le eccezioni e interagisce con le API di sistema.
* **Configuration Layer (JSON):** Definizione dello stato desiderato del sistema (Desired State) attraverso oggetti strutturati.
* **Logging System:** Meccanismo di tracciamento persistente su file per il monitoraggio delle operazioni e il debugging.

---

## Funzionalità Implementate

1. **Parsing Dinamico:** Caricamento e deserializzazione di file JSON per la mappatura degli attributi del registro.
2. **Gestione degli Errori (Robustness):** Implementazione di blocchi try-catch per prevenire crash in caso di permessi insufficienti o percorsi non validi.
3. **Idempotenza Parziale:** Verifica della presenza delle chiavi prima della scrittura e creazione automatica dei percorsi mancanti.
4. **Logging Strutturato:** Registrazione temporale di ogni operazione con livelli di severità (INFO, WARN, ERROR).

---

## Workflow di Utilizzo

1. **Analisi:** Identificazione delle chiavi di registro target.
2. **Configurazione:** Popolamento del file `config.json` con i parametri (Path, Name, Value, Type).
3. **Esecuzione:** Avvio dello script con privilegi elevati e inserimento del percorso del profilo desiderato.
4. **Verifica:** Analisi del file `registry_execution.log` per confermare l'esito delle operazioni.

## Sviluppi Futuri e Approccio Accademico

* **Validazione Schematica:** Implementazione di un controllo preventivo sulla validità dei tipi di dati JSON rispetto ai requisiti di Windows.
* **Strategia di Rollback:** Utilizzo di file JSON speculari ("Default Settings") per il ripristino dei parametri di fabbrica, evitando l'uso di file .reg binari e mantenendo la leggibilità del codice.
* **Dry-Run Mode:** Simulazione delle modifiche senza impatto reale sul sistema per test di sicurezza.

la validazione dei dati è un passaggio fondamentale: dimostra che il tuo software non è solo uno "script che esegue comandi", ma un'applicazione robusta che previene stati di errore incoerenti.

---