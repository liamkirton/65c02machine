import argparse

import at28c256


def run(port, path, verify):
    a = at28c256.AT28C256(port=port)

    with open(path, 'rb') as f:
        new_contents = f.read()

    ROM_LENGTH = 16384
    ROM_CHUNK = at28c256.AT28C256.BUFFER_SIZE

    if len(new_contents) != ROM_LENGTH:
        raise Exception('[!] Error: Expected ROM Length 16384 bytes, got %d bytes' % len(new_contents))

    read_contents = a.read_range(0, ROM_LENGTH)

    for i in range(0, ROM_LENGTH, ROM_CHUNK):
        new_chunk_size = ROM_LENGTH - i
        if new_chunk_size > at28c256.AT28C256.BUFFER_SIZE:
            new_chunk_size = at28c256.AT28C256.BUFFER_SIZE

        new_chunk = new_contents[i:i+new_chunk_size]
        if read_contents[i:i+new_chunk_size] != new_chunk:
            print('[+] Updating Chunk', ('%04x - %04x' % (i, i+new_chunk_size)))
            a.write_range(i, new_chunk)
            at28c256.hexdump(new_chunk, address=i, indent=4)

    if verify:
        readback_contents = a.read_range(0, ROM_LENGTH)

        print()
        at28c256.hexdump(readback_contents, address=0)
        print()

        if len(readback_contents) != len(new_contents):
            raise Exception('[!] Error %d Read != %d Written\n' % (len(readback_contents), len(new_contents)))

        for i in range(0, len(new_contents)):
            if readback_contents[i] != new_contents[i]:
                raise Exception('[!] Error Byte At %d Read (%02x) != Written (%02x)\n' % (i, readback_contents[i], new_contents[i]))

    print('[+] Done!')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('port', type=str)
    parser.add_argument('path', type=str)
    parser.add_argument('--verify', action='store_true', default=False)
    args = parser.parse_args()

    if not args.port:
        raise Exception('Invalid COM PORT')
    elif not args.path:
        raise Exception('Invalid ROM')

    try:
        run(args.port, args.path, args.verify)
    except KeyboardInterrupt:
        print('\n[+] Cancelled\n')
    except Exception as ex:
        print(ex)

