FROM dynamicwit/clearscale-andrews:latest
ENV APP=/var/www/html/
WORKDIR $APP
COPY . $APP
ENTRYPOINT ["./entrypoint"]
CMD ["apachectl", "-D", "FOREGROUND"]
