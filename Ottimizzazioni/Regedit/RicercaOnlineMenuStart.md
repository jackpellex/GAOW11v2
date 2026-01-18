# Disabilitazione Ricerca Web Menu Start - Blocco Suggerimenti Bing

Disattivazione dell'integrazione di ricerca web e suggerimenti Bing nel menu Start di Windows per limitare la ricerca ai soli risultati locali, migliorare la privacy eliminando la trasmissione delle query ai server Microsoft e ridurre la latenza della ricerca.

**Classificazione Rischio**: `[BASSO]`

**Impatto su**:
- Gaming: Neutro
- Produttività: Positivo (ricerca più veloce e focalizzata su contenuti locali)
- Sicurezza: Neutro
- Privacy: Positivo (eliminazione trasmissione query di ricerca a Microsoft/Bing)
- Stabilità: Neutro

---

## Percorso del Registro

```
Computer\HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer
```

---

## Tabella Parametri e Valori

| Nome Valore | Tipo | Default | Ottimizzato | Note |
|:---|:---|:---|:---|:---|
| DisableSearchBoxSuggestions | REG_DWORD | Non esiste (ricerca web attiva) | `1` | Disabilita Bing e suggerimenti web nel Menu Start. Base Decimale. |

**Nota sulla chiave Explorer**: La chiave `Explorer` sotto il percorso `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows` potrebbe non esistere di default. Se assente, deve essere creata manualmente:
1. Navigare fino a `Computer\HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows`
2. Tasto destro sulla chiave `Windows` > Nuovo > Chiave
3. Nominare la nuova chiave esattamente `Explorer`
4. All'interno della chiave `Explorer`, creare il valore DWORD `DisableSearchBoxSuggestions` e impostarlo a `1`

**Comportamento del valore**:
- Valore assente o `0`: Ricerca web attiva. Ogni query nel menu Start viene inviata a Bing, risultati web/immagini/notizie vengono mostrati insieme ai risultati locali.
- Valore `1`: Ricerca limitata esclusivamente a contenuti locali (applicazioni installate, file, impostazioni). Nessuna comunicazione con server esterni.

---

## Configurazione tramite file .reg

### Script Ottimizzato

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]
"DisableSearchBoxSuggestions"=dword:00000001
```

### Script Default

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]
```

**Nota sullo script default**: Il prefisso `-` davanti al percorso elimina completamente la chiave `Explorer` e tutti i suoi valori, ripristinando il comportamento predefinito di Windows (ricerca web attiva). Questo è il metodo più pulito per annullare la modifica, poiché il valore non esiste nativamente nel registro di Windows.

---

## Approfondimento Tecnico

### Funzionamento della Ricerca Menu Start

Il menu Start di Windows 11 integra un sistema di ricerca unificato che combina:
1. **Indexing locale**: Indicizzazione continua di file, applicazioni e impostazioni di sistema tramite Windows Search Service
2. **Ricerca web Bing**: Integrazione con il motore di ricerca Bing per risultati online
3. **Suggerimenti contestuali**: Raccomandazioni basate su cronologia ricerche e profilo utente

**Architettura tecnica**:

Quando l'utente digita nel menu Start, il processo `SearchApp.exe` (SearchHost) esegue:
1. Query locale sull'indice di Windows Search (istantanea, <50ms)
2. Query HTTP/HTTPS ai server Bing se la ricerca web è attiva (latenza 100-500ms)
3. Aggregazione e ranking dei risultati combinati
4. Rendering dell'interfaccia con risultati miscelati

**Comportamento con ricerca web attiva**:
- Ogni carattere digitato genera potenzialmente una richiesta di rete (con debouncing di ~300ms)
- Le query vengono trasmesse in chiaro HTTPS a `www.bing.com` con identificatori di sessione
- I risultati includono: applicazioni locali, file, impostazioni, risultati web Bing, immagini, notizie, suggerimenti pubblicitari
- Metadata associati: timestamp, query precedenti, localizzazione approssimativa

**Comportamento con DisableSearchBoxSuggestions=1**:
- Nessuna comunicazione di rete durante la ricerca
- Risultati limitati esclusivamente all'indice locale
- Latenza ridotta: eliminazione del wait per timeout rete o risposta server
- Nessuna telemetria di ricerca inviata a Microsoft

### Impatto su Privacy e Telemetria

**Dati trasmessi con ricerca web attiva**:
- Ogni query digitata nel menu Start (incluse ricerche parziali, errori di battitura)
- Timestamp preciso delle ricerche
- Identificatore univoco della sessione di Windows
- Indirizzo IP (da cui si può dedurre localizzazione approssimativa)
- Lingua e impostazioni regionali
- Risultati su cui l'utente ha cliccato (click-through tracking)

**Utilizzo dei dati da parte di Microsoft**:
- Personalizzazione risultati di ricerca
- Metriche di utilizzo e engagement
- Profilazione comportamentale (in aggregato)
- Targeting pubblicitario su servizi Microsoft
- Training algoritmi di ranking

**Eliminazione con DisableSearchBoxSuggestions=1**:
- Zero trasmissione dati di ricerca a server esterni
- Nessun tracking delle query
- Eliminazione del profilo di ricerca associato all'utente

### Impatto su Prestazioni

**Overhead ricerca web attiva**:
- Latenza rete: 100-500ms per query (varia con qualità connessione)
- Utilizzo CPU: 5-10% addizionale per rendering risultati web/immagini
- Utilizzo RAM: 50-150MB addizionali per cache risultati web
- Traffico rete: 50-200KB per query (immagini, metadata, ads)

**Benefici disabilitazione**:
- Ricerca istantanea (<50ms) limitata all'indice locale
- Riduzione utilizzo CPU e RAM
- Zero traffico di rete in background durante ricerca
- Interfaccia più pulita e focalizzata

**Riferimenti**:
- [Microsoft Docs - Windows Search Overview](https://docs.microsoft.com/en-us/windows/win32/search/-search-3x-wds-overview)
- [Microsoft Privacy Statement - Search and Browsing History](https://privacy.microsoft.com/en-us/privacystatement)

---

## Impatto sulla Sicurezza

**Impatto positivo sulla privacy**:
- Eliminazione completa della trasmissione delle query di ricerca ai server Microsoft
- Blocco del profiling comportamentale basato sulle ricerche
- Riduzione della superficie di esposizione dati personali
- Nessun leak involontario di informazioni sensibili cercate localmente (nomi file, password digitate accidentalmente, query private)

**Riduzione superficie di attacco (marginale)**:
- Eliminazione del vettore di attacco tramite risultati web malevoli (phishing links travestiti da risultati legittimi)
- Riduzione dell'esposizione a contenuti pubblicitari potenzialmente compromessi
- Meno codice attivo (rendering web) riduce marginalmente la superficie di exploit

**Nessun impatto negativo sulla sicurezza del sistema**: La ricerca locale rimane pienamente funzionale con tutte le caratteristiche di sicurezza intatte.

---

## Scenari Sconsigliati

- **Utenti che utilizzano abitualmente la ricerca web integrata**: Se si cerca frequentemente informazioni online direttamente dal menu Start (definizioni, conversioni, meteo, news), la disabilitazione richiederà l'apertura manuale del browser.
- **Ambienti aziendali con policy di monitoraggio ricerche**: Alcune organizzazioni potrebbero richiedere il logging delle ricerche per compliance o auditing. Verificare policy aziendali prima della modifica.
- **Utenti con indice locale corrotto o limitato**: Se l'indicizzazione di Windows Search non funziona correttamente, la ricerca web può compensare parzialmente fornendo risultati alternativi.

---

## Troubleshooting

**Sintomo**: Il menu Start continua a mostrare risultati web anche dopo l'applicazione dello script.  
**Causa**: Il processo SearchHost non è stato riavviato o la modifica non è stata applicata correttamente.  
**Soluzione**: Riavviare il processo SearchHost. Aprire Task Manager (Ctrl+Shift+Esc), cercare "SearchHost.exe" o "Search" nei processi, terminarlo (tasto destro > Termina attività). Il processo si riavvierà automaticamente. In alternativa, riavviare completamente il sistema. Verificare tramite Regedit che il valore `DisableSearchBoxSuggestions` sia effettivamente impostato a `1` nel percorso corretto.

**Sintomo**: La ricerca del menu Start non trova più file o applicazioni dopo la disabilitazione.  
**Causa**: Problema con l'indicizzazione di Windows Search, non correlato alla disabilitazione della ricerca web.  
**Soluzione**: Ricostruire l'indice di Windows Search. Impostazioni > Privacy e sicurezza > Ricerca di Windows > Trova i miei file > Modalità avanzata (selezionare). Poi Impostazioni > Privacy e sicurezza > Ricerca di Windows > Impostazioni di indicizzazione avanzate > Ricostruisci. Il processo può richiedere 30-60 minuti su sistemi con molti file.

**Sintomo**: Impossibile creare la chiave Explorer (errore di accesso negato).  
**Causa**: Regedit non è stato eseguito con privilegi amministrativi o l'account utente non ha permessi sufficienti.  
**Soluzione**: Chiudere Regedit. Tasto destro su Regedit > Esegui come amministratore. Riprovare la creazione della chiave. Se il problema persiste, verificare i permessi dell'account utente. Su account non amministratore, potrebbe essere necessario richiedere privilegi temporanei.

**Sintomo**: La ricerca diventa più lenta dopo la disabilitazione.  
**Causa**: Paradossalmente, se l'indice locale è corrotto o incompleto, i risultati web veloci possono mascherare la lentezza della ricerca locale. La disabilitazione espone il problema sottostante.  
**Soluzione**: Ricostruire l'indice di Windows Search come descritto sopra. Verificare che Windows Search Service sia in esecuzione (Services.msc > Windows Search > stato: In esecuzione, Avvio: Automatico). Aggiungere manualmente cartelle importanti all'indicizzazione se non già presenti.

**Sintomo**: Alcuni risultati precedentemente trovati non compaiono più.  
**Causa**: Quei risultati provenivano da Bing (definizioni, conversioni, informazioni web) e non erano presenti localmente.  
**Soluzione**: Accettare il trade-off (privacy vs. convenienza) o utilizzare direttamente un browser per ricerche web. In alternativa, creare collegamenti locali a siti frequentemente cercati per accesso rapido.

**Sintomo**: Lo script default non ripristina la ricerca web.  
**Causa**: L'eliminazione della chiave Explorer potrebbe non essere sufficiente se esistono altre policy.  
**Soluzione**: Verificare manualmente che la chiave `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer` sia stata completamente eliminata. Se persiste, eliminarla manualmente: tasto destro sulla chiave Explorer > Elimina. Riavviare. Verificare anche eventuali Group Policy aziendali che potrebbero forzare la disabilitazione: eseguire `gpresult /h report.html` e aprire il report per verificare policy attive.

---

## Avvertenze e Note

**Creare sempre un Punto di Ripristino del sistema** prima di applicare qualsiasi modifica al registro.

**Riavvio processo non richiesto ma consigliato**: La modifica viene applicata al riavvio del processo SearchHost.exe o del sistema. Per applicazione immediata senza riavvio completo:
1. Task Manager (Ctrl+Shift+Esc)
2. Cercare "SearchHost.exe" o "Search"
3. Tasto destro > Termina attività
4. Il processo si riavvierà automaticamente con le nuove impostazioni

In alternativa, riavviare Explorer.exe:
1. Task Manager > Esplora risorse
2. Tasto destro > Riavvia

**Differenza rispetto a disabilitare Cortana**: Questa modifica disabilita solo la ricerca web Bing nel menu Start. Cortana (assistente vocale) è un componente separato che può essere disabilitato indipendentemente tramite Impostazioni > Privacy e sicurezza > Voce > Cortana.

**Interazione con Edge e ricerca Windows**: La disabilitazione non influisce su Edge o sulla ricerca effettuata direttamente in un browser. Influisce esclusivamente sulla ricerca nel menu Start.

**Ottimizzazione complementare - Disabilitazione cronologia ricerche**: Per ulteriore privacy, considerare:
- Impostazioni > Privacy e sicurezza > Autorizzazioni di ricerca > Cronologia > Disattiva
- Impostazioni > Privacy e sicurezza > Autorizzazioni di ricerca > Cancella cronologia dispositivo

**Pulizia cache ricerche precedenti**: Dopo la disabilitazione, eliminare cache ricerche web:
1. Eliminare cartella `%LOCALAPPDATA%\Packages\Microsoft.Windows.Search_*\LocalState`
2. Riavviare processo SearchHost

**Indicizzazione ottimale per ricerca locale efficiente**: Per massimizzare le prestazioni della ricerca locale dopo la disabilitazione:
- Verificare che cartelle importanti siano indicizzate: Impostazioni > Privacy e sicurezza > Ricerca di Windows > Modalità avanzata
- Aggiungere manualmente percorsi: Impostazioni indicizzazione avanzate > Aggiungi
- Escludere cartelle non necessarie per ridurre overhead: temp, cache, download

**Alternative per ricerca web rapida**:
- Installare estensioni browser per quick search (Ctrl+Space)
- Configurare hotkey personalizzate per aprire browser con ricerca preimpostata
- Utilizzare PowerToys Run (Microsoft PowerToys) come launcher alternativo con ricerca web opzionale

**Verifica applicazione modifica**: Per confermare che la modifica è attiva:
1. Aprire menu Start (tasto Windows)
2. Digitare una query che genererebbe risultati web (es. "meteo", "notizie", definizione di una parola)
3. Se compaiono solo risultati locali (applicazioni, file, impostazioni), la modifica è attiva
4. Se compaiono risultati Bing, news, immagini, la modifica non è stata applicata

**Compatibilità con Windows 11 versioni**: Questa modifica funziona su tutte le versioni di Windows 11 (21H2, 22H2, 23H2, 24H2). Il percorso del registro e il nome del valore sono rimasti consistenti.

**Group Policy equivalente**: Su Windows Pro/Enterprise/Education, è possibile applicare questa modifica tramite Group Policy:
- `gpedit.msc` > Configurazione utente > Modelli amministrativi > Componenti di Windows > Esplora file > Disattiva visualizzazione voci recenti di ricerca nella casella di ricerca di Esplora file > Attiva

**Reversibilità completa e immediata**: La modifica è completamente reversibile tramite lo script default. Nessun dato viene perso, l'indice locale rimane intatto.

**Interazione con altri tweak**: Questa ottimizzazione è indipendente e complementare a modifiche di privacy, prestazioni o rete. Non presenta conflitti noti con altre ottimizzazioni del registro.

**Beneficio cumulativo con altre ottimizzazioni privacy**: Per un profilo privacy completo, combinare con:
- Disabilitazione Windows Spotlight
- Disabilitazione telemetria (DiagTrack service)
- Disabilitazione suggerimenti app (ContentDeliveryManager tweaks)
- Blocco pubblicità Microsoft (hosts file o Pi-hole)