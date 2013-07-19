
bin/win64/jar-launcher.exe: src/jar-launcher.cpp
	$(dir_guard)
	$(win64-compiler) src/jar-launcher.cpp \
		-static-libgcc -static-libstdc++ -L . \
		-o bin/win64/jar-launcher.exe