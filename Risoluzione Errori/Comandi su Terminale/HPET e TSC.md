# HPET e TSC Problem Resolution

Questa guida fornisce i passaggi tecnici per ottimizzare il sistema di timing su Windows, risolvendo problemi di latenza, micro-stuttering e letture errate della frequenza CPU su processori moderni (AMD Ryzen, Intel Core 12th+ Gen).

*Ispirato dal video di Matt's Computer Services:* [One Trillion GHz! HPET Fix](https://www.youtube.com/shorts/jL8lfpjObuw)

---

## 1. Risoluzione tramite CMD (Amministratore)

Eseguire i seguenti comandi nel **Prompt dei Comandi** con privilegi di amministratore.

### A. Disabilitare il forzamento di HPET
Rimuove la priorità al timer di sistema (HPET) a favore del timer interno alla CPU (TSC).
* **Comando:** `bcdedit /deletevalue useplatformclock`
* **Perché:** HPET è un timer esterno alla CPU situato sulla scheda madre. Interrogarlo introduce latenza. Il TSC è integrato nel chip ed è quasi istantaneo.
* **Ripristino:** `bcdedit /set useplatformclock true`

### B. Disabilitare il Dynamic Tick
Impedisce a Windows di sospendere il timer durante i periodi di inattività per risparmio energetico.
* **Comando:** `bcdedit /set disabledynamictick yes`
* **Perché:** Il "salto" tra stati di attivazione del timer può causare instabilità nel frame rate e input lag.
* **Ripristino:** `bcdedit /deletevalue disabledynamictick`

### C. Gestione del Synthetic Timer
Assicura che il sistema operativo non utilizzi emulazioni software per il tempo.
* **Comando:** `bcdedit /set useplatformtick yes`
* **Perché:** Stabilizza la comunicazione tra hardware e software utilizzando un unico riferimento coerente.
* **Ripristino:** `bcdedit /deletevalue useplatformtick`

---

## 2. Configurazione BIOS/UEFI

Per massimizzare i benefici, disabilita il timer a livello hardware.

1.  Riavvia il PC ed entra nel **BIOS/UEFI** (tasto `CANC` o `F2`).
2.  Cerca impostazioni come: **Advanced** -> **PCH Configuration** o **System Agent**.
3.  Imposta **HPET Support** o **High Performance Event Timer** su **Disabled**.
4.  **Salva ed Esci (F10).**

> [!NOTE]
> Su alcuni laptop o schede madri di ultimissima generazione, questa voce potrebbe essere nascosta poiché il BIOS gestisce tutto automaticamente. In tal caso, affidati solo ai comandi CMD.

---

## 3. Verifica Post-Intervento

Dopo il riavvio, controlla se l'intervento ha avuto successo:

1.  **Task Manager:** Vai in *Prestazioni* > *CPU*. Se prima vedevi velocità assurde (es. >100 GHz), ora dovresti vedere la frequenza reale della tua CPU.
2.  **Latenza:** Utilizza tool come **LatencyMon** per verificare che i DPC latency siano diminuiti.
3.  **FPS:** In titoli CPU-bound (Valorant, CS2), i cali improvvisi di frame dovrebbero essere spariti.

---

## 4. FAQ & Approfondimento Tecnico

### Ho "Time Stamp Counter" presente ma "TSC Adjustment" assente. È un problema?
**No.** È perfettamente normale su processori moderni come gli **AMD Ryzen AI 9 (Zen 5)**.
* **Time Stamp Counter (Presente):** Indica che la tua CPU ha il "cronometro" interno ad alta precisione. È l'unica cosa che conta davvero.
* **TSC Adjustment (Assente):** È una funzione di registro (TSC_ADJUST) usata dal sistema operativo per sincronizzare core che "vanno fuori tempo". Nelle architetture moderne, la sincronizzazione hardware è così avanzata che questa funzione non è necessaria o non viene esposta.

### Perché HPET è un problema sui nuovi PC?
HPET è stato creato quando le CPU non erano abbastanza veloci da gestire il tempo internamente. Oggi, interrogare un componente esterno (HPET) mentre si ha un TSC ultra-rapido è come guidare una Ferrari ma fermarsi ogni 10 metri a chiedere l'ora a un passante invece di guardare il cruscotto.

---

## Sintesi Comandi di Ripristino (Rollback)
Se riscontri instabilità o bug audio, torna alle impostazioni di fabbrica:
```cmd
bcdedit /set useplatformclock true
bcdedit /deletevalue disabledynamictick
bcdedit /deletevalue useplatformtick
```