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

# Stopp Apache Webserver
# log_message "Webserver wird gestoppt."
sudo systemctl stop apache2

# Check, ob Apache läuft
if systemctl status apache2 | grep "inactive (dead)" > /dev/null
then
    echo "Apache Webserver wurde erfolgreich gestoppt."
    log_message "Apache Webserver erfolgreich gestoppt."
else
    echo "Apache Webserver konnte nicht gestoppt werden."
    log_message "Apache Webserver konnte nicht gestoppt werden."
    exit 1
fi

# Letzte 5 Log-Einträge anzeigen
echo "Letzte 5 Log-Einträge:"
tail -n 5 "$log_dir/$log_file"
