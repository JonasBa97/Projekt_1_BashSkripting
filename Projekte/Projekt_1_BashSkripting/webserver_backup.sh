# !/bin/bash

# Verzeichnisse definieren
server_dir="/var/www/html"
backup_dir="/var/www/backups"
log_dir="/var/www/log_files"
date=$(date +%Y%m%d%H%M%S)
# Log-Dateien definieren
log_file="server_log.log"
failed_backup="failed_backup.log"
# Backup-File als TAR (Taped Archiv)
# .gz ist Kompressionsmethode (gzip)
backup_file="backup-$date.tar.gz"

# Funktion zum Schreiben in die Log-Datei
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_dir/$log_file"
}

# Sicherung erstellen als TAR-Archivdatei
# -c: Erstellen eines neuen Archivs; -z: komprimiert das Archiv mit gzip; -P: unterdrückt Warnung; -f: Gibt den Namen der Archivdatei an
tar -czPf $backup_dir/$backup_file $server_dir
# Zum Entpacken der TAR-Archivdatei: -x: Extrahieren des Archivs; -v: Zeigt die Fortschrittsmeldungen an
# tar -xvf $backup_dir$backup_file

# Erfolgsmeldung
if [ $? -eq 0 ]; then
    echo "Backup von $server_dir wurde erfolgreich in $backup_dir/$backup_file erstellt."
    log_message "Backup erfolgreich erstellt."
else
    echo "Backup von $server_dir fehlgeschlagen" >> $backup_dir/$failed_backup
    echo "Datum: $date" >> $backup_dir/$failed_backup
    log_message "Backup fehlgeschlagen."
fi

# Letzte 5 Log-Einträge anzeigen
echo "Letzte 5 Log-Einträge:"
tail -n 5 "$log_dir/$log_file"