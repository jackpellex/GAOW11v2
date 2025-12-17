## **Guida a Robocopy (Robust File Copy)**

Robocopy (Robust File Copy) è un'utility da riga di comando di Windows estremamente pratica ed efficace per la gestione di file e directory. La sua robustezza la rende ideale per operazioni complesse come il **backup**, la **sincronizzazione** e la **migrazione dati**. A differenza dei metodi di copia tradizionali, Robocopy è in grado di eseguire backup in modo intelligente, verificando quali file sono stati modificati per copiarli in maniera incrementale. Questo significa che, in caso di un'interruzione (ad esempio, per un'improvvisa mancanza di corrente) o di un backup parziale già esistente, può riprendere l'operazione concentrandosi solo sui file nuovi, modificati o corrotti, risparmiando tempo e risorse.

Di default, Robocopy processa un file alla volta, ma è possibile sfruttare il multithreading per copiare più file in parallelo con il parametro `/MT[:n]`. Questo è particolarmente utile quando si ha a che fare con un numero elevato di file di piccole dimensioni, dove il tempo di avvio per ogni singolo file può incidere sull'efficienza. Per file di grandi dimensioni, invece, l'impostazione di default è più che sufficiente, dato che il tempo di trasferimento prevale sui tempi di gestione dei thread.

---

### **A cosa serve**

Robocopy è uno strumento versatile utilizzato per:

 * **Backup incrementale**: copia solo i file nuovi o modificati, risparmiando tempo e risorse.
 * **Sincronizzazione di directory**: mantiene una copia speculare (mirror) tra due percorsi, assicurando che siano sempre identici.
 * **Migrazione dati**: sposta grandi quantità di dati da un'unità all'altra mantenendo intatte le proprietà dei file (come permessi e timestamp).
 * **Gestione degli errori**: può riprovare a copiare i file che falliscono inizialmente, rendendolo ideale per le copie su connessioni di rete instabili.

---

### **Sintassi di base e parametri comuni**

La sintassi di base è `robocopy [origine] [destinazione] [opzioni]`.

Ecco alcuni dei parametri più comuni e utili:

 * `/S`: copia le sottodirectory, ma esclude quelle vuote.
 * `/E`: copia le sottodirectory, incluse quelle vuote.
 * `/MIR`: esegue la sincronizzazione, copiando i file nuovi e modificati e **eliminando** quelli che non sono più presenti nel percorso di origine. È un comando molto potente, da usare con cautela.
 * `/Z`: esegue la copia in "modalità riavviabile", permettendo a Robocopy di riprendere la copia di un file interrotta.
 * `/DCOPY:T`: mantiene i timestamp delle directory.
 * `/MT[:n]`: abilita la copia multi-thread. Aumenta la velocità di copia usando più thread contemporaneamente, con `n` che indica il numero di thread da usare (default 8, max 128).
 * `/R:n`: imposta il numero di tentativi per ogni file fallito (default 1.000.000). Usa `/R:1` per un solo tentativo aggiuntivo.
 * `/W:n`: imposta il tempo di attesa tra i tentativi in secondi (default 30).
 * `/L`: esegue una **simulazione** dell'operazione, mostrando cosa verrebbe copiato senza effettivamente copiare nulla.
 * `/LOG:file`: salva l'output del comando in un file di log. Usa `/LOG+:file` per aggiungere l'output a un file esistente.
 * `/NP`: non mostra l'avanzamento della copia in percentuale per una maggiore leggibilità del log.

---

### **Esempio di utilizzo pratico**

Il comando `robocopy.exe "Percorso\origine" "Percorso\destinazione" /COPY:DATSOU /e /r:1` è un ottimo esempio di comando di backup robusto. Analizziamo le opzioni:

 * `robocopy.exe`: richiama l'eseguibile.
 * `"Percorso\origine"` e `"Percorso\destinazione"`: specificano le cartelle. Le virgolette sono necessarie se i percorsi contengono spazi.
 * `/COPY:DATSOU`: specifica gli attributi da copiare: **D**ati, **A**ttributi, **T**imestamp, **S**icurezza (permessi NTFS), **O**wner (proprietario) e **U**dit (informazioni di controllo).
 * `/e`: include tutte le sottocartelle, anche quelle vuote.
 * `/r:1`: riprova a copiare un file fallito solo una volta, evitando di bloccare l'operazione in caso di errori persistenti.

Un altro comando utile è:
`robocopy.exe "Percorso\origine" "Percorso\destinazione" /copy:datsou /e /r:10 /MT[:12] /z`

Ecco il significato dei parametri aggiuntivi:
 * `/r:10`: Imposta a 10 il numero di tentativi per ogni file che fallisce la copia.
 * `/MT[:12]`: Abilita il multi-threading con 12 thread. Questo è particolarmente efficace per copiare un grande numero di file di piccole dimensioni, poiché riduce l'impatto del tempo di avvio su ogni singolo file.
 * `/z`: Attiva la modalità "riavviabile", che consente a Robocopy di riprendere la copia di un file interrotta da dove si era fermata, senza dover ricominciare il trasferimento da capo. Questo è un vantaggio significativo in particolare per i file di grandi dimensioni.

Per usarlo, apri il **Prompt dei comandi** (o Windows Terminal) come amministratore e inserisci il comando sostituendo i percorsi con i tuoi.

> "Robocopy è un'utility della riga di comando versatile e potente per copiare file e directory." — [Microsoft Learn](https://learn.microsoft.com/it-it/windows-server/administration/windows-commands/robocopy)

Il video [Robocopy, the Ultimate Guide](https://www.youtube.com/watch?v=_jco9nMMPr8) fornisce una guida completa e visiva all'utilizzo di Robocopy.
http://googleusercontent.com/youtube_content/0