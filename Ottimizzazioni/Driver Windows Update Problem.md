# Disabilitazione Installazione Automatica Driver via Windows Update

Configurazione del sistema per impedire a Windows Update di scaricare e installare automaticamente i driver hardware. Questa procedura previene la sovrascrittura indesiderata dei driver proprietari (produttore) con versioni generiche o obsolete fornite da Microsoft, risolvendo problemi di instabilità, conflitti hardware e cali di prestazioni su PC nuovi o appena formattati.

**Classificazione Rischio**: `[BASSO]`

**Impatto su**:

* **Stabilità**: Positivo (evita conflitti tra driver proprietari e generici)
* **Gaming**: Positivo (garantisce il mantenimento dei driver GPU/Chipset ottimizzati dal produttore)
* **Produttività**: Positivo (previene modifiche inaspettate alle periferiche)
* **Sicurezza**: Neutro (richiede gestione manuale degli aggiornamenti critici dei driver)
* **Manutenzione**: Richiede attenzione (l'utente deve aggiornare i driver manualmente)

---

## Metodo 1: Editor del Registro (Regedit)

Questo metodo è applicabile a tutte le edizioni di Windows 11 (Home, Pro, Enterprise).

### Percorso del Registro

```
Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate

```

### Tabella Parametri e Valori

| Nome Valore | Tipo | Default | Ottimizzato | Note |
| --- | --- | --- | --- | --- |
| ExcludeWUDriversInQualityUpdate | REG_DWORD | Non esiste / `0` | `1` | Impedisce l'inclusione dei driver negli aggiornamenti di qualità. Base Decimale. |

**Nota sulla chiave WindowsUpdate**: Se la chiave `WindowsUpdate` non esiste sotto il percorso `Policies\Microsoft\Windows`, è necessario crearla manualmente:

1. Tasto destro su `Windows` > Nuovo > Chiave.
2. Rinominare la nuova chiave in `WindowsUpdate`.
3. All'interno, creare il valore DWORD indicato in tabella.

---

## Metodo 2: Criteri di Gruppo (GPO)

Questo metodo è l'alternativa ufficiale per le versioni **Windows 11 Pro, Enterprise ed Education**. Offre un'interfaccia grafica per gestire la stessa impostazione del registro.

### Procedura

1. Premere `Win + R`, digitare `gpedit.msc` e premere Invio.
2. Navigare nel seguente percorso all'interno dell'albero a sinistra:
```
Configurazione computer > Modelli amministrativi > Componenti di Windows > Windows Update > Gestisci gli aggiornamenti offerti da Windows Update

```


3. Nel pannello di destra, individuare la voce: **"Non includere i driver negli aggiornamenti di Windows"**.
4. Fare doppio clic sulla voce e impostare lo stato su **Attivata**.
5. Cliccare su "Applica" e poi su "OK".

---

## Avvertenze e Note

**Gestione Manuale dei Driver**: Applicando questa modifica, Windows non cercherà più aggiornamenti per scheda video, scheda madre, audio, rete, stampanti, ecc. È responsabilità dell'utente scaricare i driver aggiornati direttamente dai siti dei produttori (es. NVIDIA, AMD, Intel, Realtek).

**Scenari di utilizzo critici**:

* **Laptop Gaming/Workstation**: Fondamentale per evitare che Windows sovrascriva i driver GPU dedicati (spesso più recenti) con versioni Windows Store più vecchie.
* **Audio Pro**: Previene la sostituzione di driver ASIO specifici con driver generici "High Definition Audio".

**Reversibilità**:

* **Regedit**: Impostare `ExcludeWUDriversInQualityUpdate` su `0` o eliminare la chiave.
* **GPO**: Impostare la policy su "Non configurata".
Dopo il ripristino, riavviare il sistema ed eseguire una ricerca manuale su Windows Update per riprendere l'installazione automatica dei driver.

**Device Installation Settings**: Questa guida agisce specificamente su Windows Update. Esiste un'impostazione secondaria in *Pannello di Controllo > Sistema > Impostazioni di sistema avanzate > Hardware > Impostazioni installazione dispositivi*. Sebbene correlata, la modifica via Registro/GPO qui descritta è più efficace e granulare per il blocco degli aggiornamenti via Windows Update.