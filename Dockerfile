FROM conetix/wordpress-with-wp-cli

RUN apt-get update
RUN apt-get install pwgen unzip

# Cleanup
#RUN apt-get clean

ADD ./scripts /scripts
RUN usermod -u 1000 www-data 

# Remove plugins and themes that we don't want
RUN rm -Rf /usr/src/wordpress/wp-content/themes/twentyfourteen \
  /usr/src/wordpress/wp-content/themes/twentyfifteen \
  /usr/src/wordpress/wp-content/plugins/*

# Add some plugins that we want
WORKDIR /usr/src/wordpress/wp-content/plugins/
RUN curl -Lo plugin.zip "https://deliciousbrains.com/dl/wp-migrate-db-pro-latest.zip?licence_key=b3ed61fe-2e1c-498a-807d-3c2407e5ad75&site_url=localhost"
RUN unzip plugin.zip
RUN rm plugin.zip

WORKDIR /var/www/html

ENTRYPOINT ["/scripts/proper-entrypoint.sh"]
CMD ["apache2-foreground"]