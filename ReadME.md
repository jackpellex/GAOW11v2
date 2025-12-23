# Guida Avanzata alle Ottimizzazioni su Windows 11

> 🎮 **Ottimizza Windows 11 per il gaming e l’uso quotidiano** 🔧  
> Progettata per **utenti esperti e non**, questa guida ti mostra percorsi **sicuri e avanzati** per massimizzare le prestazioni software e hardware del tuo PC.

## CleanOS: Personalizza la Tua Installazione di Windows 11 per una Base Stabile

Prima di immergerti nelle ottimizzazioni, puoi gettare le fondamenta per un sistema pulito e performante. Questa guida include una sezione dedicata a **CleanOS**, che ti permette di creare un'installazione personalizzata di Windows 10/11 fin dall'inizio.

Questo significa che potrai avere un'immagine ISO su misura, **priva di bloatware** (software preinstallato non necessario) e già configurata con le tue preferenze di lingua, regione, account utente, impostazioni di rete e privacy.

Utilizzando l'**Unattend Generator** e seguendo il percorso indicato in `2_Personalizzazione/CleanOS.md`, ti assicurerai che il tuo sistema parta già da una **base stabile e ottimizzata**, priva di elementi superflui che potrebbero influire sulle prestazioni future.

---

### 📑 Indice

1. [Scopo della Guida](https://www.google.com/search?q=%23scopo-della-guida)
2. [Struttura delle Cartelle](https://www.google.com/search?q=%23struttura-delle-cartelle)
3. [Prestazioni Realistiche vs. Extreme Tuning](https://www.google.com/search?q=%23prestazioni-realistiche-vs-extreme-tuning)
4. [Sezioni Principali](https://www.google.com/search?q=%23sezioni-principali)

* [Ottimizzazioni](https://www.google.com/search?q=%23ottimizzazioni)
* [Utilità](https://www.google.com/search?q=%23utilit%C3%A0)
* [Personalizzazione](https://www.google.com/search?q=%23personalizzazione)
* [Script](https://www.google.com/search?q=%23script)
* [Risoluzione Errori](https://www.google.com/search?q=%23risoluzione-errori)
* [Sicurezza](https://www.google.com/search?q=%23sicurezza)

5. [Linee Guida di Stile](https://www.google.com/search?q=%23linee-guida-di-stile)

---

## Scopo della Guida

L'obiettivo della guida di ottimizzazione per Windows 11 di jackpellex è molto chiaro e si basa su tre pilastri fondamentali:

1.  **Migliorare l'esperienza utente:** Rendere l'uso quotidiano del sistema operativo più piacevole e fluido.
2.  **Alleggerire il sistema:** Eliminare o disattivare processi, servizi e funzionalità non necessari o poco utilizzati, noti anche come "bloatware" o componenti superflue, per liberare risorse di sistema (RAM, CPU, spazio su disco).
3.  **Ottimizzazione personalizzata:** Dare all'utente la possibilità di scegliere quali modifiche applicare, permettendo un approccio modulare e consapevole in base alle proprie esigenze e al proprio livello di esperienza.

L'obiettivo finale è quello di ottenere un **Sistema Operativo leggero, veloce e sicuro**, con un'importante sottolineatura sulla necessità di essere **coscienti della sicurezza** durante l'applicazione delle ottimizzazioni.

---

### Struttura delle Cartelle

* **App_e_Siti/**: applicazioni e risorse esterne per test hardware, monitoraggio e ottimizzazione.
* **Collegamenti/**: scorciatoie a impostazioni di sistema e tool avanzati.
* **Icone/**: set di icone personalizzate per abbellire e distinguere le cartelle.
* **1_Ottimizzazioni/**: tecniche di tuning per CPU, GPU, I/O e avvio di sistema.
* **2_Utilità/**: comandi e strumenti pronti all'uso per la gestione quotidiana e avanzata dei dati.
* **3_Personalizzazione/**: temi, layout, automazioni e script per adattare UI/UX.
* **4_Script/**: raccolta di automazioni (.bat, .ps1, .reg) per l'applicazione rapida delle modifiche.
* **5_Risoluzione_Errori/**: diagnostica, log, riparazione file e recupero configurazioni.
* **6_Sicurezza/**: hardening, crittografia, protezione memoria e best practice difensive.
* **README.md**: punto di partenza e indice di tutta la guida.

> Le cartelle **1–6** sono il cuore dell’ottimizzazione: esplorale con ordine e attenzione.

---

### Tuning: Realistico vs. Estremo

Quando si ottimizza un sistema, è fondamentale distinguere tra un approccio mirato alla stabilità e uno che spinge l'hardware al limite. La scelta dipende dall'equilibrio desiderato tra performance e affidabilità.

---

#### Tuning Sicuro

Questo approccio si concentra su modifiche conservative che garantiscono stabilità e fluidità. È ideale per la maggior parte degli utenti, specialmente sui **sistemi moderni**, dove i guadagni prestazionali sono minori (+8% FPS) ma non compromettono l'affidabilità. Su **sistemi meno recenti**, il guadagno in FPS può essere anche maggiore, rendendo i giochi più giocabili e reattivi senza introdurre problemi.

---

#### Tuning Estremo (Sconsigliato)

Questo approccio aggressivo mira a massimizzare gli FPS, con guadagni potenziali fino a +30-40%. Tuttavia, è **altamente sconsigliato** a causa dei rischi elevati: crash, artefatti grafici e instabilità del sistema. Questi problemi si manifestano sia su hardware moderno che su quello datato, ma sono ancora più frequenti sui PC meno recenti, dove l'hardware è meno tollerante allo stress. I benefici percepiti raramente giustificano i potenziali problemi di stabilità.

> ⚠️ Ogni modifica estrema è segnalata da un avviso e va testata su singola macchina.

---

## Sezioni Principali

### Ottimizzazioni 📈

* **Aggiornamento Applicazioni**:
  - Utilizza **winget** e **Chocolatey** per mantenere software aggiornati con un singolo comando: `winget upgrade --all` o `choco upgrade all -y`.
* **Eseguibile .bat**:
  - Script di pulizia per eliminare file temporanei: `cleanmgr /sagerun:1` o personalizza un `.bat` che rimuove `%temp%`, cache browser e log di sistema obsoleti.
* **BIOS Tweaks** (⚠️ sconsigliato in ambienti di produzione):
  - **Hyper-Threading Disabled** per ridurre latenza in alcuni giochi CPU-bound.
* **Terminale PowerShell**:
  - **Compressione della memoria**: `Enable-MMAgent -MemoryCompression`.
  - **Sleep States**: disabilita stati di basso consumo (S1–S3) in sistemi desktop per ridurre lag.
* **Configurazione di Sistema**:
  - Rilevamento e affinità core avanzata via `bcdedit /set {current} numproc N`.
* **Fast-Boot**: La funzionalità di Windows che accelera l'avvio ibernando il kernel
(Pro: Avvio Veloce, Reattività; Contro: Assenza di Full Shutdown e rischio di corruzione dati in ambienti Dual-Boot come Windows/Linux).
* **Ottimizzazione Connessione e Rete**:
  - Regola TCP Window Scaling e auto-tuning: `netsh interface tcp set global autotuninglevel=high`.
* **Gestione Attività**:
  - Disabilita startup non necessari dal Task Manager.
  - Imposta priorità app gaming su **Alta**.
  - Usa **Process Explorer** per analisi avanzata.
* **Gestione Disco**:
  - Deframmentazione SSD disabilitata, esegui TRIM: `Optimize-Volume -DriveLetter C -ReTrim -Verbose`.
  - Indicizzazione file: Mantiene un indice per ricerche rapide. Benefico per la velocità di ricerca su desktop moderni (SSD). Configura le "Opzioni di indicizzazione" per includere/escludere specifiche cartelle.
* **GPU Tweaks**:
  - Regola consumi e power limit via tool del vendor (NVIDIA/AMD).
  - Abilita riduzione latenza input nei driver.
  - Comprendi e scegli tra Fullscreen Esclusivo e Finestra Borderless per ottimizzare ulteriormente le performance e la latenza.
* **HPET** (⚠️ sconsigliato):
  - `bcdedit /set useplatformclock true/false`, testare per possibili miglioramenti di stabilità.
* **HDR**: Guida dettagliata alla configurazione ottimale del  Flusso Video HDR. Vengono presentati due profili
   - **Alta Qualità** (massime prestazioni visive, alto consumo energetico)
   - **Bassa Qualità/Risparmio Energetico** (durata batteria migliorata, qualità visiva standard) e suggerimenti di calibrazione.
* **Impostazioni di Sistema**:
  - Disabilita app in background.
  - Usa il **Sensore di memoria** in Sicurezza di Windows.
  - Disattiva raccolta Telemetria superflua e colori non essenziali.
* **Ottimizzazione RAMDisk** (OPZIONALE):
  - Consiste nel creare un disco virtuale nella RAM, eliminando virtualmente gli stuttering e migliorando drasticamente gli FPS.
  - Può portare a un aumento massiccio degli FPS, ma solo con configurazioni hardware specifiche (principalmente 64GB di RAM o superiore).
* **Opzioni Prestazioni**:
  - Configura Memoria Virtuale manualmente: dimensione iniziale e massima tra 1.5× RAM e 3.0x RAM. Assicurati di riservare abbastanza spazio libero sul disco (almeno 1,5x - 3x della RAM disponibile)
  - Ottimizza effetti visivi su **Prestazioni migliori**.
* **Programmi da Disinstallare**:
  - Rimuovi app preinstallate non necessarie dal Pannello di controllo.
* **Performance Monitor**:
  - Crea baseline di prestazioni e traccia counter critici.
* **Editor del Registro (Regedit)** (⚠️):
  - Abilita **Fast Startup**: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power` → `HiberbootEnabled = 1`.
  - Disabilita GameDVR: `HKEY_CURRENT_USER\System\GameConfigStore` → `GameDVR_Enabled = 0`.
  - Imposta `SvcHostSplitThresholdInKB` e `Win32PrioritySeparation` per bilanciare avvio servizi e priorità.
  - Ottimizza la priorità per i giochi: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games` → imposta `GPU Priority = 8`, `Priority = 6` e `Scheduling Category = High` per migliorare FPS e reattività.
  - Ottimizza `NetworkThrottlingIndex` e `SystemResponsiveness` per ridurre la latenza di rete e migliorare la reattività CPU in gaming, streaming e produzione multimediale.
  - **Ottimizzazioni Avanzate della Memoria e del Paging**: Contiene modifiche cruciali nella chiave `Memory Management` per controllare l'allocazione della cache di sistema, la pulizia del file di paging per la sicurezza, e la residenza del kernel in RAM per una latenza minima.
  - **Disabilita Windows Spotlight e Pubblicità**: `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager` → crea i valori DWORD (32-bit) `RotatingLockScreenEnabled = 0` e `RotatingLockScreenOverlayEnabled = 0` per rimuovere sfondi dinamici, suggerimenti e pubblicità dalla schermata di blocco.
  - **Stop Ricerca Online nel Menu Start**: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer` → se la chiave `Explorer` non esiste, crearla sotto `Windows` e impostare `DisableSearchBoxSuggestions = 1` per bloccare i risultati di Bing e migliorare privacy e velocità.
* **Resource Monitor**:
  - Monitora I/O, CPU, RAM e rete in tempo reale per individuare colli di bottiglia.
* **Servizi Windows**:
  - Disattiva servizi non essenziali (Fax, Print Spooler se non usati).
  - Mantieni attivo **Windows Update**, **Security Center** e **Driver Frameworks**.
* **Qualità e Volume Audio**:
  - Migliora la fedeltà del suono e il volume generale configurando le opzioni avanzate del dispositivo audio nel **Pannello di controllo**.
* **Gestione Avanzata dell'Energia**: Personalizza l'uso della CPU, del disco e del sistema I/O tramite i piani di alimentazione per bilanciare **autonomia** o **prestazioni Turbo**.

---

### Utilità 🛠️

In questa cartella sono raccolti strumenti e comandi utili per la gestione quotidiana del sistema e dei dati, che vanno oltre la semplice ottimizzazione.

* **Robocopy**: Un'utility da riga di comando integrata di default su Windows, per copiare file e directory in modo robusto. È lo strumento ideale per backup, sincronizzazione e migrazione dati, grazie alla sua capacità di gestire interruzioni e mantenere attributi dei file.
* **Diskpart** (⚠️ **strumento avanzato**): Un'utility da riga di comando per il controllo avanzato di dischi e partizioni. Essenziale per formattare, creare, eliminare e gestire volumi in modo granulare.
* *Nota:* Se usata impropriamente, può causare la **perdita di dati in maniera irreversibile**. È tuttavia indispensabile per risolvere problemi complessi a "basso livello", superando i limiti degli strumenti grafici.

---

### Personalizzazione 🎨

* **Installazione Personalizzata e Automatizzata (CleanOS)**:
  - Vuoi un'installazione di Windows 10/11 su misura, senza bloatware e con le tue configurazioni predefinite? Segui la guida **CleanOS.md** nella cartella **2_Personalizzazione/** per creare un supporto di installazione automatico e pulito usando l'Unattend Generator. Questo ti permette di definire lingua, regione, account utente, impostazioni di rete e privacy fin dal primo avvio del sistema.
* **Desktop Pulito**:
  - Mantieni il desktop il più sgombro possibile: sposta Documenti, Download e collegamenti in cartelle dedicate (`C:\Users\%USERNAME%\Documenti`, ecc.).  
  - Organizza i file con struttura gerarchica e usa **cartelle dei Preferiti** nel File Explorer.  
  - Riduci il caricamento di file all’avvio: rimuovi shortcut superflui dalla cartella `Startup` (`shell:startup`).
* **Mouse Migliorato**:
  - **DPI**: configura DPI e Polling Rate dal software del driver (Logitech G HUB, Razer Synapse, ecc.) per trovare il giusto compromesso tra precisione e velocità.
  - **Disabilitazione accelerazione**: apri **Pannello di controllo → Mouse → Opzioni puntatore** e deseleziona **Migliora precisione puntatore**.
  - **Modifiche al Registro** (⚠️)
* **Aggiustamenti dello Schermo**:
  - **Refresh Rate**: vai in **Impostazioni → Sistema → Schermo → Impostazioni schermo avanzate** e seleziona il massimo refresh supportato.
  - **Calibrazione Colori**: esegui **Calibra colori dello schermo** da **Pannello di controllo → Schermo** per regolare gamma, luminosità e contrasto.
  - **Scaling DPI**: in **Impostazioni → Sistema → Schermo**, regola lo **scaling** su percentuali personalizzate per evitare sfasamenti grafici su display ad alta risoluzione.

---

### Script 📜

Questa sezione centralizza gli strumenti di automazione per applicare rapidamente le modifiche. È consigliabile comprendere cosa fa uno script prima di eseguirlo.

* **Batch (.bat)**: Script per la manutenzione veloce, pulizia cache, rimozione file temporanei e reset dei componenti di Windows Update.
* **PowerShell (.ps1)**: Automazioni avanzate per il debloat (rimozione app preinstallate), configurazione privacy e ottimizzazioni profonde del sistema.
* **Registry Files (.reg)**: File di registro pronti all'uso per attivare o disattivare istantaneamente funzionalità (es. GameDVR, Telemetria, Fast Startup) senza navigare manualmente in Regedit.

> ⚠️ **Attenzione**: Esegui sempre gli script come Amministratore e verifica il contenuto aprendoli con un editor di testo se non sei sicuro della loro provenienza.

---

### Risoluzione Errori 🛠️

In questa sezione troverai strumenti e procedure per individuare e correggere problemi comuni su Windows 11. L’obiettivo è garantire **stabilità**, **ripristino rapido** e **prestazioni costanti** del sistema operativo.

#### 🧮 Comandi Utili da Terminale

* `CHKDSK`: verifica e corregge errori del file system.  
* `DISM /Online /Cleanup-Image /RestoreHealth`: ripara l'immagine di sistema danneggiata.  
* `SFC /scannow`: ripristina file di sistema corrotti.  
* `PowerCFG /energy`: analizza il consumo energetico e identifica inefficienze.  
* `Winsat formal`: aggiorna il punteggio prestazionale del sistema.

#### ⚙️ Configurazione di Sistema

* Rilevamento errato dei core logici:  
  1. Apri **msconfig**.  
  2. Vai in **Avvio** → **Opzioni avanzate**.  
  3. Imposta il numero di processori correttamente.

#### 💾 Disco: Deframmentazione e Ottimizzazione

* **HDD**: usa l’Utilità “Deframmenta e ottimizza unità”.  
* **SSD**: lascia attiva l’ottimizzazione automatica (no deframmentazione manuale!).

#### 🧠 Diagnostica della Memoria

* Avvia **Diagnostica memoria di Windows** (`mdsched.exe`) per testare eventuali problemi hardware nella RAM.

#### 🧾 Event Viewer

* Accedi con `eventvwr.msc`.  
* Analizza i log di **Sistema**, **Applicazione** e **Sicurezza** per identificare crash o errori ricorrenti.

#### ⚠️ Errori 2502 e 2503

* Cause: permessi mancanti nelle cartelle temporanee.  
* Soluzioni:
  1. Esegui **Esplora file** come amministratore.  
  2. Modifica permessi su `C:\Windows\Temp` e `C:\Temp`.  
  3. Avvia l’installazione con privilegi elevati (`.msi` da prompt).

#### ⚠️ Errore EFI Insufficiente (0xc1900200 / 0xc1900201)

La risoluzione degli errori **0xc1900200** e **0xc1900201** si concentra sul superamento del blocco degli aggiornamenti di Windows 11 (come la versione 24H2) causato da **spazio insufficiente** nella **Partizione di Sistema EFI (ESP)**. Per risolvere, si possono applicare tre metodologie progressive: pulizia dei file obsoleti, ridimensionamento non distruttivo o, come ultima risorsa, la ricreazione totale dell'ESP per aumentarne la dimensione.

#### 🧱 Driver Grafici

* Usa **DDU (Display Driver Uninstaller)** in modalità provvisoria per rimuovere completamente i driver.  
* Reinstalla l’ultima versione dal sito NVIDIA o AMD.

#### 📉 Monitoraggio Affidabilità

* Cerca **Affidabilità** nella barra di ricerca → **Visualizza cronologia affidabilità**.  
* Monitora crash, errori e warning per identificare pattern di instabilità.

#### 🔁 QMR (Quick Machine Recovery)

* Sistema di snapshot e backup automatico.  
* Ripristina lo stato precedente in pochi istanti in caso di problemi critici.

#### 🧼 Strumento di Pulizia

* Esegui **Pulizia disco** o usa comandi PowerShell/Batch per:
  - Eliminare file temporanei, cache e log non necessari.  
  - Liberare spazio e migliorare la reattività generale.

#### 🛠️ Strumento di Risoluzione dei Problemi

* Accesso rapido: `ms-settings:troubleshoot`.  
* Diagnostica guidata per audio, rete, aggiornamenti e periferiche.

#### 🔄 Script Batch: Reset Windows Update

In sintesi, lo script:

* Ferma i servizi di aggiornamento
* Elimina file e cache corrotti
* Ripara le registrazioni delle librerie critiche
* Ripristina componenti di rete
* Riavvia i servizi puliti
* Il risultato atteso è un ambiente Windows Update “resettato”, spesso risolutivo per errori come 0x80070005, download bloccati o aggiornamenti che non partono.

### Sicurezza 🔒

Questa sezione copre le **misure difensive** e le **best practice** per proteggere il tuo sistema, i dati e gli account.

#### 🛡️ Disattivare Recall

* Windows Analizza immagini localmente con AI e salva risultati in un DB SQLite non crittografato nella cartella utente.
* Disabilita in **Impostazioni → Privacy & sicurezza → AI e servizi multimediali → Recall**.

#### 📁 Disinstallare OneDrive

* Prevenzione: OneDrive è attivo di default e può caricare automaticamente i tuoi dati su cloud, consumando risorse e sollevando dubbi sulla sicurezza.
* **Procedura:**
  1. Apri **Aggiungi o rimuovi programmi**.
  2. Cerca **Microsoft OneDrive**.
  3. Clicca sui tre puntini (...) a destra e seleziona **Disinstalla**.

#### 🔄 Creazione Punto di Ripristino

> **PRIMA DI TUTTO**, crea sempre un punto di ripristino:  

1. Apri **Pannello di controllo → Sistema → Protezione sistema**.  
2. Seleziona l’unità di sistema e clicca **Crea…**.  
3. Nomina il punto e conferma.

#### 🔐 Gestione Disco: Crittografia

* **BitLocker On/Off**:
  - Attiva in **Pannello di controllo → Sistema e sicurezza → Crittografia unità BitLocker**.
  - Ricorda di salvare la chiave di ripristino.

#### ⏯️ Disabilitare Autoplay

* Prevenzione: un drive USB con firmware riprogrammabile può caricare malware automaticamente.
* Disattiva in **Impostazioni → Dispositivi → Autoplay → Disattiva per tutti i supporti**.

#### 🔒 Sicurezza Account Google

* **Dispositivo perso**: revoca sessioni da [https://myaccount.google.com/security](https://myaccount.google.com/security) → **Gestisci dispositivi**.
* **Accesso software**: cambia password, abilita 2FA e rivedi app con accesso (OAuth).
* **Accesso fisico**: cancella token locali, modifica password e richiedi logout da tutti i dispositivi.

#### 🕵️‍♂️ Identificare e Rimuovere Virus

* **Task Manager**: processi sospetti, uso anomalo di CPU/RAM.
* **Windows Defender**: esegui scansione completa e offline.
* **App di avvio**: disabilita voci non riconosciute in `shell:startup` e Task Manager.
* **Traffico rete**: `netstat -abno` per connettere processi a porte.

#### 🖥️ Problemi MiniPC Modificati

* Virus “PuabundlerWIN32”: malware preinstallato su MiniPC cinesi.
* **Rimozione**: avvia Safe Mode, esegui scansione Malwarebytes e Defender.
* **Sysinternals**:
  - **Autoruns** per controllare esecuzioni all’avvio.
  - **Process Explorer** per ispezionare DLL/caricamenti.
  - **TCPView** per connessioni sospette.

#### 🛡️ Potenziare Windows Defender

* **Memory Integrity**: Attiva in **Sicurezza di Windows → Sicurezza dispositivo → Integrità memoria**.
* **Periodic Scanning**: abilita scansione offline in Defender.

#### 📑 Consigli Generali di Sicurezza

* Sistema operativo sempre aggiornato.  
* Usa password forti, 2FA e gestore di password.  
* Crittografa dischi e backup.  
* Scegli software open‑source e rispetta il minimalismo digitale.  
* Naviga con browser privacy‑oriented, VPN, DNS sicuri.  
* Imposta permessi restrittivi per app e servizi.  
* Disabilita Bluetooth/RF quando non in uso.  
* Valuta VM o OS alternativi per attività sensibili.  
* Hardening avanzato tramite Group Policy e registry tweak.
* Documenta tutte le modifiche e automatizza verifiche periodiche.

---

## Linee Guida di Stile

* **Numerazione Step**  
* **Avvertenze** evidenziate con emoji ⚠️ e box dedicati.  
* **Backup & Ripristino** all’inizio di ogni sezione critica.  
* **Nomenclatura** coerente con prefisso numerico per ordine logico.