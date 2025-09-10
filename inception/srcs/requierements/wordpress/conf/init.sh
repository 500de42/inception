#!/bin/bash

DB_PASSWORD=$(cat /run/secrets/DB_PASSWORD)
DB_PASSWORD2=$(cat /run/secrets/DB_PASSWORD2)
MARIADB_ROOT_PASSWORD=$(cat /run/secrets/MARIADB_ROOT_PASSWORD)
WP_PASSWORD=$(cat /run/secrets/WP_PASSWORD)
WP_PASSWORD2=$(cat /run/secrets/WP_PASSWORD2)

echo "DEBUG: MARIADB_USER=$MARIADB_USER, DB_PASSWORD=$DB_PASSWORD"
# On attend que MariaDB réponde
until mysql -h mariadb -u"$MARIADB_USER" -p"$DB_PASSWORD" -e "SELECT 1" 2>/dev/null; do
    echo "⏳ En attente de MariaDB..."
    sleep 2
done

echo "✅ MariaDB est prêt."

if ! wp core is-installed --allow-root --path="/var/www/html"; then
    echo "⚙️ Installation de WordPress en cours..."

    wp config create --allow-root \
        --dbname=$MARIADB_DATABASE \
        --dbuser=$MARIADB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb:3306 \
        --path="/var/www/html" \
        --skip-check

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="INCEPTION42" \
        --admin_user=$USER_WP \
        --admin_password=$WP_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    wp user create "$USER_WP2" "$WP_ADMIN_EMAIL2" \
        --role=author \
        --user_pass=$WP_PASSWORD2 \
        --allow-root

else
    echo "✅ WordPress est déjà installé."
fi

chown -R www-data:www-data /var/www/html

php-fpm82 -F



















set -e

WP_DIR="/var/www/html"
WP_CONFIG="$WP_DIR/wp-config.php"
chown -R www-data:www-data "$WP_PATH" || true
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
