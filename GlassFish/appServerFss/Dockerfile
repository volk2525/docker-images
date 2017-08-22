
FROM glassfish-412-java-8

# Maintainer
MAINTAINER Konstantin Volkov<kvolkov@ibs.ru>

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["asadmin", "start-domain", "-v"]
