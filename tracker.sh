#!/data/data/com.termux/files/usr/bin/bash

# ═══════════════════════════════════════════════════════════
#   🛰  TRACKER LAUNCHER  —  Fixed version
# ═══════════════════════════════════════════════════════════

PACKAGE="com.mycompany.location"
ACTIVITY=".LoginActivity"

G='\033[0;32m'
R='\033[0;31m'
Y='\033[1;33m'
C='\033[0;36m'
N='\033[0m'

echo ""
echo -e "${C}╔═══════════════════════════════════════════════╗${N}"
echo -e "${C}║   🛰  TRACKER LAUNCHER  —  Installing         ║${N}"
echo -e "${C}╚═══════════════════════════════════════════════╝${N}"
echo ""

echo -e "${G}✓ Skipping package check (Android 11+ restriction)${N}"

mkdir -p ~/.shortcuts
echo -e "${G}✓ Shortcut dir: ~/.shortcuts${N}"

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
echo -e "${G}✓ Widget shortcuts created${N}"

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

echo -e "${G}✓ Aliases added${N}"
echo ""
echo -e "${G}╔═══════════════════════════════════════════════╗${N}"
echo -e "${G}║   ✅  INSTALLATION COMPLETE                    ║${N}"
echo -e "${G}╚═══════════════════════════════════════════════╝${N}"
echo ""
echo -e "${C}📱 Type koro:${N}"
echo -e "   ${Y}open${N}       → LoginActivity"
echo -e "   ${Y}openmain${N}   → MainActivity"
echo -e "   ${Y}opencal${N}    → Calendar"
echo -e "   ${Y}opentrip${N}   → Trips"
echo -e "   ${Y}openmap${N}    → Map"
echo -e "   ${Y}svc${N}        → Start service"
echo ""
