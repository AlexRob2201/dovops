FROM ubuntu:latest

RUN apt update && apt install python3 -y
COPY web-server.py /

ENTRYPOINT ["/usr/bin/python3", "/web-server.py"]


