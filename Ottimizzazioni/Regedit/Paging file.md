# Ottimizzazione Gestione Memoria - Configurazione Avanzata Paging e Cache

Ottimizzazione dei parametri di gestione della memoria virtuale, cache di sistema e residenza del kernel per migliorare le prestazioni generali, ridurre la latenza e ottimizzare l'allocazione della RAM in base al carico di lavoro.

**Classificazione Rischio**: `[MEDIO]`

**Impatto su**:
- Gaming: Positivo (con RAM ≥16GB)
- Produttività: Positivo
- Sicurezza: Negativo (se abilitato ClearPageFileAtShutdown=0)
- Privacy: Negativo (se abilitato ClearPageFileAtShutdown=0)
- Stabilità: Neutro (richiede RAM adeguata)

---

## Percorso del Registro

```
Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management
```

---

## Tabella Parametri e Valori

| Nome Valore | Tipo | Default | Ottimizzato | Note |
|:---|:---|:---|:---|:---|
| LargeSystemCache | REG_DWORD | `0` | `0` | Mantiene priorità alle applicazioni. Base Decimale. |
| ClearPageFileAtShutdown | REG_DWORD | `0` | `0` | Privilegia velocità di spegnimento rispetto a sicurezza. Base Decimale. |
| DisablePagingExecutive | REG_DWORD | `0` | `1` | Forza kernel e driver in RAM. Richiede almeno 8GB RAM. Base Decimale. |

**Nota**: Se il valore `DisablePagingExecutive` non esiste, crearlo manualmente: tasto destro sulla chiave `Memory Management` > Nuovo > Valore DWORD (32 bit) > nominarlo `DisablePagingExecutive` > impostare valore `1` (Decimale).

### Percorso Prefetching

```
Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters
```

| Nome Valore | Tipo | Default | Configurazione A (Consigliata) | Configurazione B (Alternativa) | Note |
|:---|:---|:---|:---|:---|:---|
| EnablePrefetcher | REG_DWORD | `3` | `0` | `3` | Base Decimale. |
| EnableSuperfetch | REG_DWORD | `3` | `0` | `3` | Corrisponde al servizio SysMain. Base Decimale. |

**Valori possibili**: `0` = Disabilitato, `1` = Solo Applicazioni, `2` = Solo Avvio, `3` = Avvio e Applicazioni.

---

## Configurazioni Prefetcher/SysMain: Due Filosofie

### Configurazione A - SysMain Disabilitato (Consigliata)

**Motivazione**: Su hardware moderno dotato di SSD, i benefici del precaricamento predittivo sono marginali rispetto ai costi in termini di attività di I/O, consumo CPU in background e usura del disco. La disabilitazione garantisce prevedibilità assoluta del sistema, elimina picchi di attività non richiesti e prolunga la longevità dell'SSD riducendo le scritture non essenziali.

**Vantaggi**:
- Nessun overhead di CPU o disco per attività predittive in background
- Prevedibilità totale: quando il sistema è idle, rimane completamente inattivo
- Riduzione delle scritture sul disco (importante per longevità SSD)
- Nessuna interferenza con carichi di lavoro real-time (gaming, streaming, produzione audio/video)
- Minore consumo energetico su laptop

**Svantaggi**:
- Tempi di avvio del sistema leggermente più lunghi (differenza minima su SSD NVMe)
- First-launch delle applicazioni senza precaricamento (differenza impercettibile su SSD moderni)

---

### Configurazione B - SysMain Abilitato (Alternativa)

**Motivazione**: Per utenti con workflow consolidato e applicazioni ricorrenti, SysMain può offrire un vantaggio percepibile nel tempo di caricamento e nella reattività del sistema. Una volta completata la fase di apprendimento, il servizio riduce le letture ripetitive dal disco mantenendo i dati frequenti in RAM.

**Vantaggi**:
- Avvio del sistema più rapido dopo la fase di apprendimento
- Precaricamento intelligente delle applicazioni più utilizzate
- Riduzione delle letture dal disco a regime (dati già in RAM)
- CPU più libera dopo il completamento del precaricamento

**Svantaggi**:
- Attività di I/O e CPU in background durante l'apprendimento e l'analisi
- Scritture aggiuntive nella cartella `C:\Windows\Prefetch`
- Comportamento meno prevedibile (picchi di attività non controllabili direttamente)
- Maggiore utilizzo di RAM per il caching predittivo

---

**Scelta consigliata per questa repository**: **Configurazione A (SysMain Disabilitato)** per massimizzare controllo, prevedibilità e longevità del disco, considerando che su SSD moderni il delta prestazionale è trascurabile.

---

## Configurazione tramite file .reg

### Script Ottimizzato - Configurazione A (Consigliata)

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
"LargeSystemCache"=dword:00000000
"ClearPageFileAtShutdown"=dword:00000000
"DisablePagingExecutive"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters]
"EnablePrefetcher"=dword:00000000
"EnableSuperfetch"=dword:00000000
```

### Script Ottimizzato - Configurazione B (Alternativa)

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
"LargeSystemCache"=dword:00000000
"ClearPageFileAtShutdown"=dword:00000000
"DisablePagingExecutive"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters]
"EnablePrefetcher"=dword:00000003
"EnableSuperfetch"=dword:00000003
```

### Script Default

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
"LargeSystemCache"=dword:00000000
"ClearPageFileAtShutdown"=dword:00000000
"DisablePagingExecutive"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters]
"EnablePrefetcher"=dword:00000003
"EnableSuperfetch"=dword:00000003
```

---

## Approfondimento Tecnico

### DisablePagingExecutive

Il kernel di Windows (ntoskrnl.exe) e i driver di sistema possono essere sottoposti a paging quando la pressione sulla memoria fisica aumenta. Impostando questo valore a `1`, si forza il Memory Manager a mantenere l'Executive e i driver sempre residenti in RAM fisica, eliminando la latenza derivante dal page fault quando questi componenti devono essere richiamati dal disco.

**Effetto pratico**: Riduzione dei tempi di risposta delle chiamate di sistema (syscall) e delle operazioni I/O gestite dai driver. Particolarmente efficace su sistemi con almeno 8-16GB di RAM, dove la pressione di memoria è rara e il beneficio in termini di latenza è misurabile.

### LargeSystemCache

Controlla la politica di allocazione della RAM tra la cache del file system (utilizzata per operazioni di I/O e rete) e la memoria disponibile per i processi utente. Il valore `0` limita la cache di sistema a circa 8-10 MB, massimizzando la RAM per applicazioni e giochi. Il valore `1` consente alla cache di espandersi dinamicamente, ottimale per server o workstation con carichi I/O intensivi.

### ClearPageFileAtShutdown

Il file di paging (pagefile.sys) contiene dati volatili della RAM scaricati su disco. Quando il sistema si spegne senza pulire questo file, informazioni sensibili (password, chiavi crittografiche, sessioni utente) possono rimanere sul disco fisico. L'attivazione (`1`) sovrascrive il file ad ogni spegnimento, eliminando il rischio di recupero forense ma aumentando significativamente il tempo di shutdown su sistemi con file di paging di grandi dimensioni.

### Prefetcher e SysMain (Superfetch)

Il Prefetcher analizza i pattern di avvio del sistema e delle applicazioni, creando file di tracciamento nella cartella `C:\Windows\Prefetch`. SysMain (successore di Superfetch) utilizza questi dati per precaricare in RAM i file e le librerie più frequentemente utilizzati.

**Comportamento con valore 3 (Abilitato)**: Il sistema monitora l'utilizzo, precarica dati predittivamente e riduce le letture successive dal disco. Una volta completata la fase di apprendimento, la CPU risulta meno impegnata e il disco subisce meno operazioni ripetitive per i dati già cachati. Su SSD NVMe, il beneficio è misurabile principalmente nei tempi di avvio e nel first-launch delle applicazioni ricorrenti.

**Comportamento con valore 0 (Disabilitato)**: Eliminazione totale dell'overhead predittivo. Nessuna attività di analisi, apprendimento o precaricamento in background. Il sistema risponde esclusivamente alle richieste esplicite dell'utente, garantendo massima prevedibilità e controllo. Su hardware moderno, la differenza nei tempi di caricamento è nell'ordine dei millisecondi e spesso impercettibile.

**Impatto su longevità SSD**: La disabilitazione di SysMain riduce le scritture non essenziali nella cartella Prefetch e le operazioni di I/O legate al precaricamento, contribuendo a preservare i cicli di scrittura degli SSD. Anche se gli SSD moderni hanno tolleranze elevate (TBW), ogni riduzione di scritture non necessarie prolunga la vita utile del dispositivo.

**Riferimenti**:
- [Microsoft Docs - Memory Management](https://docs.microsoft.com/en-us/windows/win32/memory/memory-management)
- [Windows Internals, Part 1 (Russinovich, Solomon, Ionescu) - Capitolo 5: Memory Management]

---

## Impatto sulla Sicurezza

**ClearPageFileAtShutdown = 0 (Ottimizzato)**:
- **Rischio Privacy**: Dati sensibili della sessione utente rimangono nel file di paging dopo lo spegnimento. Un attacco con accesso fisico al disco o un'analisi forense può recuperare password, chiavi di sessione o altri dati volatili.
- **Scenario di rischio**: Sistemi portatili, workstation condivise, ambienti non fidati.

**DisablePagingExecutive = 1**:
- **Nessun impatto diretto sulla sicurezza**, ma aumenta la superficie di memoria sempre residente e potenzialmente analizzabile da rootkit o malware con privilegi elevati.

**Prefetcher/SysMain Disabilitato (Configurazione A)**:
- **Nessun impatto sulla sicurezza diretta**, ma riduce i metadati generati dal sistema relativi ai pattern di utilizzo delle applicazioni. In scenari di analisi forense, la cartella `Prefetch` fornisce informazioni dettagliate su quali applicazioni sono state eseguite e quando.

**Raccomandazione**: Su sistemi con requisiti di sicurezza elevati (es. GDPR, PCI-DSS), valutare l'attivazione di `ClearPageFileAtShutdown=1` nonostante l'aumento del tempo di spegnimento.

---

## Scenari Sconsigliati

- **Sistemi con RAM insufficiente (<8GB)**: `DisablePagingExecutive=1` può portare a out-of-memory e crash del sistema.
- **Workstation aziendali con policy di sicurezza**: `ClearPageFileAtShutdown=0` viola molti standard di compliance.
- **Laptop con uso mobile frequente**: Il rischio di furto o smarrimento rende critico l'uso di `ClearPageFileAtShutdown=1`.
- **Server o sistemi mission-critical**: Preferire configurazioni conservative e testare ogni modifica in ambienti non produttivi.
- **Sistemi con carichi I/O intensivi o ruolo server**: Valutare `LargeSystemCache=1` invece del valore ottimizzato.
- **Utenti con workflow rigido e applicazioni ricorrenti su HDD meccanici**: Configurazione B (SysMain abilitato) può offrire benefici percepibili su dischi tradizionali.

---

## Troubleshooting

**Sintomo**: Sistema lento o applicazioni che crashano con errori di memoria insufficiente dopo l'applicazione.  
**Causa**: `DisablePagingExecutive=1` su sistema con RAM limitata forza troppa memoria residente, esaurendo le risorse disponibili.  
**Soluzione**: Ripristinare il valore default (`DisablePagingExecutive=0`) tramite script di ripristino e riavviare. Aggiornare a minimo 16GB di RAM prima di riapplicare.

**Sintomo**: Tempo di spegnimento aumentato drasticamente (oltre 2-3 minuti).  
**Causa**: Se per errore è stato attivato `ClearPageFileAtShutdown=1`, il sistema sovrascrive l'intero file di paging ad ogni shutdown.  
**Soluzione**: Verificare il valore tramite Regedit. Se impostato a `1`, riportarlo a `0` e riavviare.

**Sintomo**: Prestazioni gaming degradate o micro-stuttering dopo l'applicazione della Configurazione B.  
**Causa**: SysMain può causare interferenze con carichi real-time generando picchi di I/O o CPU in momenti critici.  
**Soluzione**: Applicare la Configurazione A (SysMain disabilitato). In alternativa, disabilitare temporaneamente il servizio SysMain tramite Services.msc (cercare "SysMain" e impostare su "Disabilitato") per verificare l'impatto.

**Sintomo**: Avvio del sistema più lento dopo aver applicato la Configurazione A.  
**Causa**: Il sistema non precarica più i file critici di avvio. Su hardware moderno la differenza è nell'ordine di 1-3 secondi.  
**Soluzione**: Se il rallentamento è significativo e percepibile, valutare la Configurazione B. In alternativa, impostare solo `EnablePrefetcher=2` (solo avvio) mantenendo `EnableSuperfetch=0`.

**Sintomo**: Picchi di attività disco imprevedibili con Configurazione B.  
**Causa**: SysMain analizza pattern e precarica dati in background.  
**Soluzione**: Applicare la Configurazione A per eliminare completamente l'attività predittiva.

---

## Avvertenze e Note

**Creare sempre un Punto di Ripristino del sistema** prima di applicare qualsiasi modifica al registro. 

**Riavvio obbligatorio**: Tutte le modifiche ai parametri di Memory Management richiedono il riavvio completo del sistema per essere applicate.

**Monitoraggio post-applicazione**: Verificare l'utilizzo della RAM tramite Task Manager (Ctrl+Shift+Esc > Prestazioni > Memoria) nelle prime ore di utilizzo. Se il sistema utilizza costantemente oltre il 90% della RAM disponibile, valutare il ripristino dei valori default.

**Pulizia manuale cartella Prefetch**: La disabilitazione di Prefetcher/SysMain (Configurazione A) interrompe la creazione di nuovi file nella cartella `C:\Windows\Prefetch`, ma non elimina quelli esistenti. Per una pulizia completa, eliminare manualmente il contenuto della cartella dopo aver applicato la Configurazione A e riavviato il sistema. Operazione consigliata per liberare spazio e rimuovere metadati di utilizzo obsoleti.

**Disabilitazione servizio SysMain**: Dopo l'applicazione della Configurazione A, è possibile disabilitare completamente il servizio SysMain tramite Services.msc per garantire che non venga riavviato da aggiornamenti di sistema. Cercare "SysMain" nell'elenco servizi, tasto destro > Proprietà > Tipo di avvio: Disabilitato.