CP=cp -p
MKDIR=mkdir -p

DESTDIR=
PREFIX=/usr/local
DATADIR=${PREFIX}/share
MOD_DIR=${DATADIR}/lua/$(shell pkg-config --variable=V lua)

check:
	lunit abc_standalone_testcase.lua
	lunit abc_loop_testcase.lua

install:
	${MKDIR} ${DESTDIR}${MOD_DIR}
	${CP} abc.lua ${DESTDIR}${MOD_DIR}

