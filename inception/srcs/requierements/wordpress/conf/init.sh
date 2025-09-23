#!/bin/bash
set -e

# Récupération des secrets
DB_PASSWORD=$(cat /run/secrets/DB_PASSWORD)
DB_PASSWORD2=$(cat /run/secrets/DB_PASSWORD2)
MARIADB_ROOT_PASSWORD=$(cat /run/secrets/MARIADB_ROOT_PASSWORD)
WP_PASSWORD=$(cat /run/secrets/WP_PASSWORD)
WP_PASSWORD2=$(cat /run/secrets/WP_PASSWORD2)

WP_PATH="/var/www/html"
CONFIG_REDIS="/** Configuration Redis Cache */
define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_SCHEME', 'tcp');
define('WP_CACHE', true);"

chown -R www-data:www-data $WP_PATH

# Télécharger WordPress si pas déjà présent
if [ ! -f /var/www/html/wp-load.php ]; then
    echo "⬇️ Téléchargement de WordPress..."
    wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1
    rm /tmp/wordpress.tar.gz
    chown -R www-data:www-data /var/www/html
fi

until mysql -h mariadb -u"$MARIADB_USER" -p"$DB_PASSWORD" -e "SELECT 1" 2>/dev/null; do
    echo "⏳ En attente de MariaDB..."
    sleep 2
done
echo "✅ MariaDB est prêt."

# Créer wp-config.php si absent
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "⚙️ Création du wp-config.php..."
    wp config create --allow-root \
        --dbname=$MARIADB_DATABASE \
        --dbuser=$MARIADB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb:3306 \
        --path="/var/www/html" \
        --skip-check
fi

# Installer WordPress si non installé
if ! wp core is-installed --allow-root --path="/var/www/html"; then
    echo "⚙️ Installation de WordPress..."
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="wordpress" \
        --admin_user=$USER_WP \
        --admin_password=$WP_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
fi

# Créer user secondaire si pas existant
if ! wp user get "$USER_WP2" --allow-root --path="/var/www/html" &>/dev/null; then
    wp user create "$USER_WP2" "$WP_ADMIN_EMAIL2" \
        --role=author \
        --user_pass=$WP_PASSWORD2 \
        --allow-root
fi


# Ajout config Redis dans wp-config.php si pas déjà présent

wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp config set WP_CACHE_KEY_SALT "kcharbon.42.fr" --allow-root
wp config set WP_REDIS_CLIENT phpredis --allow-root
wp config set WP_DEBUG true --raw --type=constant --allow-root
wp config set WP_DEBUG_LOG true --raw --type=constant --allow-root
wp config set WP_DEBUG_DISPLAY false --raw --type=constant --allow-root

wp plugin install redis-cache --allow-root
wp plugin update --all --allow-root
# wp redis enable --allow-root



if ! wp plugin is-installed redis-cache --allow-root; then
    wp plugin install redis-cache --allow-root --path="/var/www/html"
    echo "⚙️ Installation de Redis..."
else 
    echo "Redis already installed"
fi

if wp plugin is-active redis-cache --allow-root; then
    wp redis enable --allow-root
else
    echo "⚠️ Plugin Redis pas encore actif, skip."
fi

# Lancer PHP-FPM
php-fpm82 -F
