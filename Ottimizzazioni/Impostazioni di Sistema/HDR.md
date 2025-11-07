# ⚙️ Ottimizzazione HDR in Windows

Questa guida illustra come configurare l'HDR (High Dynamic Range) in Windows, offrendo due profili distinti: uno focalizzato sulla **massima qualità visiva** e uno orientato al **risparmio energetico**, integrando anche suggerimenti di calibrazione e compatibilità.

## 🖥️ Accesso alle Impostazioni HDR

È possibile accedere alle impostazioni HDR attraverso il seguente percorso in Windows:

**`Impostazioni` > `Sistema` > `Schermo` > `HDR`**

---

## ⚡ Profilo 1: Alta Qualità Visiva (Qualità $\uparrow$, Batteria $\downarrow$)

Questo profilo è **consigliato per PC fissi** o per l'utilizzo di PC portatili **collegati all'alimentazione**.

### A. Impostazioni Schermo (HDR)

| Impostazione | Stato | Descrizione |
| :--- | :--- | :--- |
| **Flusso Video HDR** | **[Attivato]** | Aumenta la luminosità dello schermo e migliora la gamma di colori per i contenuti HDR. |

### B. Impostazioni di Riproduzione Video

Accedi a: **`Impostazioni` > `App` > `Riproduzione video`**

| Impostazione | Stato | Note |
| :--- | :--- | :--- |
| Elabora automaticamente il video per migliorarlo | **[Attivato]** | Sfrutta l'hardware per migliorare la qualità. |
| Salva larghezza di banda della rete riproducendo a una risoluzione inferiore | **[Disattivato]** | Privilegia la riproduzione in alta risoluzione. |
| **Opzioni batteria** (Mentre si guarda un video) | **[Ottimizza per qualità video]** | |
| Riproduci video a una risoluzione inferiore con alimentazione a batteria | **[Disattivato]** | Anche a batteria, tenta la riproduzione in alta risoluzione. |

---

## 🔋 Profilo 2: Normale Qualità e Risparmio Energetico (Qualità $\approx$, Batteria $\uparrow$)

Questo profilo è **consigliato per PC portatili** utilizzati con l'alimentazione a **batteria**.

### A. Impostazioni Schermo (HDR)

| Impostazione | Stato | Descrizione |
| :--- | :--- | :--- |
| **Flusso Video HDR** | **[Disattivato]** | Disattiva l'aumento di luminosità e la gestione colori aggressiva per i contenuti video. |

### B. Impostazioni di Riproduzione Video

Accedi a: **`Impostazioni` > `App` > `Riproduzione video`**

| Impostazione | Stato | Note |
| :--- | :--- | :--- |
| Elabora automaticamente il video per migliorarlo | **[Disattivato]** | Riduce il carico sulla GPU. |
| Salva larghezza di banda della rete riproducendo a una risoluzione inferiore | **[Attivato]** | Utilizza meno dati e richiede meno potenza di elaborazione. |
| **Opzioni batteria** (Mentre si guarda un video) | **[Ottimizza per durata della batteria]** | |
| Riproduci video a una risoluzione inferiore con alimentazione a batteria | **[Attivato]** | Imposta automaticamente una risoluzione inferiore quando il PC non è in carica. |

---

## ✨ Suggerimenti per la Calibrazione e la Compatibilità HDR

### 1. Calibrazione per Colori Accurati

Per garantire che sia i contenuti SDR che HDR abbiano colori e luminosità bilanciati:

* **Utilizza l'app "Windows HDR Calibration"** disponibile sul Microsoft Store.
* L'app ti guiderà nella regolazione dei livelli di **nero**, **bianco** e della **saturazione** per ottimizzare la resa visiva del tuo display.

### 2. Controlli Essenziali di Compatibilità

L'HDR richiede che l'intera catena hardware e software sia compatibile:

* **Display:** Il monitor deve supportare l'HDR (es. DisplayHDR 400+).
* **Cavo:** Usa un cavo compatibile (es. **DisplayPort 1.4** o **HDMI 2.0/2.1**).
* **Contenuto:** Assicurati che il contenuto che stai visualizzando (gioco, film) sia effettivamente codificato in HDR (**HDR10**, **Dolby Vision**).

### 3. TV e Gaming HDR

Se usi il PC collegato a una TV per il gaming in HDR:

* **Attiva la "Modalità Gioco" (Game Mode)** sulla TV. Questo riduce l'input lag disattivando le elaborazioni video post-segnale e garantisce un'esperienza di gioco più fluida con l'HDR attivo.