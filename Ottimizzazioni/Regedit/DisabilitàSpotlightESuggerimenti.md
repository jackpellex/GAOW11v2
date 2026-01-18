# Disabilitazione Windows Spotlight e Suggerimenti - Rimozione Contenuti Dinamici Lock Screen

Disattivazione degli sfondi dinamici Windows Spotlight, pubblicità e contenuti suggeriti dalla schermata di blocco per migliorare la pulizia visiva del sistema, ridurre il traffico di rete in background e aumentare la privacy eliminando la telemetria associata.

**Classificazione Rischio**: `[BASSO]`

**Impatto su**:
- Gaming: Neutro
- Produttività: Positivo (riduzione distrazioni, minor traffico rete)
- Sicurezza: Neutro
- Privacy: Positivo (eliminazione telemetria Spotlight, nessun download contenuti esterni)
- Stabilità: Neutro

---

## Percorso del Registro

```
Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager
```

---

## Tabella Parametri e Valori

| Nome Valore | Tipo | Default | Ottimizzato | Note |
|:---|:---|:---|:---|:---|
| RotatingLockScreenEnabled | REG_DWORD | `1` | `0` | Disabilita rotazione automatica sfondi Spotlight. Base Decimale. |
| RotatingLockScreenOverlayEnabled | REG_DWORD | `1` | `0` | Rimuove overlay (curiosità, icone, pubblicità) dalla Lock Screen. Base Decimale. |

**Nota**: Questi valori potrebbero non esistere di default nel registro. Se assenti, crearli manualmente: tasto destro sulla chiave `ContentDeliveryManager` > Nuovo > Valore DWORD (32 bit) > nominare esattamente come indicato > impostare valore `0` in decimale.

**Effetto combinato**: La disabilitazione di entrambi i valori elimina completamente l'esperienza Windows Spotlight, impedendo il download automatico di immagini dai server Microsoft, la visualizzazione di contenuti promozionali e la raccolta di telemetria sull'interazione con la schermata di blocco.

---

## Configurazione tramite file .reg

### Script Ottimizzato

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"RotatingLockScreenEnabled"=dword:00000000
"RotatingLockScreenOverlayEnabled"=dword:00000000
```

### Script Default

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"RotatingLockScreenEnabled"=dword:00000001
"RotatingLockScreenOverlayEnabled"=dword:00000001
```

---

## Approfondimento Tecnico

### Windows Spotlight - Architettura e Funzionamento

Windows Spotlight è un sistema di distribuzione di contenuti dinamici introdotto in Windows 10 e mantenuto in Windows 11. Opera attraverso diversi componenti di sistema che lavorano coordinati:

**Componenti principali**:
1. **ContentDeliveryManager**: Servizio di sistema che gestisce il download, la cache e la rotazione degli sfondi Spotlight
2. **CloudExperienceHost**: Processo che gestisce l'interfaccia utente della Lock Screen e l'overlay informativo
3. **Background Task**: Task schedulato che scarica periodicamente nuove immagini dai server Microsoft CDN

**Flusso operativo**:
1. Il servizio ContentDeliveryManager contatta periodicamente i server Microsoft (ogni 24-48 ore) per verificare la disponibilità di nuovi contenuti
2. Le immagini vengono scaricate in background (tipicamente 1-3MB per immagine ad alta risoluzione) e salvate in `%LOCALAPPDATA%\Packages\Microsoft.Windows.ContentDeliveryManager_*\LocalState\Assets`
3. Il sistema ruota automaticamente lo sfondo della Lock Screen selezionando dalle immagini scaricate
4. L'overlay visualizza metadati (titolo, località, curiosità) recuperati insieme all'immagine
5. Il sistema traccia l'interazione utente (like/dislike, tempo di visualizzazione) e invia telemetria ai server Microsoft

### RotatingLockScreenEnabled

Questo valore controlla il meccanismo di rotazione automatica degli sfondi. Quando impostato a `0`, il sistema:
- Interrompe il download automatico di nuove immagini Spotlight
- Blocca la rotazione ciclica degli sfondi esistenti
- Mantiene l'ultimo sfondo impostato manualmente dall'utente o ritorna allo sfondo predefinito di Windows
- Disabilita il task schedulato associato al refresh delle immagini

**Effetto tecnico**: Riduzione del traffico di rete in background (1-5MB al giorno), eliminazione delle scritture su disco associate al caching delle immagini (100-500MB occupati dalla cache completa), riduzione dei wakeup del sistema da idle per il task di aggiornamento.

### RotatingLockScreenOverlayEnabled

Questo valore controlla l'overlay informativo visualizzato sopra l'immagine Spotlight. L'overlay include:
- Icone interattive ("Mi piace"/"Non mi piace")
- Testo descrittivo dell'immagine (titolo, località geografica)
- Curiosità o informazioni contestuali
- Link pubblicitari o promozionali (occasionali)

Quando impostato a `0`:
- Il processo CloudExperienceHost non renderizza più l'overlay sulla Lock Screen
- La telemetria associata all'interazione con l'overlay viene interrotta
- Le richieste di rete per recuperare metadati aggiornati vengono bloccate

**Effetto tecnico**: Riduzione dell'overhead di rendering sulla Lock Screen (minor utilizzo GPU), eliminazione delle richieste di rete per metadati (connessioni HTTPS periodiche a *.microsoft.com), blocco della telemetria di interazione utente.

### Telemetria e Privacy

Windows Spotlight raccoglie e invia ai server Microsoft:
- Quali immagini sono state visualizzate e per quanto tempo
- Feedback esplicito (like/dislike) su ogni immagine
- Risoluzione dello schermo e configurazione display
- Frequenza di accesso alla Lock Screen
- Interazioni con link promozionali o contenuti suggeriti

Questi dati vengono utilizzati per:
- Personalizzazione dei contenuti mostrati all'utente
- Metriche di engagement per content provider
- Profilazione comportamentale (in aggregato) per advertising

La disabilitazione elimina completamente questa raccolta dati, migliorando la privacy.

**Riferimenti**:
- [Microsoft Docs - Personalize your Lock Screen](https://support.microsoft.com/en-us/windows/personalize-your-lock-screen-81dab9fc-8c5b-2f2f-73c4-e5e6d72bd670)
- [Microsoft Privacy Dashboard - Diagnostic Data](https://privacy.microsoft.com/en-us/windows-10-and-privacy)

---

## Impatto sulla Sicurezza

**Impatto positivo sulla privacy**:
- Eliminazione della telemetria associata a Windows Spotlight
- Blocco del download automatico di contenuti da server esterni
- Riduzione della superficie di attacco (meno connessioni di rete in background, meno processi attivi)
- Nessuna esposizione a contenuti potenzialmente malevoli tramite Spotlight (estremamente raro, ma teoricamente possibile)

**Nessun impatto negativo sulla sicurezza del sistema**:
- Windows Spotlight non è un componente di sicurezza
- La disabilitazione non altera meccanismi di autenticazione, crittografia o protezione della Lock Screen

**Considerazione minore**: La Lock Screen senza Spotlight diventa un'interfaccia statica e prevedibile, potenzialmente più resistente a tecniche di social engineering basate su contenuti dinamici ingannevoli (phishing visivo).

---

## Scenari Sconsigliati

- **Utenti che apprezzano i contenuti visivi dinamici**: Se si gradisce la varietà degli sfondi automatici e le curiosità associate, mantenere Spotlight attivo.
- **Ambienti educativi o espositivi**: In contesti dove la Lock Screen viene visualizzata frequentemente (chioschi, display pubblici), i contenuti dinamici possono essere desiderabili per engagement.
- **Testing di funzionalità Windows**: Sviluppatori o tester che devono verificare il comportamento di Spotlight o funzionalità correlate.

---

## Troubleshooting

**Sintomo**: La schermata di blocco continua a mostrare sfondi dinamici dopo l'applicazione dello script.  
**Causa**: Le immagini Spotlight sono già state scaricate e cached. Il sistema potrebbe continuare a ciclare tra quelle esistenti.  
**Soluzione**: Eliminare manualmente la cache di Spotlight. Navigare in `%LOCALAPPDATA%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets` ed eliminare tutti i file. Riavviare il sistema. In alternativa, impostare uno sfondo personalizzato tramite Impostazioni > Personalizzazione > Schermata di blocco > Immagine.

**Sintomo**: L'overlay (icone, testo) continua a comparire anche dopo la disabilitazione.  
**Causa**: Il processo CloudExperienceHost non è stato riavviato correttamente o il valore di registro non è stato applicato.  
**Soluzione**: Verificare tramite Regedit che `RotatingLockScreenOverlayEnabled` sia effettivamente impostato a `0`. Riavviare il sistema. Se il problema persiste, terminare manualmente il processo CloudExperienceHost.exe tramite Task Manager e attendere il suo riavvio automatico.

**Sintomo**: Impossibile impostare uno sfondo personalizzato per la Lock Screen dopo la disabilitazione.  
**Causa**: Raramente, la disabilitazione di Spotlight può bloccare anche l'impostazione manuale di sfondi personalizzati a causa di policy correlate.  
**Soluzione**: Navigare in Impostazioni > Personalizzazione > Schermata di blocco. Selezionare "Immagine" come opzione e scegliere un'immagine personalizzata. Se l'opzione è disattivata (grigia), verificare la presenza di Group Policy restrittive: eseguire `gpedit.msc` (su Windows Pro/Enterprise) > Configurazione computer > Modelli amministrativi > Pannello di controllo > Personalizzazione > verificare che "Impedisci modifica dello sfondo della schermata di blocco" sia su "Non configurata".

**Sintomo**: La cartella Assets continua ad essere popolata con nuove immagini.  
**Causa**: Altri servizi di sistema (non Spotlight) potrebbero utilizzare la stessa cartella per cache di immagini.  
**Soluzione**: Verificare la dimensione della cartella nel tempo. Se continua a crescere significativamente (>100MB), identificare il processo responsabile tramite Process Monitor (Sysinternals). Considerare la disabilitazione di altri servizi correlati come "Esperienze per consumatori" tramite ulteriori chiavi di registro in ContentDeliveryManager.

**Sintomo**: Maggiore consumo di traffico di rete anche dopo la disabilitazione.  
**Causa**: Windows Spotlight è solo uno dei componenti che generano traffico di rete in background. Altri servizi (Windows Update, telemetria, Store) continuano a operare.  
**Soluzione**: Questa ottimizzazione riduce solo il traffico specifico di Spotlight (1-5MB/giorno). Per riduzione più aggressiva del traffico, valutare la disabilitazione di ulteriori servizi di telemetria e contenuti suggeriti tramite chiavi aggiuntive in `ContentDeliveryManager` (es. `SubscribedContent-*`, `SilentInstalledAppsEnabled`).

---

## Avvertenze e Note

**Creare sempre un Punto di Ripristino del sistema** prima di applicare qualsiasi modifica al registro.

**Riavvio consigliato**: Le modifiche vengono applicate immediatamente al prossimo lock del sistema, ma un riavvio completo garantisce la terminazione di tutti i processi correlati e l'applicazione pulita delle nuove impostazioni.

**Pulizia manuale della cache**: Dopo la disabilitazione, la cartella Assets di Spotlight può contenere centinaia di MB di immagini cached. Per liberare spazio:
1. Navigare in `%LOCALAPPDATA%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets`
2. Eliminare tutti i file (non hanno estensione visibile, sono immagini JPEG)
3. La cartella verrà ricreata vuota dal sistema, ma non verrà più popolata

**Impostazione sfondo personalizzato**: Dopo la disabilitazione di Spotlight, configurare uno sfondo personalizzato tramite:
- Impostazioni > Personalizzazione > Schermata di blocco > Immagine
- Selezionare un'immagine locale o utilizzare sfondo predefinito di Windows
- Per sfondo solido (minimo overhead): selezionare "Colore a tinta unita" invece di "Immagine"

**Disabilitazione estesa dei contenuti suggeriti**: Oltre a Spotlight, Windows include altri meccanismi di contenuti dinamici. Per una disabilitazione più completa, considerare l'impostazione di ulteriori valori in `ContentDeliveryManager`:
- `SubscribedContent-338388Enabled` = 0 (suggerimenti nel menu Start)
- `SubscribedContent-338389Enabled` = 0 (suggerimenti in Impostazioni)
- `SilentInstalledAppsEnabled` = 0 (installazione automatica app suggerite)
- `SystemPaneSuggestionsEnabled` = 0 (suggerimenti nel Centro notifiche)

**Compatibilità con temi Windows**: La disabilitazione di Spotlight non influisce sui temi Windows personalizzati. È possibile continuare a utilizzare temi scaricati dal Microsoft Store o creati manualmente.

**Interazione con altri tweak**: Questa ottimizzazione è complementare a modifiche di privacy e riduzione telemetria. Non presenta conflitti noti con ottimizzazioni di prestazioni, memoria o rete.

**Impatto su battery life (laptop)**: La disabilitazione di Spotlight riduce marginalmente il consumo energetico eliminando i wakeup periodici per download e refresh contenuti. L'impatto è minimo ma misurabile su laptop (5-10 minuti di autonomia aggiuntiva su batteria di lunga durata).

**Reversibilità completa**: Windows Spotlight può essere riattivato in qualsiasi momento tramite lo script default. Dopo il riavvio, il sistema riprenderà automaticamente il download e la rotazione degli sfondi dinamici.