# !/bin/bash

# Verzeichnisse definieren
server_dir="/var/www/html"
log_dir="/var/www/log_files"
backup_dir="/var/www/backups"
# Log-Datei definieren
log_file="server_log.log"

# Funktion zum Schreiben in die Log-Datei
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_dir/$log_file"
}

# Start Apache Webserver
# log_message "Webserver wird gestartet."
# sudo systemctl start apache2

# Check, ob Apache läuft
log_message "Status des Webservers wird geprüft."
if systemctl status apache2 | grep "active (running)" > /dev/null
then
    echo "Apache Webserver läuft erfolgreich. IT-Boss-Solutions ist online!"
    log_message "Apache Webserver läuft erfolgreich."
else
    echo "Fehler: Apache Webserver konnte nicht gestartet werden."
    log_message "Statusprüfung fehlerhaft."
    exit 1
fi

# Letzte 5 Log-Einträge anzeigen
echo "Letzte 5 Log-Einträge:"
tail -n 5 "$log_dir/$log_file"