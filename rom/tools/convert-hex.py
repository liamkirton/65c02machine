import argparse
import os


def run(path, outdir, quiet):
    with open(path, 'rb') as f:
        rom = f.read()

    ROM_LENGTH = 16384

    if len(rom) != ROM_LENGTH:
        raise Exception('[!] Error: Expected ROM Length 16384 bytes, got %d bytes' % len(rom))

    if not outdir:
        outdir = os.path.split(path)[0]
    outdir = os.path.abspath(outdir)
    outfile = os.path.join(outdir, os.path.splitext(os.path.split(path)[1])[0] + '.hex')

    with open(outfile, 'w') as f:
        for i in range(0, ROM_LENGTH):
            f.write(format(rom[i], '02x'))
            if i != ROM_LENGTH - 1:
                f.write('\n')
    
    if not quiet:
        print(f'[+] Done Writing \"{outfile}\"')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('path', type=str)
    parser.add_argument('--outdir', type=str, default='')
    parser.add_argument('--quiet', action="store_true", default=False)
    args = parser.parse_args()

    if not args.path:
        raise Exception('Invalid ROM')

    try:
        print()
        run(args.path, args.outdir, args.quiet)
    except KeyboardInterrupt:
        print('\n[+] Cancelled\n')
    except Exception as ex:
        print()
        print(f'Exception! {ex}')
        print()
