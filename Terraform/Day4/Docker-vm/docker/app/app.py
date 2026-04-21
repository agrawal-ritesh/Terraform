from http.server import SimpleHTTPRequestHandler, HTTPServer

class MyHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(b"Hello from Python Docker (No Flask)")

PORT = 3000

server = HTTPServer(("0.0.0.0", PORT), MyHandler)
print(f"Server running on port {PORT}")
server.serve_forever()