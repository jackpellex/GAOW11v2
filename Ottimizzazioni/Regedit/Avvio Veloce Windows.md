# Ottimizzazione Avvio Veloce di Windows con Modifiche ai Registri

Questa guida spiega come modificare il Registro di Sistema per eliminare i ritardi dell'interfaccia e velocizzare lo spegnimento del PC.

## 1. Cosa stiamo modificando?

| Parametro | Effetto dell'ottimizzazione |
| --- | --- |
| **AutoEndTasks** | Chiude forzatamente le app aperte allo spegnimento senza chiedere conferma. |
| **HungAppTimeout** | Riduce il tempo che Windows aspetta prima di considerare un'app "bloccata". |
| **MenuShowDelay** | Rende l'apertura dei menu a tendina istantanea (default: 400ms → ottimizzato: 8ms). |
| **LowLevelHooksTimeout** | Velocizza la risposta del sistema agli input (mouse/tastiera) riducendo i tempi di attesa dei processi. |

---

## 2. Procedura Passo-Passo (Manuale)

### Fase A: Navigazione

1. Premi **Windows + R**, digita `regedit` e premi **Invio**.
2. Copia e incolla questo percorso nella barra degli indirizzi in alto e premi **Invio**:
`HKEY_CURRENT_USER\Control Panel\Desktop`

### Fase B: Modifica o Creazione dei Valori

Una volta arrivato nella cartella **Desktop**, controlla l'elenco a destra.

**Se il valore esiste già:**

1. Fai doppio clic sul nome (es. `MenuShowDelay`).
2. Cambia il numero nel campo **Dati valore** con quello indicato nella tabella sotto.
3. Clicca su **OK**.

**Se il valore NON esiste (Creazione):**

1. Fai clic destro su un punto vuoto nel pannello di destra.
2. Seleziona **Nuovo** > **Valore stringa** (REG_SZ).
*(Nota: Per questi specifici parametri servono Valori Stringa, non DWORD).*
3. Digita esattamente il nome del parametro (es. `AutoEndTasks`) e premi **Invio**.
4. Fai doppio clic sul nuovo valore creato e inserisci il numero corrispondente.

### Valori da inserire:

* **AutoEndTasks**: `1`
* **HungAppTimeout**: `1000`
* **MenuShowDelay**: `8`
* **LowLevelHooksTimeout**: `1000`

---

## 3. Applicazione tramite Script (.reg)

Se preferisci non farlo a mano, puoi creare un file automatico:

1. Apri il **Blocco Note**.
2. Incolla il seguente codice:

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Control Panel\Desktop]
"AutoEndTasks"="1"
"HungAppTimeout"="1000"
"MenuShowDelay"="8"
"LowLevelHooksTimeout"="1000"

```

3. Salva il file come **`Ottimizzazione.reg`** (assicurati che l'estensione non sia .txt).
4. Fai doppio clic sul file creato e conferma l'unione al registro.

---

## ⚠️ Avvertenze e Sicurezza

* **Punto di Ripristino:** Obbligatorio prima di iniziare. Cerca "Crea punto di ripristino" in Start e clicca su **Crea**.
* **Riavvio:** Le modifiche avranno effetto solo dopo aver **riavviato il sistema**.

---