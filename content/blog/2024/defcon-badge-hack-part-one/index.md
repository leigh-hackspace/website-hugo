---
title: "Covert Swarm Badge Hack - Part One"
subtitle: "John Dips his toes into the world of hardware hacking with the covert swarm Defcon badge"
date: 2024-03-30T22:00:00Z
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

# Introduction

 A Little bit about me

I have always loved puzzles since I was little. From my first jigsaw to the CTF challenges been solving on hack the box.
So when I saw the puzzles that were built into some of the badges from [#Defcon](https://defcon.org/) and from the [#BadgeLife](https://www.reddit.com/r/badgelife/) community I wanted to get my hands on one.

I finally managed to get hold of an electronic badge and am super excited to get stuck in trying to find and solve the challenges that are could be embedded within.

So I will attempt to give a rundown of the steps it have taken to find/solve the puzzle(s) and my thought processes behind them.

My First Badge

First things First lets look at the badge and see what we are working with

what is actually on the badge.

Here are images for the badge front and badge back 

{{< image src="images/badge-front.jpeg" class="is-pulled-right"  title="Front of the badge" >}}

{{< image src="images/badge-back.jpeg" class="is-pulled-right"  title="Back of the badge">}}

On the front of the badge there is a silkscreen of the CovertSwarm logo with the words "YOU DESERVE TO BE HACKED" in the middle.There are also 8 Neo-Pixel RGB LEDs in the sides of the 'arrows' of the Covertswarm logo with a couple of capacitors and resistors when the badge is turned on these LEDs are orange, 6 pushable buttons labeled F, G, A on the top left side and D, C, B on the bottom right.

On the bottom left side there is a 23A2XSM Chip and on the top right there is an S.A.O

&nbsp;

On the badge back there is a battery pack holder for 3 AAA batteries with a warning in the top right corner to not use rechargeable batteries.

There is an Arduino nano in the center and an 23A2XSM chip to the left of it. underneath the Arduino there is a piezo speaker and to the right of that there are 8 LEDs with what looks to be a corresponding set of pads for each LED.

&nbsp;

Other Areas of interest

Underneath the Arduino there is a 'hidden' message that states "Nothing To See here! Go away!"

There is something under the Battery pack but its not quite visible with the battery pack on.

{{< image src="images/under-the-batteries.jpeg" width="x475" class="is-pulled-right" title="Under the battery pack">}}

lets get the iron out and get it off :D

There we go.

{{< image src="images/under-the-hood.jpeg" class="is-pulled-right" title="Under the battery pack">}}

Printed under the battery pack there is the phrase "TH3FUZZYLLAMA" that might come in handy later.

Also I have found that bridging the pads next to the LEDs on the back of the badge causes them to light up im not sure if this has any other function at this stage.

Connecting to the Arduino Nano

Using the Serial monitor on the Arduino IDE configured with the baud rate of 115200 we get the following output

{{< image src="images/dashboard-image.jpeg" title="initial-dashboard-image">}}

&nbsp;

On the printout there is line that says "Reading Device configuration" followed by an array of eight 0s ([00000000]).

Then a message saying: `[ Welcome To CSCMOD Dashboard ]
Your module is not cofigured to access any other functionality. `

This suggests that there may be alternate functions on the Device.

Commands Available

{{< image src="images/help-me.jpeg" alt="Help">}} 

From this we can see that there are 4 options and explinations for what they do.

from the `submit <flag>` we know there is something we need to find and submit as a flag.

and `status` shows the status of flags that we have submitted in in our case 0

{{< image src="images/0-flags.png" alt="No Flags" >}}

and finally log

{{< image src="images/log-0.png" alt="Log entry 0" >}}

If want to you can read the full log#0 [Here](txt-files/log-0.txt)


Cracking the combination

on the underside of the badge there is an array or 8 LEDs and a set of corresponding unpopulated pads to the right of them.

Using a multimeter to check what these pads could be used for it looks like there is a common 5 volt rail on the ouside that once connected to the other side lights up the LED.

By bridging all the connections on unpopulated spaces on the back this has changed the array of 0's to 1's in the boot up section, This would suggest that the different configuration on the device is accessed by using a combination these connections.

{{< image src="images/half-way-over-the-bridge.jpeg" title="half way over the bridge ">}}

Based on the the range of possible bits from [00000000] to [11111111] is 256 possible combinations.

{{< image src="images/8-bits-are-enough.jpeg" title="all 8 leds bridged">}}

many lights 

{{< image src="images/8-bits-light-up.jpeg" height="200x" class="is-pulled-right"  title="Many LEDS" >}}

Rather that solder and un-solder a bridge every single time I want to check if this has applied any configuration changes I built a small 8 switch DIP selector

<< initial-dip-switches >>

Success !


Brute forcing the combination this way will take ages if we use some quick napkin maths.

There are 256 combinations and on average it is going to take 5 mins to change the combination, reset the device and then check the serial monitor output.

256 * 6 = 2048 mins
Thats just over 34 straight hours!.

Thats assuming there are no mistakes and I don't forget which combinations I have already tried.

This wont do. I should be able to automate this using a Raspberry Pi Pico and some basic circuit components.

Logic is the Key

I don't know much about electronics so doing after doing some research it looks like its possible to Achieve my goal by using PNP transistors.

A brief overview of what the transistors are doing in the circuit below. I have written some python code that will count from 0 to 256 and by using some of the GPIO pins on the Pico to act as The 8 bits once the value of the bit is reached then the pin is set high and the reset signal is sent to the pin on the ICSP port on the Arduino Nano and Then using the TX pin on the same header to read the output from the serial console.

<< Circuit plan >>

It is worth noting that there _IS_ a difference in the voltages from the Arduino Nano (5v) and the Pico (3.3v) and trying to read the serial monitor from the TX bin and killed this pin on the Device. looks like the first casualty of this experiment.

<< RIP Pico >>

 Timing is important

Using the transistor Circuit takes about 15 seconds rather than 5 mins . Again some quick napkin maths to work out the time difference.

10 * 256 = 2560 Seconds

2560 / 60 / 60 = 42 mins

This is much faster !.

Thanks for coming to my ted talk ! I cant wait to start chapter 2 of this for the second challenge.