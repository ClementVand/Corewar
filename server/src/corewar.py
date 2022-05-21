##
## EPITECH PROJECT, 2022
## COREWAR
## File description:
## COREWAR SERVER
##

import os
import time

from .matchmaking import *

SEPARATOR = "<SEPARATOR>"
ERROR = "<ERROR>"
COMPILED = "<COMPILED>"
GOTCHA = "<GOTCHA>"
BUFFER_SIZE = 1024


def queueUp(client_socket, address, filename, uuid):
    try:
        """DOES CHAMPION EXIST IN DB?"""
        if not os.path.exists(f"cor_file/{filename}.{uuid}"):
            client_socket.send("<NOCHAMP>".encode())
            client_socket.send("<CANCELQ>".encode())
            client_socket.close()
            return

        """TELLS THE SERVER IS READY"""
        client_socket.send(GOTCHA.encode())
        PLAYERS.append({'UUID': uuid, 'champion': filename, 'Socket': client_socket, 'hasFought': False})
        while True:
            is_connected = False
            client_socket.send("<WAITING>".encode())
            for i in range(len(PLAYERS)):
                if PLAYERS[i]['UUID'] == uuid:
                    is_connected = True
                    break
            if not is_connected:
                client_socket.send("<CANCELQ>".encode())
                client_socket.close()
                return
            time.sleep(2)
    except:
        """CLOSE SOCKET ON ERROR"""
        print(f"[SERVER] <!!!> ERROR WITH: {address}...")
        client_socket.close()


def cancelQueue(client_socket, address, uuid):
    try:
        """TELLS THE SERVER IS READY"""
        for i in range(len(PLAYERS)):
            if PLAYERS[i]['UUID'] == uuid:
                PLAYERS.pop(i)
                break
        print(f"[SERVER] {uuid} removed from the queue.")
    except:
        """CLOSE SOCKET ON ERROR"""
        print(f"[SERVER] <!!!> ERROR WITH: {address}...")
        client_socket.close()
