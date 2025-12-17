# Diskpart - Gestione Avanzata Dischi e Partizioni

**Diskpart** è un'utility a riga di comando (CLI) integrata in Windows che consente una gestione granulare e potente dei dischi, delle partizioni e dei volumi del sistema. A differenza dell'interfaccia grafica "Gestione disco", Diskpart offre funzionalità avanzate indispensabili per operazioni complesse, script di automazione e risoluzione di problemi.

> **AVVERTENZA DI RISCHIO: L'UTILIZZO IMPROPRIO DI DISKPART PUÒ PORTARE ALLA PERDITA IRREVERSIBILE DEI DATI. PRIMA DI ESEGUIRE QUALSIASI COMANDO DI MODIFICA, ESEGUIRE UN BACKUP COMPLETO DEI DATI IMPORTANTI.**

---

## Avvio di Diskpart

Per utilizzare Diskpart, è necessario avviare il Terminale di Windows (o PowerShell/Prompt dei comandi) con privilegi elevati.

1.  Premi `Win + S` per aprire la ricerca di Windows.
2.  Digita **"Terminale"** o **"PowerShell"**.
3.  Clicca con il tasto destro sul risultato e seleziona **"Esegui come amministratore"**.
4.  Nella finestra del terminale, digita il seguente comando e premi Invio:
    ```powershell
    diskpart
    ```
    Il prompt cambierà in `DISKPART>`, indicando che l'utility è attiva e pronta a ricevere comandi.

---

## Comandi Essenziali: Flusso Operativo

Il flusso di lavoro in Diskpart è sequenziale: prima si visualizzano gli elementi disponibili, poi se ne seleziona uno specifico e infine si esegue un'azione su di esso.

### Help

Il comando più importante è `help`. Usalo per ottenere un elenco completo dei comandi disponibili o informazioni dettagliate su un comando specifico.

| Comando         | Descrizione                                          |
| --------------- | ---------------------------------------------------- |
| `help`          | Mostra l'elenco di tutti i comandi principali.       |
| `help [comando]` | Fornisce la sintassi e i parametri per un comando specifico (es. `help format`). |

### Visualizzazione e Selezione

**Tutte le operazioni successive richiedono una selezione attiva.** L'oggetto selezionato viene contrassegnato da un asterisco (`*`) nell'elenco.

| Comando             | Descrizione                                                                 |
| ------------------- | --------------------------------------------------------------------------- |
| `list disk`         | Elenca tutti i dischi fisici (HDD, SSD, USB) collegati al sistema.          |
| `select disk n`     | Seleziona il disco su cui operare, dove `n` è il numero del disco (es. `select disk 0`). |
| `list partition`    | Mostra tutte le partizioni presenti sul **disco attualmente selezionato**.     |
| `select partition n`| Seleziona una partizione specifica sul disco attivo, dove `n` è il suo numero. |
| `list volume`       | Elenca tutti i volumi (partizioni con lettera di unità) del sistema.         |

---

## Operazioni di Gestione Avanzata

Una volta selezionato un disco o una partizione, è possibile eseguire operazioni di modifica.

### Creazione

Crea una nuova partizione nello spazio non allocato del disco selezionato.

| Comando                           | Descrizione                                                                                                  |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `create partition primary [size=n]` | Crea una partizione primaria. Se `size=n` (in MB) è omesso, utilizza tutto lo spazio non allocato disponibile. |

**Esempio:** Creare una partizione primaria da 50 GB (51200 MB) sul disco selezionato.
```powershell
create partition primary size=51200
````

### Ridimensionamento

Modifica le dimensioni di una partizione esistente.

| Comando               | Descrizione                                                                                                   |
| --------------------- | ------------------------------------------------------------------------------------------------------------- |
| `extend [size=n]`     | Estende il volume selezionato di `n` MB. Richiede **spazio non allocato contiguo** subito dopo la partizione.     |
| `shrink desired=n`      | Riduce il volume selezionato della quantità specificata (`n` in MB). Funziona solo su partizioni formattate in **NTFS**. |

### Formattazione

Prepara una partizione per l'utilizzo da parte del sistema operativo. **Questo comando cancella tutti i dati sulla partizione selezionata.**

| Comando                                  | Descrizione                                                                                                                          |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `format fs=ntfs label="NOME" quick` | Formatta la partizione selezionata. `fs` specifica il file system, `label` assegna un'etichetta e `quick` esegue una formattazione rapida. |

### Assegnazione

Assegna o rimuove una lettera di unità a una partizione.

| Comando             | Descrizione                                                                        |
| ------------------- | ---------------------------------------------------------------------------------- |
| `assign [letter=L]` | Assegna la prima lettera di unità disponibile o quella specificata (es. `assign letter=D`). |
| `remove`            | Rimuove la lettera di unità dalla partizione selezionata.                          |

### Eliminazione

Rimuove una partizione dal disco.

| Comando                    | Descrizione                                                                                                                              |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `delete partition`         | Elimina la partizione selezionata. Non funziona su partizioni di sistema o protette.                                                     |
| `delete partition override`| **Comando critico.** Forza l'eliminazione di una partizione protetta, come una partizione di ripristino. Usare con estrema cautela.        |

-----

## Comandi Utili e Scenari Specifici

Questa sezione copre comandi per scenari più specifici, come la conversione dello stile di partizionamento o l'analisi dettagliata.

### Visualizzazione dei Dettagli

Per ottenere informazioni approfondite su un elemento selezionato.

| Comando            | Descrizione                                                                                             |
| ------------------ | ------------------------------------------------------------------------------------------------------- |
| `detail disk`      | Mostra informazioni dettagliate sul disco selezionato (tipo, ID, stato, volumi contenuti).               |
| `detail partition` | Fornisce dettagli sulla partizione selezionata (tipo, se è nascosta, attiva o di sistema).              |

### Impostare una Partizione Attiva

Questo comando è fondamentale per i dischi con stile di partizionamento **MBR** (Master Boot Record) da cui si intende avviare un sistema operativo.

| Comando  | Descrizione                                                                                                                               |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `active` | Contrassegna la partizione primaria selezionata come "attiva". Il BIOS/firmware cercherà il bootloader del sistema operativo su questa partizione. |

### Conversione dello Stile di Partizionamento

Permette di convertire un disco tra gli stili MBR e GPT (GUID Partition Table). GPT è lo standard moderno, necessario per dischi superiori a 2 TB e per l'avvio UEFI.

> **ATTENZIONE:** La conversione di un disco **elimina tutte le partizioni e i dati** presenti su di esso. Il disco deve essere vuoto.

| Comando       | Descrizione                                                                                                                                       |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `convert gpt` | Converte un disco MBR vuoto nello stile di partizionamento GPT.                                                                                    |
| `convert mbr` | Converte un disco GPT vuoto nello stile di partizionamento MBR.                                                                                    |

**Flusso di lavoro per la conversione:**

1.  Selezionare il disco (`select disk n`).
2.  Pulire il disco da tutte le partizioni (`clean`).
3.  Eseguire il comando di conversione (`convert gpt`).

### Modifica degli Attributi

Permette di modificare gli attributi di un volume o di un disco, come impostarlo in sola lettura per proteggerlo da scritture accidentali.

| Comando                             | Descrizione                                                                                    |
| ----------------------------------- | ---------------------------------------------------------------------------------------------- |
| `attributes volume`                 | Mostra gli attributi del volume selezionato (Sola lettura, Nascosto, ecc.).                      |
| `attributes volume set readonly`    | Imposta l'attributo di sola lettura per il volume selezionato.                                   |
| `attributes volume clear readonly`  | Rimuove l'attributo di sola lettura, rendendo il volume nuovamente scrivibile.                  |

-----

## Pulizia Totale del Disco

Il comando `clean` è uno strumento potente ma distruttivo che rimuove tutte le informazioni di partizionamento e formattazione dal disco selezionato, riportandolo a uno stato non inizializzato. È spesso usato come passaggio preparatorio prima di riconvertire o reinstallare un sistema operativo.

> **AVVERTENZA DI PERICOLO: IL COMANDO `CLEAN` CANCELLA IMMEDIATAMENTE E SENZA CONFERMA L'INTERA STRUTTURA DEL DISCO SELEZIONATO, INCLUSI TUTTI I DATI, LE PARTIZIONI E I VOLUMI. LA PERDITA DI DATI È ISTANTANEA E IRREVERSIBILE.**

| Comando | Descrizione                                                                                                  |
| ------- | ------------------------------------------------------------------------------------------------------------ |
| `clean`   | Rimuove tutte le partizioni e la formattazione dal disco attualmente selezionato, azzerando i primi e gli ultimi settori. |

**Flusso di lavoro tipico per `clean`:**

```powershell
list disk
select disk 1  # Assicurarsi di selezionare il disco corretto!
clean
```

-----

## Conclusione

Per terminare la sessione di Diskpart e tornare al prompt del terminale, usa il comando `exit`.

```powershell
exit
```

Diskpart è uno strumento eccezionale per chiunque necessiti di un controllo completo sulla gestione dei dischi. La sua potenza richiede però una grande responsabilità: verifica sempre due volte le tue selezioni prima di eseguire qualsiasi comando di modifica.