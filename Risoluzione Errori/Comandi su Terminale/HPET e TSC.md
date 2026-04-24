# HPET e TSC Problem Resolution

Questa guida spiega come risolvere i problemi di latenza e cali di performance (FPS bassi) su processori moderni causati dall'uso del timer di sistema errato. Nei sistemi recenti, l'uso del vecchio **HPET** (High Performance Event Timer) può creare colli di bottiglia, mentre il **TSC** (Time Stamp Counter) integrato nelle CPU moderne offre maggiore precisione e latenza quasi nulla.

*Ispirato dal video di Matt's Computer Services:* [One Trillion GHz! HPET Fix](https://www.youtube.com/shorts/jL8lfpjObuw)

---

## 1. Risoluzione tramite Prompt dei Comandi (CMD)

Eseguire tutti i comandi in un **Prompt dei Comandi (CMD) come Amministratore**.

### A. Disabilitare l'uso forzato di HPET
Questo comando rimuove la forzatura del clock di piattaforma, permettendo a Windows di utilizzare il TSC della CPU.
* **Comando:** `bcdedit /deletevalue useplatformclock`
* **Perché:** HPET comunica tramite il chipset, introducendo latenza. TSC è interno alla CPU e molto più veloce. Rimuovendo questo valore, Windows smette di dare priorità al timer lento.
* **Ripristino (Rollback):** `bcdedit /set useplatformclock true`

### B. Disabilitare il Dynamic Tick (Ottimizzazione extra)
Il Dynamic Tick permette a Windows di fermare il timer della CPU quando non ci sono processi attivi per risparmiare energia, ma può causare micro-stuttering nei giochi.
* **Comando:** `bcdedit /set disabledynamictick yes`
* **Perché:** Mantiene il timer della CPU costante, eliminando le fluttuazioni di latenza causate dal risparmio energetico del kernel.
* **Ripristino (Rollback):** `bcdedit /deletevalue disabledynamictick`

### C. Forzare l'uso del Synthetic Timers (Opzionale per maggiore stabilità)
Assicura che il sistema utilizzi un tick rate costante.
* **Comando:** `bcdedit /set useplatformtick yes`
* **Perché:** Garantisce che il sistema operativo utilizzi un'unica fonte di clock coerente, evitando conflitti tra i vari timer hardware.
* **Ripristino (Rollback):** `bcdedit /deletevalue useplatformtick`

---

## 2. Configurazione BIOS/UEFI

Per una risoluzione definitiva, è consigliabile disattivare HPET a livello hardware, se la scheda madre lo consente.

1.  Riavvia il PC ed entra nel **BIOS/UEFI** (solitamente premendo `CANC`, `F2` o `F12`).
2.  Cerca la sezione **Advanced**, **PCH Configuration** o **Settings**.
3.  Individua la voce **HPET Support** o **High Performance Event Timer**.
4.  Imposta il valore su **Disabled**.
5.  Salva ed esci (`F10`).

*Nota: Alcune schede madri moderne non mostrano più questa opzione perché la gestione è delegata interamente al sistema operativo o integrata nel chipset in modo non disattivabile.*

---

## 3. Verifica Post-Intervento

Dopo aver eseguito i comandi e riavviato il PC, verifica che la procedura sia andata a buon fine:

1.  **Task Manager:** Apri *Gestione Attività* (Ctrl+Shift+Esc) > Scheda *Prestazioni* > *CPU*.
    * **Risultato corretto:** La velocità della CPU deve mostrare valori reali (es. 3.60 GHz, 4.80 GHz).
    * **Problema:** Se vedi valori assurdi (es. 100+ GHz o 1.000.000 GHz), Windows sta ancora calcolando male il tempo a causa di HPET.
2.  **Performance in gioco:** Dovresti notare un aumento dei frame rate minimi (1% low) e una maggiore fluidità generale, specialmente in titoli CPU-bound come Valorant o CS2.

---

## Sintesi Comandi di Ripristino
In caso di instabilità del sistema, usa questi comandi per tornare alle impostazioni originali:
```cmd
bcdedit /set useplatformclock true
bcdedit /deletevalue disabledynamictick
bcdedit /deletevalue useplatformtick
```