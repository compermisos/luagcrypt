LUA_VER     = 5.2
LUA         = lua$(LUA_VER)
LUA_DIR     = /usr/local
LUA_INCDIR  = $(LUA_DIR)/include/lua$(LUA_VER)

LUA_LIBDIR  = $(LUA_DIR)/lib/lua/$(LUA_VER)

CFLAGS      = -Wall -Wextra -Werror=implicit-function-declaration
CFLAGS     += -O2 -g -I$(LUA_INCDIR)
LIBFLAG     = -shared
LDFLAGS     = -lgcrypt -lgpg-error

luagcrypt.so: luagcrypt.c
	@if test ! -e $(LUA_INCDIR)/lua.h; then \
		echo Could not find lua.h at LUA_INCDIR=$(LUA_INCDIR); \
		exit 1; fi
	$(CC) $(CFLAGS) $(LIBFLAG) -o $@ $< -fPIC $(LDFLAGS)

check: luagcrypt.so
	$(LUA) luagcrypt_test.lua

.PHONY: clean install

clean:
	$(RM) luagcrypt.so

install: luagcrypt.so
	install -Dm755 luagcrypt.so $(DESTDIR)$(LUA_LIBDIR)/luagcrypt.so