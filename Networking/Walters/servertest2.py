import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

port = 3369
host = socket.gethostbyname(socket.gethostname())

print (port, host)

sock.bind((host, port))
sock.listen()

while True: 
    validSocket, addr = sock.accept()
    validSocket.send("Hello, ".encode('utf-8') + str(addr).encode('utf-8') + "Thank you for connecting to-- ".encode('utf-8') + str(host).encode('utf-8'))
    validSocket.close()
