import functools
import http.server
import os
import socket
import socketserver
import sys
import threading
import time
import webbrowser
from pathlib import Path

APP_DIR = Path(sys.executable).resolve().parent if getattr(sys, "frozen", False) else Path(__file__).resolve().parent
START_PORT = int(os.environ.get("PORT", "5520"))
HOST = "127.0.0.1"

class QuietHandler(http.server.SimpleHTTPRequestHandler):
    def log_message(self, format, *args):
        return

    def end_headers(self):
        self.send_header("Cache-Control", "no-store")
        super().end_headers()

class ReusableTCPServer(socketserver.TCPServer):
    allow_reuse_address = True

def find_free_port(start_port):
    for port in range(start_port, start_port + 30):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.settimeout(0.2)
            if sock.connect_ex((HOST, port)) != 0:
                return port
    raise RuntimeError("No free local port found.")

def open_app(url):
    edge_paths = [
        Path(os.environ.get("ProgramFiles(x86)", "")) / "Microsoft" / "Edge" / "Application" / "msedge.exe",
        Path(os.environ.get("ProgramFiles", "")) / "Microsoft" / "Edge" / "Application" / "msedge.exe",
    ]
    for edge in edge_paths:
        if edge.exists():
            os.startfile(str(edge), f'--app={url} --new-window')
            return
    webbrowser.open(url)

def main():
    port = find_free_port(START_PORT)
    handler = functools.partial(QuietHandler, directory=str(APP_DIR))

    with ReusableTCPServer((HOST, port), handler) as server:
        url = f"http://{HOST}:{port}/index.html"
        print("Albion Free Black Market Flips is running.")
        print(url)
        print("Keep this window open while using the app.")
        print("Close this window to stop the app.")

        threading.Thread(target=lambda: (time.sleep(0.5), open_app(url)), daemon=True).start()
        server.serve_forever()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass
    except Exception as exc:
        print(f"Could not start app: {exc}")
        input("Press Enter to close...")
        sys.exit(1)
