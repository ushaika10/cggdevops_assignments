#!/bin/bash

# Script to install Apache Tomcat as a service on a Linux VM

# Variables
TOMCAT_VERSION="10.1.15"  # Change this to the desired Tomcat version
TOMCAT_URL="https://downloads.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
INSTALL_DIR="/opt/tomcat"
SERVICE_USER="tomcat"

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Install required packages
echo "Installing required packages..."
apt-get update
apt-get install -y wget default-jdk

# Create a dedicated user for Tomcat
echo "Creating Tomcat user..."
useradd -r -m -d "$INSTALL_DIR" -s /bin/false "$SERVICE_USER"

# Download and extract Tomcat
echo "Downloading Tomcat ${TOMCAT_VERSION}..."
wget -O /tmp/apache-tomcat.tar.gz "$TOMCAT_URL"
if [ $? -ne 0 ]; then
  echo "Failed to download Tomcat. Please check the version and URL."
  exit 1
fi

echo "Extracting Tomcat to ${INSTALL_DIR}..."
mkdir -p "$INSTALL_DIR"
tar -xzf /tmp/apache-tomcat.tar.gz -C "$INSTALL_DIR" --strip-components=1
rm -f /tmp/apache-tomcat.tar.gz

# Set permissions
echo "Setting permissions..."
chown -R "$SERVICE_USER:$SERVICE_USER" "$INSTALL_DIR"
chmod -R u+x "$INSTALL_DIR"/bin

# Create a systemd service file
echo "Creating systemd service file..."
cat <<EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking
User=$SERVICE_USER
Group=$SERVICE_USER
Environment="JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:/bin/java::')"
Environment="CATALINA_PID=$INSTALL_DIR/tomcat.pid"
Environment="CATALINA_HOME=$INSTALL_DIR"
Environment="CATALINA_BASE=$INSTALL_DIR"
ExecStart=$INSTALL_DIR/bin/startup.sh
ExecStop=$INSTALL_DIR/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Tomcat
echo "Reloading systemd and starting Tomcat..."
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat

# Verify Tomcat is running
if systemctl is-active --quiet tomcat; then
  echo "Tomcat has been successfully installed and started."
  echo "You can access Tomcat at http://$(hostname -I | awk '{print $1}'):8080"
else
  echo "Tomcat failed to start. Please check the logs with 'journalctl -xe'."
  exit 1
fi
