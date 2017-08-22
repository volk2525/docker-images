#!/bin/sh
sudo docker run -p 4848:4848 -p 8080:8080 -p 8181:8181 \
 -e ADMIN_PASSWORD=admin app-server-fss
