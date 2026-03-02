# Apache Virtual Host Generator (make_vhost.sh)

A lightweight, interactive bash script for Debian/Ubuntu-based Linux distributions (including Linux Mint) that instantly generates Apache virtual hosts, handles directory creation, sets up local DNS routing, and reloads your web server in seconds.

Perfect for PHP developers, frontend engineers, and anyone who needs to rapidly spin up local testing environments without wrestling with configuration files and permission errors.

## ✨ Features

- **Interactive Prompts:** Just type your desired local domain and target folder; the script handles the rest.

- **Smart Path Sanitization:** Forgiving input handling automatically strips accidental leading or trailing slashes (e.g., typing /myproject/ is safely converted to myproject).

- **Auto-Provisioning:** If your project directory doesn't exist yet, it creates it and assigns ownership back to your standard user account so you aren't locked out by root.

- **/etc/hosts Injection:** Automatically routes your new .test or .local domain to 127.0.0.1 so your browser can instantly resolve it.

- **Safe Reloading:** Gracefully enables the site via a2ensite and reloads Apache2 without dropping active connections.

## 📋 Prerequisites

- A Debian/Ubuntu-based Linux distribution (Ubuntu, Linux Mint, Pop!_OS, etc.)

- Apache2 installed and running

- sudo privileges

## 🚀 Installation

Download or clone the script to your machine. Or just copy the following command in your terminal:
```
curl -O [https://raw.githubusercontent.com/startmd/virtual-host-maker/main/make_vhost.sh](https://raw.githubusercontent.com/startmd/virtual-host-maker/main/make_vhost.sh)
```

Make the script executable:
```
chmod +x make_vhost.sh
```

*(Optional) Move it to your local bin so you can run it from anywhere:*
```
sudo mv make_vhost.sh /usr/local/bin/make_vhost
```

## 💻 Usage

Run the script with root privileges:
```
sudo ./make_vhost.sh
```

*(Or just sudo make_vhost if you moved it to your bin).*

### Example Walkthrough

The script will prompt you for two things:

The local domain name: (e.g., myproject.test)

The project directory: (e.g., myproject). Note: It assumes your web root is /var/www/html/. You only need to type the subfolder name.
```
=========================================
🌐 Apache Virtual Host Generator
=========================================
Enter the local domain name (e.g., myopia.test): app.test
Enter the project directory name (inside /var/www/html/): /app_v2/
  -> Created new directory: /var/www/html/app_v2
  -> Created Apache config: /etc/apache2/sites-available/app.test.conf
  -> Added app.test to /etc/hosts
Enabling site app.test.
To activate the new configuration, you need to run:
  systemctl reload apache2
=========================================
✅ Success! [http://app.test](http://app.test) is live and pointing to /var/www/html/app_v2
```

## 🛠️ What it does under the hood (Documentation)

When you execute the script, it performs the following operations:

- **Root Check:** Verifies you are running the script with sudo.

- **Sanitization:** Uses sed to clean your directory input, ensuring clean path structures.

- **Directory & Permissions:** Creates /var/www/html/[your_directory] if missing. It uses $SUDO_USER to ensure the directory is owned by your actual user account, preventing standard Apache www-data lockout issues.

- **VHost Config:** Generates a standard block in /etc/apache2/sites-available/[domain].conf with AllowOverride All enabled (crucial for framework .htaccess routing).

- **DNS Routing:** Appends 127.0.0.1 [domain] to your /etc/hosts file (skips if it already exists).

- **Execution:** Runs a2ensite and systemctl reload apache2 to bring the environment online immediately.

## Available For Hire

I am an independent freelance programmer with experience in building and deployment of both CMS and Business Management Tools. With the power of AI, and my working experience I can help you get up and running with the following within a couple of days:

- **Fast and Secure Frontend** - Using popular and standard industry tools for your frontend needs, including but not limited to: Bootstrap, Foundation, Tailwind, React, Vue, Alpine, Jquery
- **Industry Standard Coding Practices** - So that anyone can come in and easily make additions and changes as needed - **especially AI**
- **On-Time Delivery** - Be rest assured, with my experience coupled with power of AI, I can get you up and running with your requirement in no time at all!

