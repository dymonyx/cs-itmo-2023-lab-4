# Лабораторная работа 4
## Работа с Docker и dockerfiles
> [!NOTE]
> Предварительно был установлен Docker
> 
> ![docker](/Report/Screenshot-0.png)

## Cowsay
### Создание докерфайла
Был создан Dockerfile, в котором указывается образ `FROM linux:latest`, на основе которого будет создан образ докерфайла, и  команды, которые необходимо запустить с помощью `RUN` (обновляем пакетный менеджер и устаналиваем cowsay)

> ![dockerfile1](/Report/Screenshot-1.png)

### Запуск сборки образа и создание контейнера на его основе с передачей команды запуска `/usr/games/cowsay` и команды `"Моо"`.
> ![старт](/Report/Screenshot-2.png)

### Cоздание еще одного контейнера на основе cowsay
С помощью `docker run -it cowsay` создаем новый контейнер с доступом в его терминал, откуда и запускаем такую же команду `/usr/games/cowsay "Моо"`.

> ![старт1](/Report/Screenshot-3.png)

## Aafire
### Создание докерфайла
Был создан Dockerfile, в котором указывается образ `FROM linux:latest`, на основе которого будет создан образ докерфайла, и  команды, которые необходимо запустить с помощью `RUN` (обновляем пакетный менеджер и устаналиваем пакет libaa-bin (с опцией  -y, так как при установке пакета запросят yes/no для продолжения установки)

> ![dockerfile1](/Report/Screenshot-4.png)

### Сборка образа и запуск контейнера
> [!NOTE]
> Предварительно пакет libaa-bin был установлен на хост машину, и с помощью команды `find / -name aafire` мы узнали путь к aafire
Запускаем контейнер сразу с передачей команды `/usr/bin/aafire`
> 
> ![NEW_START](/Report/Screenshot-5.png)

> [!CAUTION] 
> #### Появляется ошибка
> ![mistake](/Report/Screenshot-20.png)
> 
> Чтобы её исправить, гуглим проблему и узнаем, что нужно установить переменную окрущения `TERM` с указанием терминала, который мы хотим использовать (`xterm`). Cделать это можно с помощью инструкции ENV докерфайла, которая как раз и устанавливает переменные окружения.
> 
> ![mistake](/Report/Screenshot-21.png)
> ![mistake](/Report/Screenshot-22.png)

### Создание нового образа
Изменяем прошлый докерфайл, устанавливая переменную окружения, сохраняем его.

> ![dockerfilenew](/Report/Screenshot-6.png)

Удаляем прошлый образ с помощью команды `docker image rm aafire`

> ![dockerfilenew](/Report/Screenshot-7.png)

Запускаем сборку образа на основе исправленного докерфайла

> ![dockerfilenew](/Report/Screenshot-8.png)

### Запуск контейнера с aafire

Создаем и сразу запускаем контейнер, передаем в него команду по запуску aafire `/usr/bin/aafire`. Открываем второй терминал и отслеживаем с помощью `docker ps` наш запущенный контейнер.

> ![dockerfilenew](/Report/Screenshot-9.png)

> ![dockerfilenew](/Report/Screenshot-10.png)

Останавливаем контейнер через `docker stop beautiful_brahmagupta` по его названию.

> ![dockerfilenew](/Report/Screenshot-11.png)

> [!TIP]
> Можем проверить еще раз, что наш контейнер работает исправно с помощью `start -i beautiful_brahmagupta`.
> ![dockerfilenew](/Report/Screenshot-12.png)
> ![dockerfilenew](/Report/Screenshot-13.png)

### Устанавливаем сеть между двумя контейнерами
#### Подготовка
Для этого изменим докерфайл, добавив в него команду по установке пакета `iputils-ping`, чтобы воспользоваться командой `ping`.

> ![dockerfilenew](/Report/Screenshot-14.png)

Запускаем сборку образа на основе измененного докерфайла.

> ![dockerfilenew](/Report/Screenshot-15.png)

#### Создаем контейнеры и подключаем их к одной сети

В двух терминалах создаем и запускаем по контейнеру (с доступом в их терминалы `-it`). В третьем терминале:
- отслеживаем названия контейнеров
- создаем сеть `newNetwork`
- подключаем к сети контейнеры

> ![dockerfilenew](/Report/Screenshot-17.png)

В первом терминале вызываем команду `docker network inspect newNetwork`, чтобы узнать айпи адреса наших контейнеров. В терминалах контейнеров запускаем aafire с помощью `/usr/bin/aafire`

> ![dockerfilenew](/Report/Screenshot-18.png)

#### Тестируем соединение
IP контейнера reverent_bardeen - 172.19.0.3
IP контейнера sad_murdock - 172.19.0.2

В третьем терминале запускаем команду `docker exec -it reverent_bardeen ping 172.19.0.2`. Видим, что пакеты доставлены => cоединение есть. 
Аналогично проверяем соединение от второго контейнера к первому.


> ![dockerfilenew](/Report/Screenshot-19.png)

> Полезные источники:
> - https://timeweb.com/ru/community/articles/osnovnye-komandy-docker
> - https://tproger.ru/translations/docker-instuction
> - https://qaa-engineer.ru/kak-proverit-dostupnost-docker-kontejnera-iz-drugogo-kontejnera/
