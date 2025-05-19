# !/bin/bash

# ----------------------------------------------
# Eingaben im Terminal und zugehörige Kommentare
# Verwendete Skripte und Dokumentation
# ----------------------------------------------

# Arbeitsverzeichnis der Skripte
work_dir="/mnt/c/Users/User/OneDrive/Desktop/Unterricht/Aufgaben/Projekt_1-Bash"
server_dir="/var/www/html"
backup_dir="/var/www/backups"
log_dir="/var/www/log_files"


# -------------------------------------------------
# Teil 1: Webserver-Installation und Bereitstellung
# -------------------------------------------------

# 1. Installation des Apache-Webservers
sudo apt update
sudo apt install apache2
# 2. Starten und aktivieren des Webservers
sudo systemctl start apache2
sudo systemctl enable apache2 
# Synchronizing state of apache2.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
# Executing: /usr/lib/systemd/systemd-sysv-install enable apache2
# 3. Bereitstellung der Webseite
sudo cp /mnt/c/Users/User/OneDrive/Desktop/Unterricht/Aufgaben/Projekt_1-Bash/index.html /var/www/html/
sudo cp /mnt/c/Users/User/OneDrive/Desktop/Unterricht/Aufgaben/Projekt_1-Bash/style.css /var/www/html/
# 4. Überprüfen des Webservers
http://localhost
# 5. Fehlerbehandlung
# Skript: start_and_check_apache.sh in 'work_dir'
bash start_and_check_apache.sh


# -------------------------------------
# Teil 2: Automatisierung der Sicherung
# -------------------------------------

# 1. Erstellen eines Backup-Skripts
# Skript: webserver_backup.sh in 'work_dir'
bash webserver_backup.sh
# bei fehlgeschlagenem Backup wird Info in Log-Datei im Backup-Verzeichnis geschrieben
# 2. Automatisierung der Backups
# Crontab öffnen
crontab -e
# neuen Cronjob im Crontab anlegen, Backup soll jeden Tag um 10 Uhr ausgeführt werden
0 10 * * * /mnt/c/Users/User/OneDrive/Desktop/Unterricht/Aufgaben/Projekt_1-Bash/webserver_backup.sh


# ---------------------------------------
# Teil 3: Benutzer- und Gruppenverwaltung
# ---------------------------------------

# 1. Erstellen von Benutzern und Gruppen
# Benutzer erstellen
sudo useradd webadmin
sudo useradd webuser
# Gruppe erstellen und Benutzer zuweisen
sudo groupadd webgroup
sudo usermod -aG webgroup webadmin
sudo usermod -aG webgroup webuser
# 2. Ändern der Berechtigungen
# webadmin als Besitzer des Verzeichnis festlegen
sudo chown -R webadmin:webgroup /var/www/html/
# Berechtigungen setzen
# Besitzer (7) - volle Rechte; Gruppe (5) - Lese- und Ausführungsrechte; andere Benutzer (4) - Leserechte
sudo chmod -R 754 /var/www/html
# 3. Überprüfen der Berechtigungen
ls -l /var/www/html


# ------------------------------------------------
# Teil 4: Schleifen und reguläre Ausdrücke (Regex)
# ------------------------------------------------

# 1. Überprüfen der Dateien im Webserver-Verzeichnis
# 2. Verwenden von Schleifen zum ausgeben aller '.html'-Dateien
# Skript: show_files.sh in 'work_dir'
bash show_files.sh


# -------------------------------------------------------
# Teil 5: Log-Dateien erstellen und Fehlerprotokollierung
# -------------------------------------------------------

# 1. Erstellen eines Log-Datei-Skripts
# 2. Fehlerprotokollierung
# 3. Verwendung von Schleifen zur Protokollierung
# 4. Fehlerbehandlung in der Log-Datei
# Skript: server_log.sh in 'work_dir'
bash server_log.sh
# Log-Einträge werden auch erstellt in anderen Skripten:
bash start_and_check_apache.sh
bash stopp_and_check_apache.sh
bash webserver_backup.sh

