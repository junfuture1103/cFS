import socket
import struct

def main():
    host = '127.0.0.1'
    port = 3000

    # Create a socket object
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Bind to the port
    serversocket.bind((host, port))

    # Listen for incoming connections (backlog of 5)
    serversocket.listen(5)
    print(f"Server listening on {host}:{port}")

    while True:
        # Establish a connection
        clientsocket, addr = serversocket.accept()
        print(f"Got a connection from {addr}")

        try:
            # Receive MsgSize (4 bytes)
            raw_size = clientsocket.recv(4)
            if len(raw_size) < 4:
                print("Failed to receive MsgSize")
                clientsocket.close()
                continue

            # Unpack MsgSize
            MsgSize = struct.unpack('!I', raw_size)[0]
            print(f"Received MsgSize: {MsgSize}")

            # Receive the message data
            data = b''
            while len(data) < MsgSize:
                packet = clientsocket.recv(MsgSize - len(data))
                if not packet:
                    break
                data += packet

            if len(data) < MsgSize:
                print("Failed to receive complete message data")
                clientsocket.close()
                continue

            # Log the data in the desired format
            print("Received Data:")
            for i in range(0, len(data), 8):
                line_data = data[i:i+8]
                hex_line = ' '.join(f"0x{byte:02X}" for byte in line_data)
                print(hex_line)

            print(hex(data[0]))

            if data[0] == 0xAA:
                print("======START INGEST PACKET PROCESS ======")

            # if(hex(data[0]) == 0xFF):
            #     print("======ENDINGEST PACKET PROCESS ======")
                
                
        finally:
            clientsocket.close()
            print("Connection closed\n\n")

if __name__ == "__main__":
    main()
