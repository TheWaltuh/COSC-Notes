import socket

# make a port scanner

targetHost = input('What IP do you want to scan?  \n')
lowport = int(input("What is the lowest port to scan?  \n"))
highport = int(input("What is the highest port you want to scan?  \n"))



for port in range(lowport, highport + 1):

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(2.0)
    result = s.connect_ex((targetHost, port))
    if result == 0:
        print("Port " + str(port) + " is open.")
        s.close()


#192.168.0.187