#!/usr/bin/env python3
# Get the current hackspace status from the SpaceAPI
import requests
import sys


def main(output=sys.stdout):
    output.write("Content-Type: text/html\n\n")

    try:
        resp = requests.get("https://api.leighhack.org/space.json", timeout=3)
        if resp.ok:
            data = resp.json()
            if "state" in data and data["state"]["open"]:
                output.write("<b>Open</b>")
                return
    except Exception:
        pass

    # If we have a HTTP error, exception, then just assume we're closed.
    output.write("Closed")


if __name__ == "__main__":
    main()
