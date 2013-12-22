//standard library includes
#include <windows.h>
#include <cstdio>
#include <cassert>
//SimpleIni includes
#include "../lib/simpleini/SimpleIni.h"

int APIENTRY WinMain(
		HINSTANCE hInstance,
		HINSTANCE hPrevInstance,
		LPTSTR    lpCmdLine,
		int       nCmdShow){
	//load ini file
	//printf("Loading config file\n");
	CSimpleIni ini;
	ini.SetUnicode();
	ini.LoadFile("config/jar-launcher.ini");

	//load keys
	//printf("Loading keys\n");
	const char* jar =
		ini.GetValue("Launcher", "jar", "xls2csv.jar");
	const char* mem_min =
		ini.GetValue("Launcher", "jvm_memory_min", "256m");
	const char* mem_max =
		ini.GetValue("Launcher", "jvm_memory_max", "512m");

	//put together command string
	char* command = new char[256];
	int command_length = sprintf( command,
		"java -Xms%s -Xmx%s -jar %s",
		mem_min, mem_max, jar);
	assert( command_length > 0 );
	
	//setup call
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	ZeroMemory( &si, sizeof(si) );
	si.cb = sizeof(si);
	ZeroMemory( &pi, sizeof(pi) );
	
	//make call
	//printf("Launching %s\n", jar);
	//execl( command, NULL);
	//int result = system(command);
	CreateProcess(
		NULL,   // No module name (use command line)
		command,// Command line
		NULL,   // Process handle not inheritable
		NULL,   // Thread handle not inheritable
		FALSE,  // Set handle inheritance to FALSE
		CREATE_NO_WINDOW,      // No creation flags
		NULL,   // Use parent's environment block
		NULL,   // Use parent's starting directory 
		&si,    // Pointer to STARTUPINFO structure
		&pi);

	//clean up
	CloseHandle( pi.hProcess );
	CloseHandle( pi.hThread );
	delete[] command;
	return 0;}
