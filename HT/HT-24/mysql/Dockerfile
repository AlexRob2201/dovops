# Використовуємо офіційний образ MySQL або MariaDB
FROM mysql:latest
# або FROM mariadb:latest, залежно від вашого вибору

# Копіюємо скрипт ініціалізації бази даних у контейнер
#COPY init.sql /docker-entrypoint-initdb.d/

# Якщо вам потрібно сконфігурувати базу даних, можете скопіювати свій файл конфігурації тут і встановити його
#COPY my.cnf /etc/mysql/my.cnf

# Встановлюємо змінні середовища, якщо вони необхідні для конфігурації бази даних
ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_DATABASE=app


