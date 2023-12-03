from http.server import BaseHTTPRequestHandler, HTTPServer
import http.client
from urllib.parse import urlparse, parse_qs
from datetime import datetime


class HttpGetHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        parsed_url = urlparse(self.path)
        query_params = parse_qs(parsed_url.query)

        with open('log.txt', 'a') as log_file:
            log_file.write(f"{datetime.now()} - GET Request: {query_params}\n")
        
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write('<html><head><meta charset="utf-8">'.encode())
        self.wfile.write('<title>HTTP-сервер.</title></head>'.encode())
        self.wfile.write('<body>Отримано GET-запит.</body></html>'.encode())
        
        
def run(port=8000):
    server_address = ('', port)
    httpd = HTTPServer(server_address, HttpGetHandler)
    try:
        print(f"Starting server on port {port}")
        httpd.serve_forever()
    except KeyboardInterrupt:
        httpd.server_close()
        print("Server stopped.")
        

def get_request():
    conn = http.client.HTTPConnection("localhost", 8000)
    conn.request("GET", "/?param1=value1&param2=value2")
    response = conn.getresponse()
    print(response.read().decode())     

if __name__ == '__main__':

    run(port=8000)
    get_request()
    