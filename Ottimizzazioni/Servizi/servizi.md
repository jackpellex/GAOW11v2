# Configurazione Servizi Windows 11 per Ottimizzazione

Questa configurazione elenca i servizi di Windows 11 che possono essere **disabilitati** o impostati su **manuale** per ridurre il numero di processi attivi, migliorare le prestazioni e ottimizzare l'uso delle risorse. La configurazione è pensata per un utilizzo standard, senza funzionalità avanzate come accesso remoto, stampa di rete o altri servizi meno comuni.

---

## **Servizi da Disabilitare**
Questi servizi possono essere disabilitati in sicurezza nella maggior parte dei casi.

AJRouter                       # Servizio AllJoyn Router

AppVClient                     # Microsoft App-V Client

AssignedAccessManagerSvc       # Servizio Assigned Access Manager

DiagTrack                      # Esperienza utente connesse e telemetria

DialogBlockingService          # Blocco dialoghi interattivi

NetTcpPortSharing              # Condivisione porte net.tcp

RemoteRegistry                 # Registro remoto

shpamsvc                       # Microsoft Health Service

ssh-agent                      # OpenSSH Authentication Agent

tzautoupdate                   # Aggiornamento automatico fuso orario

uhssvc                         # Universal Telemetry Client

UevAgentService                # User Experience Virtualization

RetailDemo                     # Servizio Demo del negozio

Fax                            # Servizio di gestione Fax

WMPNetworkSvc                  # Servizio rete Windows Media Player

SensorMonitoringService        # Monitoraggio sensori hardware

MapsBroker                     # Gestione mappe scaricate

PushToInstall                  # Push-to-Install Service

RoutingAndRemoteAccess         # Accesso e routing remoto

BluetoothSupportService        # Supporto connessioni Bluetooth

MapsBroker                     # Gestione mappe offline

Waves Audio Services           # Funzioni audio avanzate

OpenSSH Authentication Agent   # Agente autenticazione SSH

DialogBlockingService          # Gestione dialoghi interattivi

Adobe Acrobat Update Service   # Aggiornamento automatico di Adobe Acrobat

Windows Biometric Service      # Supporto per sensori biometrici

WSearch                        # Indicizzazione di contenuto nelle cartelle "Esplora File"


## **Servizi da Impostare su Manuale**
Questi servizi possono essere impostati su Manuale per consentire al sistema di avviarli solo se necessario.

ALG                            # Application Layer Gateway

AppIDSvc                       # Servizio di identificazione applicazioni

AppMgmt                        # Gestione applicazioni

AppReadiness                   # Prontezza applicazioni

AppXSvc                        # Deployment applicazioni moderne

BDESVC                         # Servizio Crittografia BitLocker

BITS                           # Servizio trasferimento intelligente in background

Browser                        # Servizio browser computer

CertPropSvc                    # Servizio di propagazione certificati

ClipSVC                        # Servizio di infrastruttura per le app

CscService                     # Servizio per file offline

DiagSvc                        # Servizio diagnostico

DoSvc                          # Ottimizzazione distribuzione

EFS                            # File System Crittografato

InstallService                 # Servizio di installazione

IpxlatCfgSvc                   # IPv4 a IPv6

LicenseManager                 # Gestione licenze Microsoft

NaturalAuthentication          # Autenticazione biometrica

PeerDistSvc                    # Peer Distribution

PerfHost                       # Host per i contatori delle prestazioni

PimIndexMaintenanceSvc         # Indicizzazione delle informazioni personali

PlugPlay                       # Plug and Play

PrintNotify                    # Notifiche di stampa

RpcLocator                     # Localizzatore RPC

SecurityHealthService          # Salute del sistema

SharedAccess                   # Condivisione connessione Internet

SmsRouter                      # Routing SMS

StiSvc                         # Acquisizione immagini

TabletInputService             # Tastiera virtuale e pannello input penna

W32Time                        # Sincronizzazione ora di sistema

WaaSMedicSvc                   # Windows Update Medic

WdiServiceHost                 # Host servizi diagnostici

WdiSystemHost                  # Host diagnostica di sistema

WlanSvc                        # Configurazione rete Wi-Fi

WpnService                     # Notifiche di Windows

XboxGipSvc                     # Servizio Input per Xbox

XboxNetApiSvc                  # Rete Xbox

TabletInputService             # Supporto per input touchscreen e penne digitali

WlanSvc                        # Configurazione rete Wi-Fi

WpnService                     # Notifiche di Windows

Windows Search                 # Indicizzazione file per ricerche rapide

Superfetch/SysMain             # Ottimizzazione caricamento applicazioni

Update Orchestrator Service    # Coordinamento aggiornamenti di Windows

## **Servizi Sconsigliati da Disabilitare**
Questi servizi sono critici per la stabilità e la sicurezza del sistema e non dovrebbero essere disabilitati.

Microsoft Update Health Service # Supporto per Windows Update

Plug and Play                  # Rilevamento e gestione delle periferiche

RPC (Remote Procedure Call)    # Comunicazione tra servizi Windows

Windows Event Log              # Archivia eventi di sistema

Windows Defender Antivirus     # Protezione antivirus predefinita

Windows Time                   # Sincronizzazione oraria del sistema

Windows Update                 # Gestione aggiornamenti di sistema

RemoteAccess                   # Routing e Accesso Remoto

## Ulteriori Consigli
- Backup Configurazione
Prima di modificare i servizi, salva la configurazione attuale. Puoi utilizzare uno script PowerShell per esportare le impostazioni.

- Approccio Graduale
Testa le modifiche in piccoli gruppi per identificare eventuali problemi causati da un servizio disabilitato.

- Aggiornamenti Manuali
Se disabiliti i servizi di aggiornamento automatico (es. Google Update), assicurati di aggiornare manualmente le applicazioni.

- Documentazione Costante
Registra ogni modifica per poter tornare rapidamente allo stato precedente, se necessario.

