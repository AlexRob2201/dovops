from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse, parse_qs
from datetime import datetime

class GetHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed_url = urlparse(self.path)
        query_params = parse_qs(parsed_url.query)

        if parsed_url.path == '/favicon.ico':
            return

        print(f"GET Request: {query_params}")

        # Записати параметри у файл
        with open('log.txt', 'a') as log_file:
            log_file.write(f"{datetime.now()} - GET Request: {query_params}\n")

        # Відправте відповідь клієнту
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write('<html><head><meta charset="utf-8">'.encode())
        self.wfile.write('<title>HTTP-сервер</title></head>'.encode())
        self.wfile.write('<body>Отримано GET-запит.</body></html>'.encode())
        

if __name__ == '__main__':
    port = 8000
    server_address = ('', port)

    httpd = HTTPServer(server_address, GetHandler)
    print(f"Server started on port {port}")

    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        httpd.server_close()
        print("Server stopped.")
