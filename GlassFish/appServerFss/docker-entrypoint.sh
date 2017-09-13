#!/bin/bash
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 
# Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
if [[ -z $ADMIN_PASSWORD ]]; then
	ADMIN_PASSWORD=$(date| md5sum | fold -w 8 | head -n 1)
	echo "##########GENERATED ADMIN PASSWORD: $ADMIN_PASSWORD  ##########"
fi
echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd
echo "AS_ADMIN_NEWPASSWORD=${ADMIN_PASSWORD}" >> /tmp/glassfishpwd
asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name domain1
asadmin start-domain
echo "AS_ADMIN_PASSWORD=${ADMIN_PASSWORD}" > /tmp/glassfishpwd

# в соответствии с https://docs.oracle.com/cd/E19879-01/820-4335/gicbh/index.html
# https://docs.oracle.com/cd/E19316-01/820-4335/gibzk/index.html
# создадим пулы и создадим-jndi ресурсы
asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-connection-pool \
  --datasourceclassname oracle.jdbc.pool.OracleDataSource \
  --restype javax.sql.DataSource \
  --property user=FSS_CR_NSPZ:password=Manager1:url="jdbc\:oracle\:thin\:@217.74.37.141\:1521\:FSSDEV" \
  --idletimeout 300 \
  --maxpoolsize 32 \
  --maxwait 5000 \
  --statementtimeout 30 \
  --steadypoolsize 8 \
  --validationmethod custom-validation \
  --validationclassname org.glassfish.api.jdbc.validation.OracleConnectionValidation \
  --isconnectvalidatereq true \
  FSS_CR_NSPZ

asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-resource \
  --connectionpoolid FSS_CR_NSPZ jdbc/FSS_CR_NSPZ

asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-connection-pool \
  --datasourceclassname oracle.jdbc.pool.OracleDataSource \
  --restype javax.sql.DataSource \
  --property user=FSS_CR_SKL:password=Manager1:url="jdbc\:oracle\:thin\:@217.74.37.141\:1521\:FSSDEV" \
  FSS_CR_SKL
asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-resource \
  --connectionpoolid FSS_CR_SKL jdbc/FSS_CR_SKL

asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-connection-pool \
  --datasourceclassname oracle.jdbc.pool.OracleDataSource \
  --restype javax.sql.DataSource \
  --property user=FSS_CR_NSI:password=Manager1:url="jdbc\:oracle\:thin\:@217.74.37.141\:1521\:FSSDEV" \
  FSS_CR_NSI
asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-resource \
  --connectionpoolid FSS_CR_NSI jdbc/FSS_CR_NSI

asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-connection-pool \
  --datasourceclassname oracle.jdbc.pool.OracleDataSource \
  --restype javax.sql.DataSource \
  --property user=FSS_CR_PERSONS:password=Manager1:url="jdbc\:oracle\:thin\:@217.74.37.141\:1521\:FSSDEV" \
  FSS_CR_PERSONS
asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-resource \
  --connectionpoolid FSS_CR_PERSONS jdbc/FSS_CR_PERSONS

asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-connection-pool \
  --datasourceclassname oracle.jdbc.pool.OracleDataSource \
  --restype javax.sql.DataSource \
  --property user=FSS_CR_TSR:password=Manager1:url="jdbc\:oracle\:thin\:@217.74.37.141\:1521\:FSSDEV" \
  FSS_CR_TSR
asadmin --user=admin --passwordfile=/tmp/glassfishpwd create-jdbc-resource \
  --connectionpoolid FSS_CR_TSR jdbc/FSS_CR_TSR

# тестовый пользователь на период дебага
asadmin create-jvm-options -Dibs.util.security.hardcoded.userid=48795
asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin
asadmin --user=admin stop-domain
rm /tmp/glassfishpwd
exec "$@"
