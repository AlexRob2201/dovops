#!/usr/bin/python3

from http.server import BaseHTTPRequestHandler, HTTPServer
import os

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            self.send_response(200)
            self.send_header('Content-Type', 'text/plain; charset=utf-8')
            self.end_headers()
            self.wfile.write(bytes("hello", "UTF-8"))
        if self.path == '/health':
            statuses = {"check1": "Failed", "check2": "Failed", "check3": "Failed"}
            if os.path.isfile("/mydir/testfile1"):
                statuses["check1"] = "Ok"
            if os.path.isfile("/mydir/testfile2"):
                statuses["check2"] = "Ok"
            if os.path.isfile("/mydir/testfile3"):
                statuses["check3"] = "Ok"
            if statuses["check1"] == "Ok" and statuses["check2"] == "Ok" and statuses["check3"] == "Ok":
                self.send_response(200)
                self.send_header('Content-Type', 'text/plain; charset=utf-8')
                self.end_headers()
                self.wfile.write(bytes(f"{statuses}", "UTF-8"))
            else:
                self.send_response(404)
                self.send_header('Content-Type', 'text/plain; charset=utf-8')
                self.end_headers()
                self.wfile.write(bytes(f"{statuses}", "UTF-8"))

def run(server_class=HTTPServer, handler_class=SimpleHTTPRequestHandler, port=8080):
    server_address = ('0.0.0.0', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting httpd server on port {port}...')
    httpd.serve_forever()

if __name__ == '__main__':
    run()
