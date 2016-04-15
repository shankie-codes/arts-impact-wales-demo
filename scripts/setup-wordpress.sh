#!/bin/bash

cd /var/www/html

export PROPERDOCKER_ADMIN_USER=proper
export PROPERDOCKER_ADMIN_PASSWORD=$(pwgen 10 1)
export PROPERDOCKER_ADMIN_EMAIL="support@properdesign.rs"
export WPMDBP_LICENCE="b3ed61fe-2e1c-498a-807d-3c2407e5ad75"

# Install WordPress
echo "Running WP-CLI core install..."
wp core install --url="$VIRTUAL_HOST" --title="$PROPERDOCKER_NAME" --admin_user="$PROPERDOCKER_ADMIN_USER" --admin_password="$PROPERDOCKER_ADMIN_PASSWORD" --admin_email="$PROPERDOCKER_ADMIN_EMAIL";

# Delete some jazz that we don't need most of the time. This should really be done with --skip-plugins and --skip-themes or wp-cli.yml, but it no worky. Don't know why
echo "Deleting bum themes and plugins..."
wp plugin delete hello
wp plugin delete akismet
wp theme delete twentyfourteen
wp theme delete twentyfifteen
wp theme delete twentysixteen

# Install some jazz that we do want
## Migrate DB Pro and related bits
echo "Installing non-bum plugins..."
wp plugin install "https://deliciousbrains.com/dl/wp-migrate-db-pro-latest.zip?licence_key=b3ed61fe-2e1c-498a-807d-3c2407e5ad75&site_url="$SITE_URL
wp plugin install "https://deliciousbrains.com/dl/wp-migrate-db-pro-media-files-latest.zip?licence_key=b3ed61fe-2e1c-498a-807d-3c2407e5ad75&site_url="$SITE_URL
wp plugin install "https://deliciousbrains.com/dl/wp-migrate-db-pro-cli-latest.zip?licence_key=b3ed61fe-2e1c-498a-807d-3c2407e5ad75&site_url="$SITE_URL

## Advanced Custom Fields
wp plugin install "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=b3JkZXJfaWQ9MzMwMTJ8dHlwZT1kZXZlbG9wZXJ8ZGF0ZT0yMDE0LTA3LTA3IDE2OjI4OjI0"

#Do a plugin update
echo "Updating plugins..."
wp plugin update --all

echo "WordPress setup!"

echo "§====================================================="
echo "§  Site URL:               $VIRTUAL_HOST"
echo "§  Admin username:         $PROPERDOCKER_ADMIN_USER"
echo "§  Admin password:         $PROPERDOCKER_ADMIN_PASSWORD"
echo "§  Admin email:            $PROPERDOCKER_ADMIN_EMAIL"
echo "§====================================================="