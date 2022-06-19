import argparse

import at28c256
import serial
import struct
import sys


def run(port, path, full, verify):
    s = serial.Serial(port, 115200)
    s.write(b'\xff')
    if s.read() != b'\xfe':
        raise Exception('[!] ERROR: ESP8266 Unexpected Result')

    with open(path, 'rb') as f:
        new_contents = f.read()

    ROM_LENGTH = 16384
    ROM_CHUNK = 1024

    if len(new_contents) != ROM_LENGTH:
        raise Exception('[!] Error: Expected ROM Length 16384 bytes, got %d bytes' % len(new_contents))

    def _write_range(address, data):
        for i in range(0, len(data), ROM_CHUNK):
            chunk_size = len(data) - i
            if chunk_size > ROM_CHUNK:
                chunk_size = ROM_CHUNK

            print('\r[+] FPGA-ROM Writing', ('%04x' % (address + i)), '-',  ('%04x' % (address + i + chunk_size)), '/', ('%04x' % (address + len(data))), end='')
            sys.stdout.flush()

            s.write(b'\x01' + struct.pack('<HH', (address + i) & 0x7fff, chunk_size & 0x7fff) + data[i:i+chunk_size])
            if s.read() != b'\x01':
                raise Exception('[!] ERROR: ESP8266 Unexpected Result')

    for i in range(0, ROM_LENGTH, ROM_CHUNK):
        new_chunk_size = ROM_LENGTH - i
        if new_chunk_size > ROM_CHUNK:
            new_chunk_size = ROM_CHUNK

        new_chunk = new_contents[i:i+new_chunk_size]
        print('[+] Updating Chunk', ('%04x - %04x' % (i, i+new_chunk_size)))
        _write_range(i, new_chunk)
        at28c256.hexdump(new_chunk, address=i, indent=4)

    print('[+] Done!')
    print()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('path', type=str)
    parser.add_argument('--full', action='store_true', default=False)
    parser.add_argument('--port', type=str, default='')
    parser.add_argument('--verify', action='store_true', default=False)
    args = parser.parse_args()

    if not args.path:
        raise Exception('Invalid ROM')

    try:
        print()
        run(args.port, args.path, args.full, args.verify)
    except KeyboardInterrupt:
        print('\n[+] Cancelled\n')
    except Exception as ex:
        print()
        print(f'Exception! {ex}')
        print()
