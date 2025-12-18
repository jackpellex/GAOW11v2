# Guida: Disabilitare l'Esecuzione in Background delle App su Windows 11

Esistono diversi metodi per impedire alle app di Windows di girare in background, a seconda della versione del sistema operativo in uso.

---

## 1. Windows 11 Pro / Enterprise (Criteri di Gruppo)

Se utilizzi una versione professionale, puoi applicare una restrizione globale tramite l'Editor Criteri di Gruppo Locali.

1. Premi **Windows + R**, digita **gpedit.msc** e premi **Invio**.
2. Naviga nel percorso:
`Configurazione computer` > `Modelli amministrativi` > `Componenti di Windows` > `Privacy dell'app`
3. Individua la voce: **"Consenti l'esecuzione delle app di Windows in background"**.
4. Imposta su **Attivata**.
5. Nel menu a tendina "Opzioni", seleziona **Nega forzatamente**.
6. Clicca su **Applica** e poi su **OK**.

**Risultato:** Impedisce alle app di eseguire processi quando non sono in uso, ottimizzando CPU e RAM.

---

## 2. Windows 11 Home / Non Attivato (Registro di Sistema)

Nelle versioni Home o non attivate, dove l'editor dei criteri è assente o le personalizzazioni sono limitate, si interviene tramite il Registro di Sistema.

1. Premi **Windows + R**, digita **regedit** e premi **Invio**.
2. Incolla nella barra degli indirizzi:
`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy`
*(Nota: se la chiave **AppPrivacy** non esiste, creala facendo clic destro su Windows > Nuovo > Chiave).*
3. Fai clic destro su **AppPrivacy** > **Nuovo** > **Valore DWORD (32 bit)**.
4. Nomina il valore come **LetAppsRunInBackground**.
5. Fai doppio clic sul valore e imposta i dati a **2**.
* **0** = Gestito dall'utente
* **2** = Disabilitato per tutte le app


6. Riavvia il PC per applicare le modifiche.

---

### Confronto tra Versioni

| Caratteristica | Windows 11 Pro / Ent | Windows 11 Home | Windows Non Attivato |
| --- | --- | --- | --- |
| **Strumento** | Editor Criteri di Gruppo | Registro di Sistema | Registro di Sistema |
| **Accesso Impostazioni** | Completo | Completo | Limitato (Personalizzazione) |
| **Impatto Prestazioni** | Elevato | Elevato | Elevato |

### Note Importanti

* **Ottimizzazione:** Anche su sistemi non attivati, questo metodo riduce l'attività di processi superflui (Meteo, Feedback Hub, News) non disattivabili tramite i menu standard bloccati.
* **Notifiche:** Disabilitando l'attività in background, le app non mostreranno notifiche in tempo reale né aggiorneranno dati finché non verranno aperte manualmente.