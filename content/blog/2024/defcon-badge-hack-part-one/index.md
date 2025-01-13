---
title: "CovertSwarm Badge Hack"
subtitle: "John Dips his toes into the world of hardware hacking with the covert swarm Defcon badge - Part One"
date: 2024-12-31T10:10:10Z
tags:
    - defcon
    - badgelife
    - hardware-hacking
    - hacking
    - electronics
    - covertswarm
    - soldering
    - hackspace
    - makerspace
draft: false
author: John Williams
author_email: ponix@protonmail.com
listing_image: images/badge-front.jpeg
---

## A Little Bit About Me

I have always loved puzzles since I was little, from my first jigsaw to the CTF challenges on [Hack The Box](https://app.hackthebox.com/login?redirect=%2Fhome) and [Try Hack Me](https://tryhackme.com/).
So when I saw the puzzles that were built into some of the badges from [#Defcon](https://defcon.org/)
and from the [#BadgeLife](https://www.reddit.com/r/badgelife/) community,I knew I wanted to get my hands on one.

Now that I finally managed to get hold of an electronic badge, I was super excited to get stuck in trying to find and solve the challenges that are embedded within.

I will attempt to give a rundown of the steps it have taken to find/solve the puzzle(s) and my thought processes behind them.

#### What's On The Badge?

First things first, let's have a look at the badge and see what we are working with.

Below are some images of the badge (front and back)

{{< side-by-side-2-cols
    "images/badge-front.jpeg" "Front of the badge"
    "images/badge-back.jpeg" "Back of the badge"
>}}

On the front of the badge, there is a silkscreen of the CovertSwarm logo with the words "YOU DESERVE TO BE HACKED" in the middle.

There are also 8 Neo-Pixel style RGB LEDs in the sides of the 'arrows' of the Covertswarm logo with a couple of capacitors and resistors.

When the badge is turned on the LEDs are orange there also are 6 pushable buttons labeled F, G, A on the top left side and D, C, B on the bottom right.

On the bottom left side there is also `23A2XSM` chip and on the top right there is a space for an S.A.O port.

On the back there is an `Arduino Nano` in the center underneath the Arduino there is a `piezo speaker` and to the right of that there are 8 LEDs with what looks to be a corresponding set of pads for each LED.

----

#### Other Areas Of Interest

Underneath the Arduino there is a 'hidden' message that states "Nothing To See here! Go away!"

There is something under the Battery pack but its not quite visible with the battery pack on.

lets get the iron out and get it off :D

{{< side-by-side-2-cols
    "images/under-the-batteries.jpeg" "Under the battery pack"
    "images/under-the-hood.jpeg" "Under the battery pack"
>}}

Printed under the battery pack there is the phrase "TH3FUZZYLLAMA" that might come in handy later.

Also, I have found that bridging the pads next to the LEDs on the back of the badge causes them to light up (im not sure if this has any other function at this stage)

#### Connecting To The Arduino Nano

The first thing I did after connecting the Arduino to my pc was to dump the firmware and create a back up of the "clean" firmware just incase I kill the Arduino; I can always flash another.

A backup can be found [here](backup-files/badge_backup.zip)

Using the serial monitor on the Arduino IDE configured with the baud rate of `115200` and connecting to the `USB` com port we get the following output:

{{< padded-center-image 
    "images/dashboard-image.jpeg" "initial-dashboard-image"
>}}

On the printout there is line that says `Reading device configuration` followed by an array of eight 0s `[00000000]`.

Then a message saying:

```text
[ Welcome To CSCMOD Dashboard ] Your module is not cofigured to access any other functionality. 
```

This suggests that there may be alternate functions on the device.

----

#### Commands Available

{{< padded-center-image
    "images/help-me.jpeg" "Help"
>}}

From this we can see that there are 4 options with corresponding descriptions.

From the `submit <flag>` command we know there is something we need to find and submit as a flag.

the `status` command shows the status of flags that we have submitted in our case `0`

{{< padded-center-image
    "images/0-flags.png" "No Flags"
>}}

Finally `log` command

{{< padded-center-image
    "images/log-0.png" "Log entry 0"
>}}

The full log#0 can be read [Here](txt-files/log-0.txt)

----

#### Cracking The Combination

On the underside of the badge there is an array of 8 LEDs and a set of corresponding unpopulated pads to the right of them.

Using a multimeter to check what these pads could be used for it looks like there is a common 5 volt rail on the outside pad that once connected to the other side lights up the LED.

By bridging all the connections on unpopulated spaces on the back this has I found the array of `0's` to `1's` in the boot up section, This would suggest that the different configuration on the device is accessed by using a combination these connections.

{{< padded-center-image
    "images/8-bits-are-enough.jpeg" "all 8 leds bridged"
>}}

Based on the the range of possible bits from [00000000] to [11111111] there are 256 possible combinations.

{{< side-by-side-2-cols
    "images/half-way-over-the-bridge.jpeg" "half way over the bridge"
    "images/8-bits-light-up.jpeg" "Many LEDS"
>}}

Rather that solder and desolder a bridge every single time I wanted to change the array and confirm if configuration had changed, I attached a small 8 switch DIP selector to the badge.

Unfortunately during this soldering of the wires to the dip selector I knocked one of the tiny LEDs off the board.

{{< side-by-side-2-cols
    "images/8-switch-dips.jpg" "dip selector"
    "images/switches-over-bridges.jpeg" "switches over bridges"
>}}

Success!

Brute forcing the combination this way will take ages, if we use some quick napkin maths

There are 256 combinations and on average it is going to take 6 mins to change the combination, reset the device and then check the serial monitor output.

```text
256 * 6 = 1536 mins
Thats just over 25 straight hours!

```

Thats assuming there are no mistakes and I don't forget which combinations I have already tried.

This wont do. I should be able to automate this using a Raspberry Pi Pico or another Arduino and some basic circuit components.

----

#### Logic Is The Key

I don't know much about electronics currently; after doing some research it looks like its possible to achieve my goal two ways either by using PNP transistors or perhaps using some relays,

{{< padded-center-image
    "images/8-relays.jpeg" "8 relays"
>}}

A brief overview of what the relays are doing in the circuit below.
I have written some code that will count from 0 to 255 and by using some of the GPIO pins on the Pico to act as The 8 bits once the value of the bit is reached then the pin is set high and the reset signal is sent to the pin on the ICSP port on the Arduino Nano that is attached to the badge and then using the TX pin on the same header to read the output from the serial console.

The Repository for this code is located [here](https://github.com/ponix4k/cs_badge_decode)

----

#### Casualties

It is worth noting that there _IS_ a difference in the voltages from the Arduino Nano (5v) and the Pico (3.3v) and trying to read the serial monitor from the TX bin and killed this pin on the Device. looks like the another casualty of this experiment.

{{< side-by-side-2-cols
    "images/rip-pico.jpeg" "RIP Pico"
    "images/casualty-led.jpeg" "Missing LED"
>}}

----

#### Timing Is Important

Using the Relay Circuit takes about 15 seconds per iteration rather than 6 mins, again some quick napkin maths to work out the time difference.

```text
10 * 256 = 2560 Seconds
2560 / 60 / 60 = 42 mins
```

This is much faster !

Once the code was working to switch the relays on and off I wrote a few test functions to check the connections are stable to each of the pins.

then set it going on its journey from 0 - 255

I couldnt get the 9th relay to successfully reboot the badge Arduino on the badge but luckily there is a button on the top of to reset it.

So I waited 5 seconds after the LEDs changed to reset it and watch the console output update the dashboard.

I set the output of the serial monitor spool into a file and then scrolled through it for the changes in the messages.

There were two combinations that gave different messages on the dashboard that allowed the user access to other functionality.

```text
BOOT started #CSCMOD A328P v1.1
Spaceship connection...OK
EM Reactive Nanocells status...OK
Reading device configuration...OK [10101001]
Spaceship Oxigen level...OK
Location...Unknown

[ Logs & HQ Directives Downloader ]
A secure delivery method and storage for spaceship logs, HQ directives and new orders.

CS2023{H4rDc0d3d_c0
insert password > 
```

----

```text
BOOT started #CSCMOD A328P v1.1
Spaceship connection...OK
EM Reactive Nanocells status...OK
Reading device configuration...OK [00100111]
Spaceship Oxigen level...OK
Location...Unknown

[ Secure Messagging Channel ]
Do not trust the void, always encrypt your messages.

nF1gUR4t10n!}

Loading...
type HELP for commands:
```

At the end of each one of these boot messages are the two parts of the first flag `CS2023{H4rDc0d3d_c0nF1gUR4t10n!}`

Entering this into the flag section of the menu changed the LEDs on the from from Orange to Pink.

{{< padded-center-image
    "images/pink-badge.jpeg" "New Color LEDs"
>}}

Now that I know both of the combinations I can use this to create a `2 bit ROM` where the user will be able to switch between the two modes to access the other challenges.

After some initial teething issues and consulting some freinds that have had things fabbed before, I was able to get some prototype boards created and sent to me.

{{< side-by-side-2-cols
    "images/circuit-schema.png" "Circuit Layout"
    "images/3d-image.png" "Finished board"
>}}

This design was a bit bigger than I would have liked but it is just a prototype I will refactor this to make it small enough to clip on one of the sides of the badge.

Thanks for coming to my ted talk!

I cant wait to start chapter 2 of this for the second challenge :) 
