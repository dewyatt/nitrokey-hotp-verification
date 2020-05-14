SRCDIR=.

SRC:= \
	$(SRCDIR)/structs.h \
	$(SRCDIR)/crc32.c \
	$(SRCDIR)/crc32.h \
	$(SRCDIR)/device.c \
	$(SRCDIR)/device.h \
	$(SRCDIR)/operations.c \
	$(SRCDIR)/operations.h \
	$(SRCDIR)/dev_commands.c \
	$(SRCDIR)/dev_commands.h \
	$(SRCDIR)/base32.c \
	$(SRCDIR)/base32.h \
	$(SRCDIR)/command_id.h \
	$(SRCDIR)/random_data.c \
	$(SRCDIR)/random_data.h \
	$(SRCDIR)/min.c \
	$(SRCDIR)/min.h \
	$(SRCDIR)/settings.h \
	$(SRCDIR)/version.h \
	$(SRCDIR)/version.c \
	$(SRCDIR)/return_codes.h \
	$(SRCDIR)/return_codes.c \
	$(SRCDIR)/main.c

OBJS := ${SRC:.c=.o}

HIDAPIH=
INC:= \
	-I$(SRCDIR) \
	-Ihidapi/hidapi \
	-I$(HIDAPIH) \
	-I/usr/include/libusb-1.0

CFLAGS= -Wall -Wextra -fno-guess-branch-probability -Wdate-time -frandom-seed=42 -O2 -gno-record-gcc-switches -DNDEBUG -fdebug-prefix-map=${PWD}=heads

OUTDIR=
OUT=nitrokey-hotp-verification
LDFLAGS=-lhidapi

all: $(OUT)
	ls -lh $<

clean:
	-rm $(OBJS)

$(OUT): $(OBJS)
	echo $(OBJS)
	$(CC) $^ $(LDFLAGS) -o $@
	ls -lh $@

%.o: %.c
	$(CC) -o $@ $<


