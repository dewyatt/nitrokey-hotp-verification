SRCDIR=.

SRC:= \
	$(SRCDIR)/crc32.c \
	$(SRCDIR)/device.c \
	$(SRCDIR)/operations.c \
	$(SRCDIR)/dev_commands.c \
	$(SRCDIR)/base32.c \
	$(SRCDIR)/random_data.c \
	$(SRCDIR)/min.c \
	$(SRCDIR)/version.c \
	$(SRCDIR)/return_codes.c \
	$(SRCDIR)/main.c

SRC += \
	$(SRCDIR)/hidapi/libusb/hid.c

HEADERS := \
	$(SRCDIR)/crc32.h \
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

CFLAGS= -Wall -Wextra -fno-guess-branch-probability -Wdate-time -frandom-seed=42 -O2 -gno-record-gcc-switches -DNDEBUG -fdebug-prefix-map=${PWD}=heads -c -std=gnu11 -DNK_REMOVE_PTHREAD

OUTDIR=
OUT=nitrokey-hotp-verification
OUT2=libremkey-hotp-verification
LDFLAGS=-lusb-1.0

all: $(OUT) $(OUT2)
	ls -lh $^

clean:
	-rm $(OBJS) $(OUT) version.c

$(OUT2): $(OUT)
	cp $< $@

$(OUT): $(OBJS)
	$(CC) $^ $(LDFLAGS)  -o $@

%.o: %.c
	$(CC) $(CFLAGS) $(INC) -o $@ $<

$(SRCDIR)/version.c: $(SRCDIR)/version.c.in
	#sed GIT_VERSION_PLACEHOLDER
	cp $< $@

.PRECIOUS: %.o
