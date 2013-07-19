#globals
default: all
freshen: clean all
clean: clean-specials
	rm -rf bin/* export_dir
clean-specials:
	rm -rf *.exe failure.log *.jar
freshen: clean all

#variables
linux-compiler=g++
win32-compiler=i686-w64-mingw32-g++ -mwindows
win64-compiler=x86_64-w64-mingw32-g++ -mwindows

dir_guard = @mkdir -p $(@D)

#groups
all: \
	bin/win32/jar-launcher.exe \
	bin/win64/jar-launcher.exe

#special
jar-launcher32.exe: bin/win32/jar-launcher.exe
	cp bin/win32/jar-launcher.exe jar-launcher32.exe

jar-launcher64.exe: bin/win64/jar-launcher.exe
	cp bin/win64/jar-launcher.exe jar-launcher64.exe

test: bin/linux/jar-launcher
	bin/linux/jar-launcher
test-win32: bin/win32/jar-launcher.exe
	wine bin/win32/jar-launcher.exe
test-win64: bin/win64/jar-launcher.exe
	wine bin/win64/jar-launcher.exe

export: jar-launcher32.exe jar-launcher64.exe
	rm -rf export_dir
	mkdir -p export_dir
	cp -fr data jar-launcher32.exe jar-launcher64.exe export_dir

#includes
include win32.mk
include win64.mk
include linux.mk
include test/test.mk
