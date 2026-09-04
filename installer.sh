#!/bin/bash

# ==========================================================
# GUInstall
# Linux Desktop Environment Installer
# ==========================================================

set -u

# ---------- Colori ----------
GREEN="\033[32m"
RED="\033[31m"
CYAN="\033[36m"
YELLOW="\033[33m"
RESET="\033[0m"

ok() {
    echo -e "${GREEN}OK${RESET}"
}

error() {
    echo -e "${RED}ERRORE${RESET}"
}

info() {
    echo -e "${CYAN}$1${RESET}"
}

# ---------- Titolo ----------
clear

echo "╔══════════════════════════════════════════╗"
echo "║              GUInstall                   ║"
echo "║       Linux Desktop Environment          ║"
echo "╚══════════════════════════════════════════╝"
echo

echo "Benvenuto in GUInstall!"
echo
echo "Potrai installare l'interfaccia grafica"
echo "che desideri in Linux."
echo

# ==========================================================
# SCELTA OS
# ==========================================================

echo "Scegli OS:"
echo
echo "1. Debian/Ubuntu (WSL)"
echo

read -rp "Inserisci il numero della distro: " OS

if [ "$OS" != "1" ]; then
    echo
    error
    echo "Sistema operativo non supportato."
    exit 1
fi

# ==========================================================
# SCELTA DE
# ==========================================================

echo
echo "Scegli DE:"
echo
echo "1. XFCE4 (X11) (in sviluppo)"
echo "2. GNOME (Finestra WSLg)"
echo

read -rp "Numero: " DE

case "$DE" in
    1)
        echo
        echo "XFCE4 è ancora in sviluppo."
        echo "Questa opzione non è disponibile."
        exit 0
        ;;
    2)
        DE_NAME="GNOME"
        ;;
    *)
        echo
        error
        echo "Opzione non valida."
        exit 1
        ;;
esac

# ==========================================================
# CONFERMA
# ==========================================================

echo
echo "Conferma"
echo
echo "Questo sembra giusto?"
echo
echo "OS: Debian/Ubuntu (WSL)"
echo "DE: GNOME"
echo

read -rp "Corretto? s/n: " CONFIRM

case "$CONFIRM" in
    s|S)
        ;;
    *)
        echo
        echo "Installazione annullata."
        exit 0
        ;;
esac

# ==========================================================
# CONTROLLO WSL
# ==========================================================

echo
echo -n "Verifica ambiente WSL... "

if grep -qi microsoft /proc/version 2>/dev/null; then
    ok
else
    error
    echo
    echo "GUInstall richiede WSL per questa configurazione."
    exit 1
fi

# ==========================================================
# CONTROLLO WSLg
# ==========================================================

echo -n "Verifica Variabili GUI... "

GUI_OK=true

if [ -z "${WAYLAND_DISPLAY:-}" ]; then
    GUI_OK=false
fi

if [ -z "${DISPLAY:-}" ]; then
    GUI_OK=false
fi

if [ -z "${XDG_RUNTIME_DIR:-}" ]; then
    GUI_OK=false
fi

if [ "$GUI_OK" = true ]; then
    ok
else
    error
    echo
    echo "WSLg non sembra essere disponibile."
    echo
    echo "Controlla di avere WSLg attivo e riapri WSL."
    exit 1
fi

# ==========================================================
# CONTROLLO WAYLAND
# ==========================================================

echo -n "Verifica Wayland... "

if [ -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; then
    ok
else
    error
    echo
    echo "Socket Wayland non trovato:"
    echo "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"
    exit 1
fi

# ==========================================================
# CONTROLLO OCCHI
# ==========================================================

echo
echo "Vedi una finestra con occhi che seguono il mouse?"
echo
echo "Questo test verifica che WSLg possa mostrare"
echo "una finestra grafica."
echo

read -rp "s/n: " EYES

case "$EYES" in
    s|S)
        ;;
    *)
        echo
        error
        echo "Senza WSLg funzionante non è possibile"
        echo "installare GNOME in modalità finestra."
        exit 1
        ;;
esac

# ==========================================================
# INSTALLAZIONE
# ==========================================================

echo
echo -n "Installazione GNOME Session/Shell... "

if sudo apt-get update >/dev/null 2>&1 &&
   sudo apt-get install -y gnome-session gnome-shell >/dev/null 2>&1; then
    ok
else
    error
    exit 1
fi

# ==========================================================
# MUTTER
# ==========================================================

echo -n "Installazione Mutter/Mutter DevKit... "

if sudo apt-get install -y mutter mutter-dev-bin >/dev/null 2>&1; then
    ok
else
    error
    exit 1
fi

# ==========================================================
# VARIABILI
# ==========================================================

echo -n "Settaggio variabili Wayland e desktop... "

# Non modifichiamo .bashrc:
# le variabili vengono impostate nello script di avvio.

ok

# ==========================================================
# CREAZIONE DIRECTORY
# ==========================================================

mkdir -p "$HOME/desktops"

# ==========================================================
# SCRIPT GNOME
# ==========================================================

echo -n "Creazione script di avvio... "

cat > "$HOME/desktops/gnome-50.sh" <<'EOF'
#!/bin/bash

export XDG_CURRENT_DESKTOP=GNOME
export XDG_SESSION_DESKTOP=gnome
export XDG_SESSION_TYPE=wayland

dbus-run-session -- gnome-shell --wayland --devkit --no-x11
EOF

if [ -f "$HOME/desktops/gnome-50.sh" ]; then
    ok
else
    error
    exit 1
fi

# ==========================================================
# CHMOD
# ==========================================================

echo -n "Chmod... "

if chmod +x "$HOME/desktops/gnome-50.sh"; then
    ok
else
    error
    exit 1
fi

# ==========================================================
# APPLICAZIONI DELL'AMBIENTE
# ==========================================================

echo
echo "Installazione applicazioni dell'ambiente"
echo
echo "Vuoi installare alcune applicazioni consigliate per GNOME?"
echo
echo "1. Nautilus (Gestore file)"
echo "2. Firefox (Browser web)"
echo "3. GNOME Terminal"
echo "4. GNOME Settings"
echo "5. Tutte"
echo "6. Nessuna"
echo

read -rp "Scegli un'opzione: " APPS

case "$APPS" in
    1)
        echo -n "Installazione Nautilus... "
        if sudo apt-get install -y nautilus >/dev/null 2>&1; then
            ok
        else
            error
        fi
        ;;

    2)
        echo -n "Installazione Firefox... "
        if sudo apt-get install -y firefox >/dev/null 2>&1; then
            ok
        else
            error
        fi
        ;;

    3)
        echo -n "Installazione GNOME Terminal... "
        if sudo apt-get install -y gnome-terminal >/dev/null 2>&1; then
            ok
        else
            error
        fi
        ;;

    4)
        echo -n "Installazione GNOME Settings... "
        if sudo apt-get install -y gnome-control-center >/dev/null 2>&1; then
            ok
        else
            error
        fi
        ;;

    5)
        echo -n "Installazione applicazioni GNOME... "

        if sudo apt-get install -y \
            nautilus \
            firefox \
            gnome-terminal \
            gnome-control-center \
            >/dev/null 2>&1; then
            ok
        else
            error
        fi
        ;;

    6)
        echo "Nessuna applicazione aggiuntiva selezionata."
        ;;

    *)
        error
        echo "Opzione non valida. Nessuna applicazione installata."
        ;;
esac

# ==========================================================
# FINE
# ==========================================================

echo
echo "╔══════════════════════════════════════════╗"
echo "║          DESKTOP INSTALLATO!             ║"
echo "╚══════════════════════════════════════════╝"
echo
echo "GNOME è stato installato correttamente."
echo
echo "Per avviarlo:"
echo
echo "    ~/desktops/gnome-50.sh"
echo
