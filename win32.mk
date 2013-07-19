
bin/win32/jar-launcher.exe: src/jar-launcher.cpp
	$(dir_guard)
	$(win32-compiler) src/jar-launcher.cpp \
		-static-libgcc -static-libstdc++ -L . \
		-o bin/win32/jar-launcher.exe