FROM dynamicwit/clearscale-andrews:latest
ENV APP=/var/www/html/
WORKDIR $APP
COPY . $APP
RUN ln -sf /dev/stdout /var/log/apache2/access.log
RUN ln -sf /dev/stderr /var/log/apache2/error.log
RUN ln -sf /dev/stdout /var/log/apache2/other_vhosts_access.log
ENTRYPOINT ["./entrypoint"]
CMD ["apachectl", "-D", "FOREGROUND"]
