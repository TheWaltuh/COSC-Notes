import socket

targetserver = '192.168.0.187'
targetport = 3369

socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

socket.connect((targetserver, targetport))
text = input("What message do you want to send?  \n")
socket.send(text.encode('utf-8'))
message = socket.recv(1024).decode('utf-8')
print(message)