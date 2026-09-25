#!/bin/bash
set -e

# Set default PORT if not provided by Render
PORT="${PORT:-10000}"

# Configure Apache to listen on $PORT
sed -i "s/Listen 80/Listen ${PORT}/g" /etc/apache2/ports.conf
sed -i "s/:80>/:${PORT}>/g" /etc/apache2/sites-available/000-default.conf

# Start Flask API backend via Gunicorn on 127.0.0.1:8800
echo "Starting Flask API backend with Gunicorn..."
/opt/venv/bin/gunicorn --bind 127.0.0.1:8800 --workers 2 --timeout 120 app:app &

# Start Apache web server in foreground
echo "Starting Apache Web Server on port ${PORT}..."
exec apache2-foreground
