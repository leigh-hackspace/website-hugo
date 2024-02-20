#!/usr/bin/env python3
# Get the current upcoming events from the Hackspace API
import requests
import sys
import arrow


def main(output=sys.stdout):
    output.write("Content-Type: text/html\n\n")

    try:
        resp = requests.get("https://api.leighhack.org/events", timeout=5)
        if resp.ok:
            data = resp.json()

            for event in data[:5]:
                start = arrow.get(event["start"]["dateTime"])
                end = arrow.get(event["end"]["dateTime"])
                output.write(
                    f"<h3>{start.format('YYYY-MM-DD')} - {event['summary']} - <small><i>{start.format('HH:mm')} -> {end.format('HH:mm')}</i></small></h3>"
                )
                output.write(f"<p>{event['description']}</p>")

            return
    except Exception:
        pass

    output.write("Oops, something wen't wrong grabbing the upcoming events.")


if __name__ == "__main__":
    main()
