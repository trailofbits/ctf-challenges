Question Text: 
	Find the key!

Answer: 
	key{He may be angry all the time, but he's the only one that understand Windows DACLs}

To distribute: 
	greenhornd.exe

To launch:  
	Configure a Windows 8.1 server and launch the AppJailLauncher. Do not distribute the App Launcher, it should be exploitable locally without it.
	AppJailLauncher.exe /network /key:key /port:9998 /timeout:30 greenhornd.exe

To exploit (with int3s): 
	python x.py ip
