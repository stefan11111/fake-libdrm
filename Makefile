.POSIX:

XCFLAGS = ${CPPFLAGS} ${CFLAGS} -nostdlib -std=c99 -fPIC -pthread -D_XOPEN_SOURCE=700 \
		  -Wall -Wextra -Wpedantic \
		  -Wno-unused-parameter
XLDFLAGS = ${LDFLAGS} -shared -Wl,-soname,libdrm.so.2

LIBDIR ?= /lib64

OBJ = libdrm.o

all: libdrm.so.2.0.0

.c.o:
	${CC} ${XCFLAGS} -c -o $@ $<

libdrm.so.2.0.0: ${OBJ}
	${CC} ${XCFLAGS} -o $@ ${OBJ} ${XLDFLAGS}

install: libdrm.so.2.0.0
	mkdir -p ${DESTDIR}/usr${LIBDIR}
	cp -f libdrm.so.2.0.0 ${DESTDIR}/usr${LIBDIR}/libdrm.so.2.0.0
	ln -rsf ${DESTDIR}/usr${LIBDIR}/libdrm.so.2.0.0 ${DESTDIR}/usr${LIBDIR}/libdrm.so.2
	ln -rsf ${DESTDIR}/usr${LIBDIR}/libdrm.so.2 ${DESTDIR}/usr${LIBDIR}/libdrm.so

uninstall:
	rm -f ${DESTDIR}/usr${LIBDIR}/libdrm.so.2.0.0 ${DESTDIR}/usr${LIBDIR}/libdrm.so.2 ${DESTDIR}/usr${LIBDIR}/libdrm.so
clean:
	rm -f libdrm.so.2.0.0 ${OBJ}

.PHONY: all clean install uninstall
