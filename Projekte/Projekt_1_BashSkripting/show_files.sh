# !/bin/bash

# Server-Verzeichnis
server_dir="/var/www/html"

# Überprüfen, ob das Verzeichnis existiert
if [ -d "$server_dir" ]; then
    echo "Überprüfe Dateien im Verzeichnis: $server_dir"
    # Schleife durch alle Dateien im Verzeichnis
    for file in "$server_dir/"*.html
    do
        # Überprüfen, ob die Datei existiert
        if [ -e "$file" ]; then
            # Anzeigen der gefundenen HTML-Dateien
            echo "Gefundene HTML-Datei: $(basename "$file")"
        else
            # Ausgabe falls keine Datei gefunden wurde
            echo "Keine HTML-Dateien gefunden."
        fi
    done
else
    # Ausgabe falls Verzeichnis nicht gefunden oder falsch eingegeben wurde
    echo "Das Verzeichnis $server_dir existiert nicht."
fi
