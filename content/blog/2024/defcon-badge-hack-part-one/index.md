---
title: "Covert Swarm Badge Hack - Part One"
subtitle: "John Dips his toes into the world of hardware hacking with the covert swarm Defcon badge"
date: 2024-07-01T10:10:10
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

## Introduction

{{< clearfix >}}

#### A Little bit about me

{{< center-block-90 >}}

I have always loved puzzles since I was little. From my first jigsaw to the CTF challenges on [Hack The Box](https://app.hackthebox.com/login?redirect=%2Fhome) and [Try Hack Me](https://tryhackme.com/).
So when I saw the puzzles that were built into some of the badges from [#Defcon](https://defcon.org/) 
and from the [#BadgeLife](https://www.reddit.com/r/badgelife/) community.

I Knew I wanted to get my hands on one so now that I finally managed to get hold of an electronic badge.I am super excited to get stuck in trying to find and solve the challenges that are embedded within.

I will attempt to give a rundown of the steps it have taken to find/solve the puzzle(s) and my thought processes behind them.

{{< /center-block-90 >}}

{{< clearfix >}}

#### My First Badge

{{< center-block-90 >}}

First things First lets look at the badge and see what we are working with
what is actually on the badge.
Below are some images of the badge and whats on it

{{< /center-block-90 >}}
### Badge overview

{{< clearfix >}}
{{<image src="images/badge-front.jpeg" title="Front of the badge" width="450x" class="is-pulled-left highlighted" style="margin-left:5%">}}
{{<image src="images/badge-back.jpeg"  title="Back of the badge" width="450x" class="is-pulled-left">}}

{{< clearfix >}}

{{< center-block-90 >}}

On the front of the badge there is a silkscreen of the CovertSwarm logo with the words "YOU DESERVE TO BE HACKED" in the middle.There are also 8 Neo-Pixel RGB LEDs in the sides of the 'arrows' of the Covertswarm logo with a couple of capacitors and resistors when the badge is turned on these LEDs are orange, 6 pushable buttons labeled F, G, A on the top left side and D, C, B on the bottom right.

On the bottom left side there is a 23A2XSM Chip and on the top right there is a space for an S.A.O port

Now the badge back has is a battery pack holder for 3 AAA batteries with a warning in the top right corner to not use rechargeable batteries.

There is an Arduino nano in the center and an 23A2XSM chip to the left of it.

Underneath the Arduino there is a piezo speaker and to the right of that there are 8 LEDs with what looks to be a corresponding set of pads for each LED.

{{< /center-block-90 >}}

{{< clearfix >}}

{{< center-block-90 >}}
#### Other Areas of interest

Underneath the Arduino there is a 'hidden' message that states "Nothing To See here! Go away!"

There is something under the Battery pack but its not quite visible with the battery pack on.

{{<image src="images/under-the-batteries.jpeg" Width="200x" class="is-pulled-right" alt="Under the battery pack">}}

lets get the iron out and get it off :D

There we go.

{{<image src="images/under-the-hood.jpeg" Width="200x" class="is-pulled-right" alt="Under the battery pack">}}

Printed under the battery pack there is the phrase "TH3FUZZYLLAMA" that might come in handy later.

Also I have found that bridging the pads next to the LEDs on the back of the badge causes them to light up im not sure if this has any other function at this stage.
{{< /center-block-90 >}}


#### Connecting to the Arduino Nano

Using the Serial monitor on the Arduino IDE configured with the baud rate of 115200 we get the following output

{{<image src="images/dashboard-image.jpeg" Width="200x" alt="initial-dashboard-image">}}

On the printout there is line that says "Reading Device configuration" followed by an array of eight 0s ([00000000]).

Then a message saying: `[ Welcome To CSCMOD Dashboard ]
Your module is not cofigured to access any other functionality. `

This suggests that there may be alternate functions on the Device.

Commands Available

{{<image src="images/help-me.jpeg" alt="Help">}} 

From this we can see that there are 4 options and explinations for what they do.

from the `submit <flag>` we know there is something we need to find and submit as a flag.

and `status` shows the status of flags that we have submitted in in our case 0

{{<image src="images/0-flags.png" alt="No Flags" >}}

and finally log

{{<image src="images/log-0.png" alt="Log entry 0" >}}

If want to you can read the full log#0 [Here](txt-files/log-0.txt)

#### Cracking the combination

on the underside of the badge there is an array or 8 LEDs and a set of corresponding unpopulated pads to the right of them.

Using a multimeter to check what these pads could be used for it looks like there is a common 5 volt rail on the ouside that once connected to the other side lights up the LED.

By bridging all the connections on unpopulated spaces on the back this has changed the array of 0's to 1's in the boot up section, This would suggest that the different configuration on the device is accessed by using a combination these connections.

{{<image src="images/half-way-over-the-bridge.jpeg" alt="half way over the bridge ">}}

Based on the the range of possible bits from [00000000] to [11111111] is 256 possible combinations.

{{<image src="images/8-bits-are-enough.jpeg" alt="all 8 leds bridged">}}
 
{{<image src="images/8-bits-light-up.jpeg" width="200x" class="is-pulled-right"  alt="Many LEDS" >}}

Rather that solder and un-solder a bridge every single time I want to check if this has applied any configuration changes I built a small 8 switch DIP selector

{{< image src="images/switches-over-bridges.jpeg" alt="over" >}}

Success !

Brute forcing the combination this way will take ages if we use some quick napkin maths.

There are 256 combinations and on average it is going to take 5 mins to change the combination, reset the device and then check the serial monitor output.

```
256 * 6 = 2048 mins
Thats just over 34 straight hours!
```

Thats assuming there are no mistakes and I don't forget which combinations I have already tried.

This wont do. I should be able to automate this using a Raspberry Pi Pico and some basic circuit components.

Logic is the Key

I don't know much about electronics so doing after doing some research it looks like its possible to Achieve my goal by using PNP transistors or perhaps using some relays,

A brief overview of what the relays are doing in the circuit below. I have written some code that will count from 0 to 256 and by using some of the GPIO pins on the Pico to act as The 8 bits once the value of the bit is reached then the pin is set high and the reset signal is sent to the pin on the ICSP port on the Arduino Nano that is attached to the badge and then using the TX pin on the same header to read the output from the serial console.

The Repository for this code is located [here](https://github.com/ponix4k/cs_badge_decode)

It is worth noting that there _IS_ a difference in the voltages from the Arduino Nano (5v) and the Pico (3.3v) and trying to read the serial monitor from the TX bin and killed this pin on the Device. looks like the first casualty of this experiment.

{{< image src="images/rip-pico.jpeg"  width="200x" class="is-pulled-right"  alt="RIP Pico" >}}

### Timing is important

Using the Relay Circuit takes about 15 seconds rather than 5 mins . Again some quick napkin maths to work out the time difference.

```
10 * 256 = 2560 Seconds
2560 / 60 / 60 = 42 mins
```
This is much faster !.

Once the code was working to switch the relays on and off i wrote a few test functions to check the connections are stable to each of the pins.

then set it going on its journey from 0 - 255

I couldnt get the 9th relay to successfully reboot the badge nano but luckily there is a button on the top of the nano to reset it.

So I waited 5 seconds after the LEDs changed to reset it and watch the console output update the dashboard.

I set the output of the serial monitor to goto file and then scrolled through it for the changes in the messages.

There were two combinations that gave different messages on the dashboard that allowed the user access to other functionality.

```
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
---
```
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

{{< image src="images/pink-badge.jpeg" class="is-pulled-right"  title="New Color LEDs" >}}


Now that i know both of the combinations i can use this to create a 2 bit ROM where the user will beable to switch between the two modes to access the other challenges.

{{< clearfix >}}

After some initial teething issues and consulting some freinds that have had things fabbed before I was able to get some prototype boards created and sent over.

{{< image src="images/circuit-schema.png" title="Circuit Layout" width="200x" class="is-pulled-right" >}}
{{< image src="images/3d-image.png"  title="Finished board" 
width="200x" class="is-pulled-left" >}}

{{< clearfix >}}

This Design was a bit bigger than Would have liked but it is just a proto type i will refactor this to make it small enough to fit on one of the sides of the badge.

Thanks for coming to my ted talk ! I cant wait to start chapter 2 of this for the second challenge.

{{< clearfix >}}