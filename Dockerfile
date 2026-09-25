FROM php:8.2-apache

# Install System dependencies & Python 3
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    libgomp1 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install PHP MySQL extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . /var/www/html/

# Setup Python virtual environment & install requirements
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt

# Copy and setup entrypoint script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose Render default port
EXPOSE 10000

CMD ["/start.sh"]
