#include "ctflib.h"

int vasprintf(char **buf, const char *fmt, va_list args)
{
	int size = vsnprintf(NULL, 0, fmt, args);
	*buf = (char *)malloc(size + 1);
	(*buf)[size] = 0;

	return vsnprintf(*buf, size, fmt, args);
}

long sendAll(char *buf, size_t len) {
	size_t i = 0;
	DWORD size = 0;


	HANDLE hStdin, hStdout;

	hStdout = GetStdHandle(STD_OUTPUT_HANDLE);
	hStdin = GetStdHandle(STD_INPUT_HANDLE);

	while (len > i) {
		WriteFile(hStdout, buf + i, len - i, &size, NULL);
		if (size < 1)
			return -1;
		i += size;
	}

	return (int)i;
}

long sendMsg(char *msg) {
	return sendAll(msg, strlen(msg));
}


long sendMsgf(const char *format, ...) {
	long status = 0;
	va_list list;
	char *ptr = NULL;

	va_start(list, format);
	status = vasprintf(&ptr, format, list);
	va_end(list);

	if (status == -1)
		goto ret;

	status = sendMsg(ptr);

ret:
	free(ptr);
	return status;
}

long readAll(char *buf, size_t len) {
	DWORD count = 0;
	DWORD remaining = len;

	HANDLE hStdin, hStdout;

		hStdout = GetStdHandle(STD_OUTPUT_HANDLE);
		hStdin = GetStdHandle(STD_INPUT_HANDLE);


	if (len > 0) {
		while (remaining > 0) {
			ReadFile(hStdin, buf, remaining, &count, NULL);

			if (count == -1) {
				break;
			}

			remaining -= count;
		}
	}

	return len - remaining;
}

long readUntil(char *buf, size_t len, char sentinal) {
	char _buf;
	size_t i = 0;
	DWORD count;


	HANDLE hStdin, hStdout;

	hStdout = GetStdHandle(STD_OUTPUT_HANDLE);
	hStdin = GetStdHandle(STD_INPUT_HANDLE);

	if (len > 0) {
		for (i = 0; i < len; i++) {
			ReadFile(hStdin, &_buf, 1, &count, NULL);

			if (count == -1) {
				break;
			}

			buf[i] = _buf;

			if (_buf == sentinal)
				break;
		}
	}

	return i;
}



