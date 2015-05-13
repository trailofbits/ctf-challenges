# Greenhorn
[![Build status](https://ci.appveyor.com/api/projects/status/x3hclir2mwp89yjt?svg=true)](https://ci.appveyor.com/project/dguido/greenhorn)

Greenhorn is a Windows Pwnable released during CSAW Quals 2014. It's meant to be an introduction to modern Windows binary exploitation.

* Question Text: Find the key!
* Answer: key{He may be angry all the time, but he's the only one that understand Windows DACLs}
* To Distribute: greenhornd.exe
* To launch:  
  * Configure a Windows 8.1 server and launch the AppJailLauncher.
  * Do not distribute the App Launcher, it should be exploitable locally without it.
  * Run: AppJailLauncher.exe /network /key:key /port:9998 /timeout:30 greenhornd.exe

* To exploit (with int3s): python x.py ip
