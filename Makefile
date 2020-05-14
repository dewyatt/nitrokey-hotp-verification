SRCDIR=.

SRC:= \
	$(SRCDIR)/crc32.c \
	$(SRCDIR)/crc32.h \
	$(SRCDIR)/device.c \
	$(SRCDIR)/operations.c \
	$(SRCDIR)/dev_commands.c \
	$(SRCDIR)/base32.c \
	$(SRCDIR)/random_data.c \
	$(SRCDIR)/min.c \
	$(SRCDIR)/version.c \
	$(SRCDIR)/return_codes.c \
	$(SRCDIR)/main.c

HEADERS := \
	$(SRCDIR)/structs.h \
	$(SRCDIR)/device.h \
	$(SRCDIR)/operations.h \
	$(SRCDIR)/dev_commands.h \
	$(SRCDIR)/base32.h \
	$(SRCDIR)/command_id.h \
	$(SRCDIR)/random_data.h \
	$(SRCDIR)/min.h \
	$(SRCDIR)/settings.h \
	$(SRCDIR)/version.h \
	$(SRCDIR)/return_codes.h \


OBJS := ${SRC:.c=.o}

HIDAPIH=.
INC:= \
	-I$(SRCDIR) \
	-Ihidapi/hidapi \
	-I$(HIDAPIH) \
	-I/usr/include/libusb-1.0

CFLAGS= -Wall -Wextra -fno-guess-branch-probability -Wdate-time -frandom-seed=42 -O2 -gno-record-gcc-switches -DNDEBUG -fdebug-prefix-map=${PWD}=heads -c -std=c11

OUTDIR=
OUT=nitrokey-hotp-verification
LDFLAGS=-lhidapi

all: $(OUT)
	ls -lh $<

clean:
	-rm $(OBJS) $(OUT)

$(OUT): $(OBJS) $(HEADERS)
	$(CC) $^ $(LDFLAGS)  -o $@
	ls -lh $@

%.o: %.c
	$(CC) $(CFLAGS) $(INC) -o $@ $<


.PRECIOUS: %.o
