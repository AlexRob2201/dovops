FROM python:3.12.2

# Встановлюємо залежності
RUN pip install --no-cache-dir \
    requests

# Додаємо сценарій Python у робочу директорію образу
COPY web.py /app/web.py

# Встановлюємо робочу директорію
WORKDIR /app
EXPOSE 8080

# Запускаємо сервер Python
CMD ["python", "-u", "web.py"]