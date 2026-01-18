# Ottimizzazione Priorità GPU e CPU per Gaming

Configurazione dei parametri di pianificazione delle risorse (CPU e GPU) dedicati ai giochi per ridurre la latenza, migliorare la stabilità degli FPS e massimizzare la reattività del sistema durante le sessioni di gioco.

**Classificazione Rischio**: `[BASSO]`

**Impatto su**:
- Gaming: Positivo
- Produttività: Neutro (possibile interferenza con applicazioni in background durante il gaming)
- Sicurezza: Neutro
- Privacy: Neutro
- Stabilità: Neutro

---

## Percorso del Registro

```
Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games
```

---

## Tabella Parametri e Valori

| Nome Valore | Tipo | Default | Ottimizzato | Note |
|:---|:---|:---|:---|:---|
| GPU Priority | REG_DWORD | `8` | `8` | Priorità massima GPU per il gioco. Base Decimale. Range: 1-8. |
| Priority | REG_DWORD | `6` | `6` | Priorità alta del thread CPU per il gioco. Base Decimale. Range: 1-6. |
| Scheduling Category | REG_SZ | `Low` | `High` | Categoria di pianificazione ad alta priorità. |
| SFIO Priority | REG_SZ | `Medium` | `High` | Priorità operazioni di I/O elevata. |

**Nota**: Windows imposta di default `GPU Priority` e `Priority` ai valori ottimali (8 e 6), ma lascia `Scheduling Category` e `SFIO Priority` su valori conservativi (`Low` e `Medium`). Questa configurazione porta tutti i parametri ai valori massimi per prestazioni gaming, garantendo coerenza e priorità elevata su tutti i livelli di pianificazione delle risorse.

Queste sono le uniche modifiche necessarie per correggere l'inconsistenza con i valori default effettivi di Windows.

Se uno dei valori non esiste, crearlo manualmente:
- Per `REG_DWORD`: tasto destro sulla chiave `Games` > Nuovo > Valore DWORD (32 bit) > nominare il valore > impostare valore in decimale.
- Per `REG_SZ`: tasto destro sulla chiave `Games` > Nuovo > Valore stringa > nominare il valore > inserire la stringa esatta.

---

## Configurazione tramite file .reg

### Script Ottimizzato

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
"GPU Priority"=dword:00000008
"Priority"=dword:00000006
"Scheduling Category"="High"
"SFIO Priority"="High"
```

### Script Default

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
"GPU Priority"=dword:00000008
"Priority"=dword:00000006
"Scheduling Category"="Low"
"SFIO Priority"="Medium"
```

---

## Approfondimento Tecnico

### GPU Priority

Questo valore (range 1-8) determina la priorità con cui il driver grafico e il Windows Display Driver Model (WDDM) gestiscono i command buffer della GPU provenienti dal processo di gioco rispetto ad altre applicazioni. Un valore di `8` garantisce che i comandi grafici del gioco vengano processati con priorità massima, riducendo la latenza di rendering e prevenendo interruzioni causate da altri processi che richiedono accesso alla GPU (es. composizione desktop, decodifica video in background).

**Effetto pratico**: Riduzione del frame time variability e miglioramento della consistenza degli FPS, specialmente in scenari con carico GPU elevato o presenza di applicazioni concorrenti (browser, streaming software, overlay).

### Priority

Gestisce la priorità del thread principale del processo di gioco a livello di CPU scheduler. Il valore `6` corrisponde a "High Priority" nel Task Manager e garantisce che il gioco riceva più quantum di tempo CPU rispetto ai processi con priorità normale o bassa. Questo parametro influisce sul thread principale del gioco e sui thread di rendering, non sui thread di sistema o driver.

**Effetto pratico**: Riduzione della latenza di input (mouse, tastiera) e miglioramento della reattività generale del gioco, specialmente su sistemi con CPU con core count limitato o durante sessioni con applicazioni in background attive.

### Scheduling Category

Definisce la categoria di pianificazione utilizzata dal Multimedia Class Scheduler Service (MMCSS) per il processo. Il valore `High` assegna al gioco una classe di pianificazione prioritaria che riceve garantisce di esecuzione minime e preemption ridotta da parte di altri processi.

**Comportamento tecnico**: MMCSS coordina la pianificazione dei thread multimediali (audio, video, gaming) per prevenire glitch, stuttering e underrun. La categoria `High` riserva una porzione maggiore di tempo CPU al gioco rispetto a categorie `Medium` o `Low`.

### SFIO Priority

SFIO (Scheduled File I/O) gestisce la priorità delle operazioni di lettura/scrittura su disco per i processi multimediali. Il valore `High` garantisce che le richieste di I/O del gioco (caricamento asset, texture streaming, salvataggi) vengano processate con priorità elevata rispetto ad operazioni di I/O in background (indicizzazione, Windows Update, telemetria).

**Effetto pratico**: Riduzione degli spike di latenza durante il caricamento di livelli, streaming di texture o salvataggi automatici. Particolarmente rilevante su sistemi con dischi meccanici o SSD SATA con throughput limitato.

**Riferimenti**:
- [Microsoft Docs - Multimedia Class Scheduler Service](https://docs.microsoft.com/en-us/windows/win32/procthread/multimedia-class-scheduler-service)
- [Microsoft Docs - Task Scheduler for Game Developers](https://docs.microsoft.com/en-us/windows/win32/dxtecharts/scheduling-and-thread-priority)

---

## Impatto sulla Sicurezza

**Nessun impatto diretto sulla sicurezza del sistema**.

Le modifiche influenzano esclusivamente la pianificazione delle risorse per i processi classificati come "giochi" dal sistema operativo. Non vengono modificati permessi, policy di accesso o meccanismi di protezione.

**Nota**: Processi malevoli che si "mascherano" come giochi (registrandosi nella categoria Games del MMCSS) potrebbero beneficiare di priorità elevata. Tuttavia, questo scenario richiede già privilegi amministrativi per modificare il registro, rendendo la minaccia trascurabile rispetto ad altri vettori di attacco disponibili a tale livello di privilegio.

---

## Scenari Sconsigliati

- **Workstation con carichi di lavoro misti critico-temporali**: Se il sistema esegue simultaneamente rendering video, encoding, compilazioni di codice o altre operazioni time-sensitive insieme ai giochi, la prioritizzazione estrema del gaming può causare starvation delle altre applicazioni.
- **Streaming su single-PC setup**: Sistemi che eseguono contemporaneamente gioco e software di streaming/encoding (OBS, XSplit) su hardware limitato potrebbero subire drop di frame nello streaming a causa della priorità eccessiva assegnata al gioco.
- **Sistemi con CPU a basso core count (<4 core)**: La priorità elevata del gioco può causare stuttering del sistema operativo e delle applicazioni in background su CPU con core limitati.
- **Ambienti di benchmarking scientifico**: Se si stanno effettuando test comparativi, mantenere configurazioni stock per garantire riproducibilità e comparabilità dei risultati.

---

## Troubleshooting

**Sintomo**: Applicazioni in background (browser, Discord, Spotify) diventano non responsive durante le sessioni di gioco.  
**Causa**: La priorità elevata del gioco sta sottraendo eccessivi quantum di CPU alle altre applicazioni.  
**Soluzione**: Verificare che il sistema abbia almeno 6 core/12 thread. Su CPU con core count limitato, valutare la riduzione di `Priority` da `6` a `4` per un compromesso. In alternativa, chiudere manualmente le applicazioni non essenziali prima di avviare il gioco.

**Sintomo**: Streaming in diretta con drop di frame o encoding lag durante il gaming.  
**Causa**: Il processo del gioco sta monopolizzando le risorse a scapito del software di streaming.  
**Soluzione**: Su setup single-PC, impostare manualmente la priorità del processo di encoding (es. OBS) a "Above Normal" o "High" tramite Task Manager. Valutare la riduzione di `GPU Priority` da `8` a `7` se il software di streaming utilizza encoding GPU (NVENC, QuickSync, VCE).

**Sintomo**: Nessun miglioramento percepibile delle prestazioni dopo l'applicazione.  
**Causa**: Se il sistema non ha applicazioni concorrenti significative durante il gaming o il gioco non è CPU/GPU bound, l'impatto della modifica di `Scheduling Category` e `SFIO Priority` può essere impercettibile. I benefici sono più evidenti in scenari con carico multiplo o durante texture streaming intensivo.  
**Soluzione**: Questa configurazione agisce principalmente come "consolidamento" dei valori ottimali. Per miglioramenti prestazionali significativi, valutare altre ottimizzazioni (DisablePagingExecutive, timer resolution, network throttling).

**Sintomo**: Alcuni giochi non rispondono correttamente o crashano dopo l'applicazione.  
**Causa**: Raramente, alcuni motori grafici legacy o anti-cheat possono avere incompatibilità con priorità elevate o con modifiche al profilo MMCSS.  
**Soluzione**: Ripristinare i valori tramite script default e riavviare. Verificare se il problema persiste. Se risolto, mantenere la configurazione default per quel gioco specifico. Segnalare l'incompatibilità agli sviluppatori del gioco.

**Sintomo**: Windows Update o altre operazioni di sistema diventano estremamente lente durante il gaming.  
**Causa**: `SFIO Priority` elevato sta de-prioritizzando le operazioni di I/O di sistema in background.  
**Soluzione**: Evitare di giocare durante l'installazione di aggiornamenti di sistema. In alternativa, impostare temporaneamente `SFIO Priority` a `Normal` durante l'installazione di grandi aggiornamenti.

---

## Avvertenze e Note

**Creare sempre un Punto di Ripristino del sistema** prima di applicare qualsiasi modifica al registro.

**Riavvio del processo**: Le modifiche ai parametri della categoria `Games` vengono applicate dinamicamente ai nuovi processi che si registrano in questa categoria. Non è necessario riavviare il sistema, ma è consigliabile chiudere e rilanciare i giochi per garantire che acquisiscano i nuovi valori.

**Identificazione automatica dei giochi**: Windows identifica automaticamente i processi di gioco attraverso vari meccanismi (API DirectX/Vulkan, Game Mode, registrazione degli sviluppatori). Non tutti i giochi vengono correttamente identificati, specialmente titoli indie o launcher custom. Per forzare l'identificazione, utilizzare la funzionalità Game Mode di Windows (Win + G > Impostazioni > Questo è un gioco).

**Compatibilità con Game Mode**: Queste impostazioni operano in sinergia con la funzionalità Game Mode di Windows 11. Per massimizzare i benefici, assicurarsi che Game Mode sia abilitato in Impostazioni > Gaming > Game Mode.

**Monitoraggio delle prestazioni**: Per verificare l'impatto delle modifiche, utilizzare strumenti come MSI Afterburner con RivaTuner Statistics Server per monitorare frametime consistency, o CapFrameX per analisi dettagliate dei percentili FPS (1% low, 0.1% low). Gli indicatori chiave di successo sono la riduzione della deviazione standard del frametime e l'aumento dei percentili bassi di FPS.

**Interazione con altri tweak**: Questa ottimizzazione è complementare a modifiche come `DisablePagingExecutive`, ottimizzazioni del timer resolution e disabilitazione del network throttling. Non presenta conflitti noti con altre ottimizzazioni comuni del registro.