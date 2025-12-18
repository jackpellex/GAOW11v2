# Guida: Disabilitare la Ricerca Online nel Menu Start (Windows 11)

Se vuoi evitare che Windows mostri i risultati di Bing o suggerimenti web quando cerchi un file nel menu Start, puoi intervenire tramite il Registro di Sistema. Questa procedura è utile per migliorare la privacy e la velocità della ricerca locale.

---

## Procedura tramite Registro di Sistema

1. Premi **Windows + R**, digita **regedit** e premi **Invio**.
2. Copia e incolla il seguente percorso nella barra degli indirizzi:
`HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer`
3. **Se la chiave "Explorer" non esiste:** fai clic destro sulla cartella `Windows`, seleziona **Nuovo** > **Chiave** e nominala `Explorer`.
4. Fai clic destro sulla cartella **Explorer**, seleziona **Nuovo** > **Valore DWORD (32 bit)**.
5. Nomina il nuovo valore **DisableSearchBoxSuggestions**.
6. Fai doppio clic su di esso e imposta i **Dati valore** a **1**.
* **1** = Ricerca online disabilitata (mostra solo risultati locali).
* **0** = Ricerca online abilitata (impostazione predefinita).


7. Riavvia il computer o riavvia il processo "Esplora risorse" da Gestione Attività per rendere effettive le modifiche.

---

### Tabella dei Valori

| Nome Valore | Valore | Effetto |
| --- | --- | --- |
| **DisableSearchBoxSuggestions** | **1** | Disabilita Bing e i suggerimenti web nel Menu Start |
| **DisableSearchBoxSuggestions** | **0** | Ripristina i risultati di ricerca online |

### Perché farlo?

* **Privacy:** Evita che ogni termine digitato nel menu Start venga inviato ai server Microsoft.
* **Prestazioni:** Riduce il carico sulla CPU e sulla rete, rendendo l'apertura dei risultati locali (app e file) istantanea.
* **Pulizia Visiva:** Rimuove la confusione visiva causata da notizie e immagini promozionali all'interno del menu di ricerca.

---