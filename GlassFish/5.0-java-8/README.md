# Базовый образ Glass Fish 5.0 c oracle-java-8

Собрать образ  
docker build -t glassfish-50-java-8 .

Запустить контейнер  
sudo docker run -p 4848:4848 -p 8080:8080 -p 8181:8181 \
 -e ADMIN_PASSWORD=root glassfish-50-java-8

где ADMIN_PASSWORD=root - пароль, который будет установлен пользователю admin 
сервера приложений Glass Fish 

Админка Glass Fish доступна по адресу https://localhost:4848/

