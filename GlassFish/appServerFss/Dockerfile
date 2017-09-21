
FROM glassfish-50-java-8

# Maintainer
MAINTAINER Konstantin Volkov<kvolkov@ibs.ru>

COPY ojdbc8_g-12.2.0.1.jar /glassfish5/glassfish/domains/domain1/lib/
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 4848 8080 8181 9009

CMD ["asadmin", "start-domain", "-v", "--debug"]
