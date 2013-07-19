
bin/linux/jar-launcher: src/jar-launcher.cpp
	$(dir_guard)
	$(linux-compiler) src/jar-launcher.cpp \
		-o bin/linux/jar-launcher