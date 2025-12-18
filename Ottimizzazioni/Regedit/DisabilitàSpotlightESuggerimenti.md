# Disabilitare Windows Spotlight e Suggerimenti

Questa procedura permette di rimuovere gli sfondi dinamici di Windows Spotlight, le pubblicità e i contenuti suggeriti dalla schermata di blocco, migliorando la pulizia del sistema e la privacy.

---

### Passaggi per la configurazione

1. Premi **Windows + R**, digita **regedit** e premi **Invio**.
2. Naviga nel seguente percorso:
`HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager`
3. Nel pannello di destra, fai clic destro su uno spazio vuoto e seleziona **Nuovo** > **Valore DWORD (32-bit)**.
4. Crea e configura i seguenti due valori:
* **RotatingLockScreenEnabled**: imposta i dati valore a **0**.
* **RotatingLockScreenOverlayEnabled**: imposta i dati valore a **0**.


5. Riavvia il computer per applicare le modifiche.

---

### Tabella dei Valori

| Nome Valore | Dati Valore | Effetto |
| --- | --- | --- |
| **RotatingLockScreenEnabled** | **0** | Disabilita la rotazione automatica degli sfondi (Spotlight) |
| **RotatingLockScreenOverlayEnabled** | **0** | Rimuove icone, curiosità e pubblicità dalla Lock Screen |

---

### Nota sulla Ricerca Online

Se desideri bloccare anche i suggerimenti di Bing nel menu Start, ricorda che la chiave `Explorer` va creata sotto `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\` se non è già presente. All'interno, dovrai impostare il valore `DisableSearchBoxSuggestions` a **1**.

---

**Risultato:** Dopo il riavvio, la schermata di blocco non mostrerà più contenuti dinamici o promozionali gestiti dai server Microsoft.
