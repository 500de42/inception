#!/bin/bash
set -e

WP_DIR="/var/www/html"
WP_CONFIG="$WP_DIR/wp-config.php"

# Vérifier si wp-config.php existe déjà
if [ ! -f "$WP_CONFIG" ]; then
    cp "$WP_DIR/wp-config-sample.php" "$WP_CONFIG"

    # Remplacer les valeurs de base de données avec les variables d'environnement
    sed -i "s/database_name_here/${DB_NAME}/" "$WP_CONFIG"
    sed -i "s/username_here/${DB_USER}/" "$WP_CONFIG"
    sed -i "s/password_here/${DB_PASSWORD}/" "$WP_CONFIG"
    sed -i "s/localhost/${DB_HOST}/" "$WP_CONFIG"

    echo "wp-config.php généré automatiquement."
else
    echo "wp-config.php existe déjà, aucun changement effectué."
fi

cat wp-config.php
php-fpm82 -F
