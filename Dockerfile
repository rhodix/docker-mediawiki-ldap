FROM kristophjunge/mediawiki:latest

# Install dependencies (ldap) 
RUN apt-get update && apt-get -y install libldap-dev \
&& ln -sf /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
&& docker-php-ext-install ldap \
&& apt-get clean

# Install application from src/ directory:
# COPY src/ /var/www/html/

# Extentions: 
COPY src/extensions/ /var/www/mediawiki/extensions/

# Custom entrypoint:
COPY src/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 0755 /docker-entrypoint.sh

VOLUME ["/var/cache/nginx", "/data", "/images", "/srv"]

