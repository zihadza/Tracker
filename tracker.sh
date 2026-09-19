
#!/data/data/com.termux/files/usr/bin/bash

# ═══════════════════════════════════════════════════════════
#   🛰  TRACKER LAUNCHER  —  Single File Installer
#   GitHub: https://github.com/YOUR_USERNAME/tracker.sh
#   Run:    curl -sL <raw_url> | bash
# ═══════════════════════════════════════════════════════════

PACKAGE="com.mycompany.location"
ACTIVITY=".LoginActivity"

# ─── Colors ────────────────────────────────────────────────
G='\033[0;32m'   # green
R='\033[0;31m'   # red
Y='\033[1;33m'   # yellow
C='\033[0;36m'   # cyan
N='\033[0m'      # reset

echo ""
echo -e "${C}╔═══════════════════════════════════════════════╗${N}"
echo -e "${C}║   🛰  TRACKER LAUNCHER  —  Installing         ║${N}"
echo -e "${C}╚═══════════════════════════════════════════════╝${N}"
echo ""

# ─── Step 1: Check app installed ───────────────────────────
echo -e "${Y}▶ Checking app installed...${N}"
if ! pm list packages 2>/dev/null | grep -q "$PACKAGE"; then
    echo -e "${R}✗ App NOT installed: $PACKAGE${N}"
    echo -e "${Y}  Install 'System Service' app first.${N}"
    exit 1
fi
echo -e "${G}✓ App found${N}"

# ─── Step 2: Shortcut directory ────────────────────────────
mkdir -p ~/.shortcuts
echo -e "${G}✓ Shortcut dir: ~/.shortcuts${N}"

# ─── Step 3: Widget shortcut files ─────────────────────────
cat > ~/.shortcuts/Settings << EOF
#!/data/data/com.termux/files/usr/bin/bash
am start -n $PACKAGE/$ACTIVITY
EOF

cat > ~/.shortcuts/OpenTracker << EOF
#!/data/data/com.termux/files/usr/bin/bash
am start -n $PACKAGE/$ACTIVITY
EOF

cat > ~/.shortcuts/OpenMain << EOF
#!/data/data/com.termux/files/usr/bin/bash
am start -n $PACKAGE/.MainActivity
EOF

chmod +x ~/.shortcuts/Settings
chmod +x ~/.shortcuts/OpenTracker
chmod +x ~/.shortcuts/OpenMain
echo -e "${G}✓ Widget shortcuts created (3)${N}"

# ─── Step 4: Aliases ───────────────────────────────────────
# Purano aliases remove koro
if [ -f ~/.bashrc ]; then
    sed -i '/# TRACKER_START/,/# TRACKER_END/d' ~/.bashrc
fi

cat >> ~/.bashrc << EOF

# TRACKER_START
alias open='am start -n $PACKAGE/$ACTIVITY'
alias openmain='am start -n $PACKAGE/.MainActivity'
alias opencal='am start -n $PACKAGE/.CalendarActivity'
alias opentrip='am start -n $PACKAGE/.TripActivity'
alias openmap='am start -n $PACKAGE/.MapViewActivity'
alias svc='am start-service -n $PACKAGE/.LocationService'
alias stopapp='am force-stop $PACKAGE'
# TRACKER_END

EOF

echo -e "${G}✓ Aliases added to ~/.bashrc${N}"

# ─── Step 5: Save launcher script ──────────────────────────
mkdir -p ~/.tracker
cp "$0" ~/.tracker/tracker.sh 2>/dev/null
chmod +x ~/.tracker/tracker.sh 2>/dev/null
echo -e "${G}✓ Launcher saved: ~/.tracker/tracker.sh${N}"

# ─── Step 6: Done ──────────────────────────────────────────
echo ""
echo -e "${G}╔═══════════════════════════════════════════════╗${N}"
echo -e "${G}║   ✅  INSTALLATION COMPLETE                    ║${N}"
echo -e "${G}╚═══════════════════════════════════════════════╝${N}"
echo ""
echo -e "${C}📱 Termux e type koro:${N}"
echo -e "   ${Y}open${N}       → LoginActivity (password page)"
echo -e "   ${Y}openmain${N}   → MainActivity (no password)"
echo -e "   ${Y}opencal${N}    → Calendar"
echo -e "   ${Y}opentrip${N}   → Trips"
echo -e "   ${Y}openmap${N}    → Map view"
echo -e "   ${Y}svc${N}        → Start service"
echo ""
echo -e "${C}📲 Termux:Widget setup:${N}"
echo -e "   1. F-Droid theke Termux:Widget install koro"
echo -e "   2. Home screen e widget add koro"
echo -e "   3. ${Y}'Settings'${N} ba ${Y}'OpenTracker'${N} select koro"
echo -e "   4. Tap korle app khulbe ✅"
echo ""
echo -e "${C}🔗 Ek line e run korte:${N}"
echo -e "   ${Y}curl -sL <RAW_URL> | bash${N}"
echo ""
