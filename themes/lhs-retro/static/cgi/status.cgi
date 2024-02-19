#!/usr/bin/env python3
# Get the current hackspace status from the SpaceAPI
import requests
import sys


def main(output=sys.stdout):
    output.write('Content-Type: text/html\n\n')

    try:
        resp = requests.get('https://api.leighhack.org/space.json')
        if resp.ok:
            data = resp.json()
            if 'state' in data:
                if data['state']['open']:
                    output.write('<b>Open</b>')
                    return
    except Exception:
        pass

    output.write('Closed')

if __name__ == '__main__':
    main()
