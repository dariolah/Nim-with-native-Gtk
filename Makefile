resources = $(glib-compile-resources --sourcedir=. --generate-dependencies resources.xml)

all: libcapp.a nimgtk

libcapp.a: capp.c capp.h nimgtk-resources.c
	gcc -c -O2 -pipe -rdynamic -o capp.o capp.c $(shell pkg-config gtk+-3.0 --cflags)
	gcc -c -O2 -pipe -o nimgtk-resources.o nimgtk-resources.c $(shell pkg-config gtk+-3.0 --cflags)
	ar rcs libcapp.a capp.o nimgtk-resources.o

nimgtk: nimgtk.nim libcapp.a
	nim c -d:debug --debugger:native nimgtk.nim

nimgtk-resources.c: resources.xml $(resources)
	glib-compile-resources resources.xml --target=$@ --sourcedir=. --generate-source

clean:
	rm -f libcapp.a nimgtk *.o
