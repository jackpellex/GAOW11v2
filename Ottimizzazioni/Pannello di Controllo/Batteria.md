# 🔋 Batteria e Alimentazione: Ottimizzazione Avanzata

Questa guida si concentra sulla personalizzazione delle **Opzioni risparmio energia** tramite il Pannello di controllo, essenziale per bilanciare prestazioni e autonomia sui PC portatili.

## ⚙️ Accesso alle Impostazioni

Percorso: `Pannello di controllo` \> `Hardware e suoni` \> `Opzioni risparmio energia`

-----

## 1\. Configurazione Iniziale e Coperchio

### Cosa succede alla chiusura del coperchio?

Clicca su **"Specificare cosa avviene quando viene chiuso il coperchio"** (dal menu a sinistra).

| Impostazione | Alimentazione a batteria | Alimentazione da rete elettrica |
| :--- | :--- | :--- |
| **Quando viene chiuso il coperchio** | **Non intervenire** | **Non intervenire** |
| **Quando viene premuto il pulsante di alimentazione** | **Non intervenire** | **Non intervenire** |

> ℹ️ **Nota sugli Sleep States:** L'impostazione "Non intervenire" è spesso preferita dagli utenti avanzati o sui sistemi già ottimizzati, evitando la sospensione automatica (sleep state) che, sebbene faccia risparmiare energia, può talvolta introdurre latenza o problemi di riattivazione. Per un'analisi più profonda, si rimanda a [`Sleep States.md`](https://www.google.com/search?q=Sleep_States.md).

### Abilitazione Ibernazione

Di default, l'opzione "Ibernazione" (Hibernate) potrebbe non essere visibile come impostazione di arresto.

#### Cos'è l'Ibernazione?

L'Ibernazione salva lo stato esatto della sessione di lavoro (tutti i programmi aperti, documenti, ecc.) direttamente sull'hard disk (nel file `hiberfil.sys`) e spegne completamente il sistema.

  * **Vantaggio:** A differenza della sospensione (che usa una piccola quantità di energia per mantenere la RAM attiva), l'ibernazione **non consuma energia** ed è **più rapida** dell'arresto e riavvio normali se si vuole riprendere il lavoro da dove lo si era lasciato.
  * **Problema di Spazio:** L'ibernazione richiede uno spazio su disco disponibile almeno pari alla quantità di RAM installata (si consiglia almeno **2 volte la RAM** libera per sicurezza).

#### Procedura di Attivazione

1.  Clicca su **"Modifica le impostazione attualmente non disponibili"** in alto.
2.  Accetta il prompt di autorizzazione (se richiesto).
3.  Nella sezione `Impostazioni di arresto`, seleziona il flag accanto a **"Ibernazione"**.
4.  Clicca **"Salva cambiamenti"**.

-----

## 2\. Creazione di Combinazioni Personalizzate

Clicca su **"Crea Combinazione per il risparmio Energia"** (dal menu a sinistra).

| Profilo | Scopo |
| :--- | :--- |
| **Risparmio Energia** | Massima autonomia e riduzione del consumo. |
| **Prestazioni Avanzate** (o **Turbo**) | Massime prestazioni hardware (CPU, GPU, I/O) a costo della batteria. |

-----

## 3\. Profilo: Risparmio Energia 🍃

Dopo aver creato o selezionato la combinazione "Risparmio Energia", clicca su **"Cambia impostazioni avanzate risparmio energia"**.

| Impostazione | Alimentazione a batteria | Alimentazione da rete elettrica |
| :--- | :--- | :--- |
| **Disco Rigido - Disattiva disco rigido dopo (minuti)** | **1** | **Mai** (o 1, per il massimo risparmio) |
| **Impostazioni sfondo del Desktop - Presentazione** | **Sospesa** | **Sospesa** |
| **Sospensione - Entra in sospensione dopo (minuti)** | **[Attivato - tempo breve a scelta]** | **Mai** (o [Attivato - tempo breve a scelta]) |
| **Sospensione - Consenti Timer di riattivazione** | **Disabilita** | **Disabilita** |
| **PCI Express - Risparmio energia stato collegamento** | **Risparmio energia massimo** | **Risparmio energia massimo** |
| **Risparmio energia del processore - Livello minimo prestazioni** | **5%** (Valore conservativo per risparmio) | **5%** (Valore conservativo per risparmio) |
| **Risparmio energia del processore - Livello massimo prestazioni** | **50%** (Limita la frequenza per un'autonomia elevata) | **100%** |
| **Schermo - Disattiva schermo dopo (minuti)** | **[Tempo breve a scelta]** | **Mai** |

### Impostazioni Batteria (Profilo Risparmio)

| Impostazione Batteria | Alimentazione a batteria | Alimentazione da rete elettrica |
| :--- | :--- | :--- |
| **Notifica batteria quasi scarica** | Attivata | Attivata |
| **Operazione di batteria quasi scarica** | **Iberna** | **Iberna** |
| **Livello di batteria in esaurimento** | **6%** | **6%** |
| **Livello di batteria quasi scarica** | **2%** | **2%** |
| **Notifica di batteria in esaurimento** | Attivata | Attivata |
| **Operazione per batteria in esaurimento** | Non intervenire | Non intervenire |
| **Livello di batteria di riserva** | **4%** | **4%** |

-----

## 4\. Profilo: Prestazioni Avanzate (Turbo) 🚀

Dopo aver creato o selezionato la combinazione "**Prestazioni Avanzate**" (o **Turbo**), clicca su **"Cambia impostazioni avanzate risparmio energia"**. L'obiettivo è impostare tutti i parametri per la **massima velocità e reattività**, disattivando le limitazioni energetiche.

| Impostazione | Alimentazione a batteria | Alimentazione da rete elettrica |
| :--- | :--- | :--- |
| **Disco Rigido - Disattiva disco rigido dopo (minuti)** | **Mai** | **Mai** |
| **Impostazioni sfondo del Desktop - Presentazione** | **Disponibile** | **Disponibile** |
| **Sospensione - Entra in sospensione dopo (minuti)** | **Mai** | **Mai** |
| **Sospensione - Consenti Timer di riattivazione** | **Abilita** | **Abilita** |
| **PCI Express - Risparmio energia stato collegamento** | **Disattiva** | **Disattiva** |
| **Risparmio energia del processore - Livello minimo prestazioni** | **100%** | **100%** |
| **Risparmio energia del processore - Livello massimo prestazioni** | **100%** | **100%** |
| **Schermo - Disattiva schermo dopo (minuti)** | **Mai** | **Mai** |

> ℹ️ **Chiavi del Turbo:** Le impostazioni più cruciali sono il **Livello minimo prestazioni del processore al 100%** (che previene il *downclocking* o l'ingresso in stati di risparmio energetico C-state più profondi) e **PCI Express - Disattiva** (per evitare qualsiasi latenza I/O dovuta al *link state power management*). L'abilitazione dei **Timer di riattivazione** consente alle app e ai servizi di riattivare il sistema se necessario, ad esempio per aggiornamenti o attività pianificate.

### Impostazioni Batteria (Profilo Turbo)

Questo profilo mantiene le impostazioni di emergenza simili al profilo Risparmio, in modo che in caso di esaurimento la sessione di lavoro sia salvata in modo sicuro.

| Impostazione Batteria | Alimentazione a batteria | Alimentazione da rete elettrica |
| :--- | :--- | :--- |
| **Notifica batteria quasi scarica** | Attivata | Attivata |
| **Operazione di batteria quasi scarica** | **Iberna** | **Iberna** |
| **Livello di batteria in esaurimento** | **6%** | **6%** |
| **Livello di batteria quasi scarica** | **2%** | **2%** |
| **Notifica di batteria in esaurimento** | Attivata | Attivata |
| **Operazione per batteria in esaurimento** | Non intervenire | Non intervenire |
| **Livello di batteria di riserva** | **4%** | **4%** |

---

Dopo aver applicato queste modifiche, ricorda di cliccare su **"Applica"** e **"OK"** per salvare il profilo **Prestazioni Avanzate (Turbo)**.