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

# Webserver-Aktivitäten protokollieren

# Webserver starten
# siehe Skript: start_and_check_apache.sh

# Webserver stoppen
# siehe Skript: stopp_and_check_apache.sh

# Server-Backup erstellen
# siehe Skript: webserver_backup.sh

# Dateien kopieren in Backup-Verzeichnis
if [ -d "$server_dir" ]; then
    for file in "$server_dir/"*; do
        if [ -e "$file" ]; then
            copied_file="$backup_dir/$(basename "$file")_backup"
            cp "$file" "$copied_file"
            if [ $? -eq 0 ]; then
                log_message "Datei $(basename "$file") wurde als $copied_file kopiert."
            else
                log_message "Fehler beim Kopieren der Datei $(basename "$file")."
            fi
        fi
    done
else
    log_message "Das Verzeichnis $server_dir existiert nicht."
fi

# Letzte 5 Log-Einträge anzeigen
echo "Letzte 5 Log-Einträge:"
tail -n 5 "$log_dir/$log_file"
