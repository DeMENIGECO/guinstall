# GUInstall

**GUInstall** è un installer da terminale per installare e configurare facilmente ambienti desktop Linux, senza dover eseguire manualmente decine di comandi.

> 🚧 **Progetto in sviluppo**

L'obiettivo di GUInstall è rendere l'installazione di un'interfaccia grafica su Linux il più semplice possibile, soprattutto in ambienti come **WSL + WSLg**.

---

## ✨ Funzionalità

Attualmente GUInstall supporta:

- 🐧 Debian/Ubuntu su WSL
- 🖥️ GNOME tramite WSLg
- 🌐 Wayland
- 🧩 Mutter
- 🛠️ Mutter DevKit
- 📦 Installazione automatica dei pacchetti necessari
- ✅ Controlli automatici dell'ambiente
- 🚀 Creazione automatica dello script di avvio
- 🎨 Interfaccia CLI semplice e colorata

### Ambienti desktop

| Desktop | Supporto |
|---|---|
| GNOME | ✅ Disponibile |
| XFCE4 | 🚧 In sviluppo |

---

## 🖥️ GNOME su WSLg

GUInstall utilizza il **Mutter DevKit** per eseguire GNOME Shell all'interno di una finestra WSLg.

Il comando utilizzato è:

    dbus-run-session -- gnome-shell --wayland --devkit --no-x11

Questo permette a GNOME Shell di utilizzare Wayland senza dover configurare un display manager come GDM.

---

## 📋 Requisiti

Per utilizzare la configurazione GNOME + WSLg sono necessari:

- Windows 11
- WSL2
- Una distribuzione Debian o Ubuntu
- WSLg funzionante
- Connessione Internet
- `sudo`
- Accesso ai repository dei pacchetti della distribuzione

Per GNOME vengono installati automaticamente:

    gnome-session
    gnome-shell
    mutter
    mutter-dev-bin

---

## 🚀 Installazione

Clona il repository:

    git clone https://github.com/DeMENIGECO/GUInstall.git

Entra nella directory:

    cd GUInstall

Rendi eseguibile GUInstall:

    chmod +x guinstall.sh

Avvialo:

    ./guinstall.sh

---

## 🧙 Procedura guidata

GUInstall presenta una procedura guidata direttamente nel terminale.

Esempio:

    ╔══════════════════════════════════════════╗
    ║              GUInstall                           ║
    ║       Linux Desktop Environment                  ║
    ╚══════════════════════════════════════════╝

    Benvenuto in GUInstall!

    Potrai installare l'interfaccia grafica
    che desideri in Linux.

    Scegli OS:

    1. Debian/Ubuntu (WSL)

    Inserisci il numero della distro: 1

    Scegli DE:

    1. XFCE4 (X11) (in sviluppo)
    2. GNOME (Finestra WSLg)

    Numero: 2

    Conferma

    Questo sembra giusto?

    OS: Debian/Ubuntu (WSL)
    DE: GNOME

    Corretto? s/n: s

    Verifica ambiente WSL... OK
    Verifica Variabili GUI... OK
    Verifica Wayland... OK

Successivamente GUInstall installa e configura automaticamente GNOME.

---

## 📁 File creati

Dopo l'installazione viene creata la directory:

    ~/desktops/

Al suo interno viene generato:

    gnome-50.sh

La struttura sarà quindi:

    /home/<utente>/
    └── desktops/
        └── gnome-50.sh

---

## ▶️ Avviare GNOME

Dopo l'installazione è sufficiente eseguire:

    ~/desktops/gnome-50.sh

GNOME Shell verrà avviato in una nuova finestra WSLg.

---

## 🔧 Perché Mutter DevKit?

In una normale installazione Linux, GNOME viene generalmente avviato tramite una sessione grafica gestita da componenti come GDM e logind.

In WSL questo modello non è sempre applicabile allo stesso modo.

GUInstall utilizza quindi il **Mutter DevKit**, che permette di avviare GNOME Shell come compositor Wayland in una finestra WSLg.

Questo evita configurazioni complesse di:

- GDM
- X11
- XRDP
- sessioni logind
- display manager

---

## 🛡️ Sicurezza

GUInstall cerca di modificare il meno possibile il sistema.

Le variabili d'ambiente utilizzate da GNOME vengono impostate nello script:

    ~/desktops/gnome-50.sh

e non vengono aggiunte permanentemente al `.bashrc`.

L'installazione dei pacchetti richiede comunque `sudo`.

---

## 🗺️ Roadmap

### v0.1

- [x] Menu CLI
- [x] Rilevamento WSL
- [x] Controllo WSLg
- [x] Controllo Wayland
- [x] Installazione GNOME
- [x] Installazione Mutter
- [x] Installazione Mutter DevKit
- [x] Generazione script di avvio
- [ ] Supporto XFCE4

### v0.2

Possibili funzionalità:

- [ ] Più distribuzioni Linux
- [ ] Più desktop environment
- [ ] Disinstallazione dei desktop
- [ ] Aggiornamento delle installazioni
- [ ] Rilevamento automatico delle versioni
- [ ] Modalità non interattiva

### Futuro

- [ ] Supporto Linux nativo
- [ ] Supporto a più sistemi di init
- [ ] Configurazione grafica
- [ ] Sistema di plugin
- [ ] Installer per nuovi desktop environment

---

## 🤝 Contribuire

I contributi sono benvenuti!

Puoi:

1. Fare un fork del repository.
2. Creare un nuovo branch.
3. Apportare le modifiche.
4. Testare le modifiche.
5. Creare una Pull Request.

Prima di contribuire, assicurati che le modifiche non rompano l'installazione GNOME + WSLg esistente.

---

## 📜 Licenza

GUInstall è un progetto open source.

Consulta il file `LICENSE` per conoscere i termini della licenza utilizzata dal progetto.

---

## 💚 Autore

Creato da **DeMENIGECO**.

**GUInstall — Installare Linux, senza complicazioni.**
