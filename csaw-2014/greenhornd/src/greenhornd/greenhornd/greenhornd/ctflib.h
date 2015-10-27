#pragma once

#define _CRT_SECURE_NO_WARNINGS true

#include <tchar.h>

#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
#include <WinSock2.h>
#include <Ws2tcpip.h>
#include <AclAPI.h>
#include <UserEnv.h>
#include <sddl.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdarg.h>
#include <string.h>

int main(int, char **);

int vasprintf(char **buf, const char *fmt, va_list args);
long sendAll(char *buf, size_t len);
long sendMsg(char *msg);
long sendMsgf(const char *format, ...);
long readAll(char *buf, size_t len);
long readUntil(char *buf, size_t len, char sentinal);


