FROM ubuntu:22.04

# Оновлення пакетів та установка клієнта MySQL
RUN apt update && \
    apt install python3-pip -y && \
    pip3 install mysql-connector-python && \
    apt install -y mysql-client

# Створення користувача mysql та копіювання файлу app.py
RUN useradd -ms /bin/bash mysql
COPY --chown=mysql:mysql app.py /home/mysql/app.py
RUN chmod 555 /home/mysql/app.py
RUN chown -R mysql:mysql /home/mysql

# Встановлення mysql в якості користувача, з якого буде запущений контейнер
USER mysql

# Встановлення app.py як точки входу для контейнера
ENTRYPOINT ["python3", "/home/mysql/app.py"]

# Команда ENTRYPOINT з виконанням безкінечного циклу
#ENTRYPOINT ["bash", "-c", "while true; do sleep 1; done"]
