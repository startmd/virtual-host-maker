#!/bin/bash

# 1. Root Privilege Check
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run this script as root: sudo ./make_vhost.sh"
  exit
fi

echo "========================================="
echo "🌐 Apache Virtual Host Generator"
echo "========================================="

# 2. Gather Inputs
read -p "Enter the local domain name (e.g., myopia.test): " domain
read -p "Enter the project directory name (inside /var/www/html/): " raw_dir

# 3. Sanitize the Directory Input (Strips leading and trailing slashes)
# If you type "/myopia/", "myopia/", or "/myopia", it becomes just "myopia"
clean_dir=$(echo "$raw_dir" | sed -e 's/^\/*//' -e 's/\/*$//')
full_path="/var/www/html/$clean_dir"

# 4. Create the target directory if it doesn't exist yet
if [ ! -d "$full_path" ]; then
    mkdir -p "$full_path"
    # Optional: Give your user ownership so you can edit files without sudo
    chown -R $SUDO_USER:$SUDO_USER "$full_path"
    echo "  -> Created new directory: $full_path"
fi

# 5. Define the Apache Config Path
vhost_file="/etc/apache2/sites-available/$domain.conf"

# 6. Generate the Virtual Host Configuration
cat > "$vhost_file" <<EOF
<VirtualHost *:80>
    ServerName $domain
    DocumentRoot $full_path

    <Directory $full_path>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/${domain}_error.log
    CustomLog \${APACHE_LOG_DIR}/${domain}_access.log combined
</VirtualHost>
EOF
echo "  -> Created Apache config: $vhost_file"

# 7. Update /etc/hosts so your browser can find the local domain
if ! grep -q "$domain" /etc/hosts; then
    echo "127.0.0.1    $domain" >> /etc/hosts
    echo "  -> Added $domain to /etc/hosts"
else
    echo "  -> $domain already exists in /etc/hosts"
fi

# 8. Enable the site and restart Apache
a2ensite "$domain.conf" > /dev/null 2>&1
systemctl reload apache2

echo "========================================="
echo "✅ Success! http://$domain is live and pointing to $full_path"
