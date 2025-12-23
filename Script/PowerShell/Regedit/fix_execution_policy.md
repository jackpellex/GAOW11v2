# 🔧 Risoluzione Errore: "Esecuzione di script disabilitata"

## ❌ Errore Completo
```
Impossibile caricare il file. L'esecuzione di script è disabilitata nel sistema in uso.
CategoryInfo: Errore di protezione: (:) [], PSSecurityException
FullyQualifiedErrorId: UnauthorizedAccess
```

---

## ✅ Soluzione Rapida (Consigliata)

### Metodo 1: Esecuzione Singola (Più Sicuro)

1. **Apri PowerShell come Amministratore**
   - Cerca "PowerShell" nel menu Start
   - Click destro → "Esegui come amministratore"

2. **Copia e incolla questo comando:**
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```

3. **Conferma con `S` (Sì)**

4. **Naviga alla cartella dello script:**
   ```powershell
   cd "C:\Users\Jack\Desktop\Script"
   ```

5. **Esegui lo script:**
   ```powershell
   .\Registry-Automator.ps1
   ```

**Vantaggi:** La policy torna restrittiva alla chiusura di PowerShell (più sicuro)

---

### Metodo 2: Permanente (Più Comodo)

1. **Apri PowerShell come Amministratore**

2. **Esegui:**
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   ```

3. **Conferma con `S`**

4. **Ora puoi eseguire qualsiasi script locale senza ripetere il comando**

**Vantaggi:** Non devi più impostare la policy ogni volta  
**Svantaggi:** Leggermente meno sicuro (ma comunque protegge da script scaricati da internet)

---

## 🔍 Verifica Policy Attuale

Per controllare quale policy è attiva:
```powershell
Get-ExecutionPolicy -List
```

Output ideale:
```
Scope          ExecutionPolicy
-----          ---------------
CurrentUser    RemoteSigned
LocalMachine   Undefined
```

---

## 📝 Spiegazione delle Policy

| Policy | Cosa Permette |
|--------|---------------|
| **Restricted** | Nessuno script (default Windows) |
| **RemoteSigned** | Script locali OK, quelli da internet devono essere firmati |
| **Bypass** | Tutto consentito (solo per la sessione corrente) |
| **Unrestricted** | Tutto consentito (permanente, sconsigliato) |

---

## ⚠️ Se Continui ad Avere Errori

### Problema: "Set-ExecutionPolicy: Accesso negato"

**Soluzione:** Assicurati di essere **Amministratore**:
1. Click destro su PowerShell
2. "Esegui come amministratore"
3. Deve comparire "Amministratore: Windows PowerShell" nel titolo

---

### Problema: Policy bloccata da Group Policy

Se lavori su un PC aziendale, la policy potrebbe essere bloccata dall'IT.

**Soluzione alternativa:**
```powershell
powershell.exe -ExecutionPolicy Bypass -File ".\Registry-Automator.ps1"
```

---

## 🎯 Riassunto Veloce

**Per usare lo script UNA SOLA VOLTA:**
```powershell
# In PowerShell come Admin:
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
cd "C:\Users\Jack\Desktop\Script"
.\Registry-Automator.ps1
```

**Per usarlo SEMPRE:**
```powershell
# In PowerShell come Admin (una volta sola):
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Poi puoi eseguire lo script normalmente ogni volta che vuoi!

---

## 🔒 Nota sulla Sicurezza

La policy di esecuzione di PowerShell NON è una misura di sicurezza vera e propria, ma un "safety net" per evitare di eseguire script per errore.

**RemoteSigned** è il compromesso perfetto:
- ✅ Protegge da script malevoli scaricati da internet
- ✅ Permette di usare i tuoi script locali
- ✅ È la configurazione consigliata da Microsoft per sviluppatori

---

**Dopo aver risolto, puoi procedere con l'esecuzione del Registry Automator! 🚀**