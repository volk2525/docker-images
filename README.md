
Просмотреть доступные локальные образы  
`$ docker images` 

Просмотреть запущенные контейнеры
`$ sudo docker container ls`

Получить консоль запущенного контейнера
`$ sudo docker exec -it fd4570593d98 bash`

Удалить ранее созданный образ
$ sudo docker image rm 235fd6900aa5

asadmin  set-log-levels org.springframework=FINEST
asadmin  set-log-levels java.util.logging.ConsoleHandler=FINEST
