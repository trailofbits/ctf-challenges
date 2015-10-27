// child.cpp : Defines the child process
//

#include "ctflib.h"

void *allocate_buffer(LPVOID ptr, DWORD size, DWORD prot, DWORD *out)
{
	*out = (DWORD)VirtualAlloc(ptr, size, MEM_COMMIT | MEM_RESERVE, prot);
	return (void *)*out;
}

void *my_memcpy(void *dst, void *src, size_t size)
{
	memcpy(dst, src, size);
	return dst;
}

void Vuln()
{
	struct {
		char buf[1024];
	} x;

	sendMsg("\n\nVULNERABLE FUNCTION\n"
		"-------------------\n"
		"Send me exactly 1024 characters (with some constraints).\n\n");

	readUntil((char *)&x.buf, 2048, '\n');



	if (x.buf[0] != 'C')
	if (x.buf[1] != 'S')
	if (x.buf[2] != 'A')
	if (x.buf[3] != 'W')
		exit(1);

	return;
}

void DebuggingHelp()
{

	sendMsg("\n\nDEBUGGING\n---------\n"
		"For debugging greenhornd.exe, we\'re going to use WinDbg. How exciting!\n\n"
		"To start, launch WinDbg (x86) and select File->Open Executable.\n"
		"In the Open Executable window, browse to where you have greenhornd.exe saved. You'll "
		"need to check the \"Debug child processes also\" checkbox and specify the correct start directory "
		"(wherever you saved greenhornd.exe).\n\n"
		"Here are some WinDbg commands:\n"
		"\tCTRL+BREAK - Break in (or click the Break in button)\n"
		"\tg - Go\n"
		"\tt - Single Step\n"
		"\tp - Single Step Over\n"
		"\tr - Register state\n"
		"\tdc [address or register] - dump memory by dwords with ascii output\n"
		"\tdb/dw/dd [address or register] - dump memory\n"
		"\tkb - extended stack trace\n"
		"\tbp [address] - Set a breakpoint\n"
		"\tbl - List breakpoints\n"
		"\tdt [type] [address or register] - Dump memory while applying a type (ex: dt _PEB 7ed1e000)\n"
		"\tlm - List loaded modules (libraries)\n"
		"\t!vprot [address] - Check the page permissions for a specified address\n\n"
		"For good debugging symbolyou'll want to type the following into the WinDbg Window:\n"
		"\t.sympath cache*c:\\MySymbols;srv*http://msdl.microsoft.com/download/symbols\n"
		"\t.reload /f\n"
		"WinDbg should download all the debugging symbols available and start using them right away.\n\n"
		"For more help, check out this cheat sheet: http://windbg.info/doc/1-common-cmds.html\n\n");

	return;
}

void StaticAnalysisHelp()
{
	char exepath[MAX_PATH + 1];
	GetModuleFileNameA(0, exepath, MAX_PATH);
	size_t slide = (size_t)GetModuleHandleA(exepath) - 0x00401000;

	size_t Challenge_Main_addr = (size_t)main - slide;
	size_t DebuggingHelp_addr = (size_t)DebuggingHelp - slide;

	sendMsgf("Static Analysis\n"
		"---------------\n"
		"Fire up IDA Free (or Pro) and load in this binary! You can ignore a lot of the setup functionas they deal with sandboxing this challenge.\n\n"
		"The functions of interest start at %08x.\n"
		"I'd start by checking all the stack variable sizes with alt+k!\n\n", Challenge_Main_addr
		);

	return;
}

void ASLR()
{
	DWORD out;
	char *exepath = (char *)allocate_buffer(NULL, MAX_PATH + 1, PAGE_READWRITE, &out);
	GetModuleFileNameA(0, exepath, MAX_PATH);
	size_t slide = (size_t)GetModuleHandleA(exepath) - 0x00400000;

	sendMsg("\n\nAddress Space Layout Randomization\n"
		"----------------------------------\n\n"
		"ASLR on Windows works a lot like it does on Linux. The big difference ion Windowthe executable itself always rebases. No need to specify -fPIE!\n"
		"Unlike on Linux, Windows executables don't realy on PIC for relocation. The dynamic loader actually parses out a PE section called '.reloc' and applies the ASLR "
		"delta directly to that (after fixing up page permissions).\n\n"
		"On Windows 8.1, nearly every executable and library on the entire system is ASLR-compatible and the dynamic loader rebases them all independently. For more reading on Windows ASLR, check out this presentation:  https://www.blackhat.com/presentations/bh-dc-07/Whitehouse/Presentation/bh-dc-07-Whitehouse.pdf\n\n");

	sendMsgf("Normally, you'd have to find an information disclosure to leak back program state (via an unitialized variable, a forced type confusion, or a use after free) to leak the ASLR slide.\n\n"
		"However, this is a greenhorn challenge, so your ASLR slide is: 0x%08x and the slide variable is stored at: 0x%08x.\n\n", slide, &slide);
	
	VirtualFree(exepath, MAX_PATH, MEM_DECOMMIT | MEM_RELEASE);

	return;
}

void sc()
{

	sendMsg("\n\nShellcode\n"
		"---------\n\n"
		"Shellcode on Windows is a little different than on Linux and FreeBSD. Shellcode rarely calls syscalls directly for two reasons: Microsoft renumbers them every service pack and "
		"the usermode libraries implement a lot more logic than their Linux counterparts.]n"
		"To deal with thiWindows shellcode generally resolves the addresses of functions in kernel32.dll dynamically via a method called a PEB Scandown.\n\n"
		"You'll probably need to implement a PEB scandown payload for this service. You can read an old Phrack article on it here: http://phrack.org/issues/62/7.html (section 2.b.iii).\n"
		"This may work also, but no guarentees: http://shell-storm.org/shellcode/files/shellcode-260.php.\n\n"
		"");

	return;
}

void NX()
{

	sendMsg("\n\nNX/DEP\n"
		"------\n\n"
		"There are a few techniques to defeat NX/DEP on Windows! The most popular routes are to call VirtualProtect or VirtualAlloc with PAGE_EXECUTE_READWRITE set for fwProtect.\n"
		"The only issue iyou need to have a reference to the function in kernel32 or have it convienently imported for you in something you have an ASLR leak to.\n\n"
		"This looks like a decent resource: http://blog.harmonysecurity.com/2010/04/little-return-oriented-exploitation-on.html\n\n"
		"You can also do something ugly like call WriteProcessMemory().\n\n");

	return;
}

volatile void q()
{
	sendMsg("Bye!\n");
}

/*
 * Challenge_Main()
 *   The socket handle is owned by the caller.
 */

int main(int argc, char **argv)
{
	(void)argc;
	(void)argv;

	volatile register void(*quit)();


	char buf[1024];

	setvbuf(stdout, NULL, _IONBF, 0);

	sendMsg("Wecome to the Greenhorn CSAW service!\n"
		"This service is a Windows 8.1 Pwnable! You're going to need a Windows 8.1 computer or VM to solve this one. "
		"If you don't have a Windows Key, I suggest using Amazon EC2: http://aws.amazon.com/windows/\n\n"
		"Windows Exploitation is new to a lot of you, so this is a tutorial service! To start, let's install some software you'll need to follow along:\n"
		"\tWindows SDK for the debugging tools (http://msdn.microsoft.com/en-us/windows/desktop/bg162891.aspx)\n"
		"\tMSYS for nice command line tools (http://www.mingw.org/wiki/MSYS)\n"
		"\tIDA Free (https://www.hex-rays.com/products/ida/support/download_freeware.shtml)\n"
		"\tNASM for Windows (http://www.nasm.us/pub/nasm/releasebuilds/2.11.05/win32/)\n\n"
		"To continue, you're going to need the password. You can get the password by running strings from minsys (strings - greenhorn.exe) or locate it in IDA.\n\n"
		"Password: ");
	int len = readUntil(buf, 1024, '\n');
	buf[len] = '\0';

	if (strncmp(buf, "GreenhornSecretPassword!!!", sizeof("GreenhornSecretPassword!!!")) != 0)
	{
		quit = NULL;
		sendMsg("Incorrect Password.\n");
		return 0;
	}

	quit = q;

	sendMsg("Password accepted.\n");

	while (true)
	{

		sendMsg("Greenhorn Menu:\n"
			"--------------\n"
			"\t(D)ebugging\n"
			"\t(S)tatic Analysis\n"
			"\tS(h)ellcode\n"
			"\t(A)SLR\n"
			"\t(N)X/DEP\n"
			"\t(V)ulnerability\n"
			"\t(Q)uit\n"
			"\nSelection: ");

		readUntil(buf, 2, '\n');
		buf[1] = '\0';

		switch (buf[0])
		{
		case 'D': case 'd':
			DebuggingHelp();
			break;
		case 'S': case 's':
			StaticAnalysisHelp();
			break;
		case 'H': case 'h':
			sc();
			break;
		case 'A': case 'a':
			ASLR();
			break;
		case 'N': case 'n':
			NX();
			break;
		case 'V': case 'v':
			Vuln();
			break;
		case 'Q': case 'q':
			__asm{
				mov eax, [quit]
				call eax
			};
			return 0;
		default:
			sendMsg("Invalid entry\n");
			break;
		}

	}

	return 0;
}