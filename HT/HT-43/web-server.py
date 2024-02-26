#!/usr/bin/python3


# Import the HTTP server class from the http.server module
from http.server import SimpleHTTPRequestHandler
import socketserver
from multiprocessing import Process
from urllib.parse import urlparse
import time

# Set the port you want the server to run on
PORT = 8000
processes = []

def loader():
    b = 0
    for i in range(0, 100):
        for ii in range(0, 100):
            b += 1
            time.sleep(0.0001)
    print(b)
    print("Done")


# Create a custom request handler by inheriting from SimpleHTTPRequestHandler
class MyHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        # Customize the response for GET requests
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        print(self.path)
        if self.path == "/health":
            self.wfile.write("Ok".encode("utf-8"))
        if self.path == "/api/test":
            p = Process(target=loader)
            p.start()
            processes.append(p)
            self.wfile.write(b"Started\n")
        if "/api/stop" in self.path:
            processes[0].terminate()
            processes[0].join()
            processes[0].close()
            processes.pop(0)
            


# Create an instance of the server with the custom handler
handler = MyHandler

# Set up the server with the specified port
httpd = socketserver.TCPServer(("", PORT), handler)

# Print a message indicating that the server is running
print(f"Serving on port {PORT}")

# Start the server
httpd.serve_forever()

