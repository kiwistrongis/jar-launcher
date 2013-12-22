#globals
default: build
freshen: clean build
clean: clean-specials
	rm -rf bin/* export_dir
clean-specials:
	rm -rf *.exe failure.log *.jar
freshen: clean build

#variables
win32-compiler=i686-w64-mingw32-g++ -mwindows
win64-compiler=x86_64-w64-mingw32-g++ -mwindows

dir_guard = @mkdir -p $(@D)

#groups
build: \
	jar-launcher32.exe \
	jar-launcher64.exe

#commands
export: jar-launcher32.exe jar-launcher64.exe
	rm -rf export_dir
	mkdir -p export_dir
	cp -fr \
		config \
		jar-launcher32.exe \
		jar-launcher64.exe \
		export_dir

git-prepare:
	git add -u
	git add -A

#tests
test-win32: bin/win32/jar-launcher.exe \
		test/test.jar
	wine bin/win32/jar-launcher.exe
test-win64: bin/win64/jar-launcher.exe \
		test/test.jar
	wine bin/win64/jar-launcher.exe

#build commands
bin/win32/jar-launcher.exe: src/jar-launcher.cpp
	$(dir_guard)
	$(win32-compiler) src/jar-launcher.cpp \
		-static-libgcc -static-libstdc++ -L . \
		-o bin/win32/jar-launcher.exe
jar-launcher32.exe: bin/win32/jar-launcher.exe
	cp bin/win32/jar-launcher.exe jar-launcher32.exe

bin/win64/jar-launcher.exe: src/jar-launcher.cpp
	$(dir_guard)
	$(win64-compiler) src/jar-launcher.cpp \
		-static-libgcc -static-libstdc++ -L . \
		-o bin/win64/jar-launcher.exe
jar-launcher64.exe: bin/win64/jar-launcher.exe
	cp bin/win64/jar-launcher.exe jar-launcher64.exe

test/test.jar: test/test.class
	cd test && \
	jar cfe test.jar test test.class
test/test.class: test/test.java
	javac test/test.java -d test