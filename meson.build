project('hotp-verification', 'c')
lusb = dependency('libusb-1.0')

src = [
'crc32.c',
'device.c',
'operations.c',
'dev_commands.c',
'base32.c',
'random_data.c',
'min.c',
'version.c',
'return_codes.c',
'main.c',
'hidapi/libusb/hid.c'
]

common_flags = ['-DNK_REMOVE_PTHREAD']

incdir = ([
include_directories('.'),
include_directories('hidapi/hidapi'),
])

name1 = 'nitrokey-hotp-verification'
name2 = 'libremkey-hotp-verification'
executable(name1, src, dependencies : lusb, include_directories: incdir, c_args: common_flags)
executable(name2, src, dependencies : lusb, include_directories: incdir, c_args: common_flags)