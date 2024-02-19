---
title: "Covert Swarm Bagde Hack Part One"
subtitle: "John Dips his toes into the world of hardware hacking with the covert swarm defcon badge"
date: 2024-02-28T22:00:00Z
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
author: John W
author_email: ponix@protonmail.com
listing_image: images/badge-front.jpeg
---

### Inroduction

#### A Little bit about me

I have always loved puzzles since I was little. From my first jigsaw to the CTF challenges been solving on hack the box.
So when I saw the puzzles that were built into some of the badges from [#Defcon](https://defcon.org/) and from the [#BadgeLife](https://www.reddit.com/r/badgelife/) community I wanted to get my hands on one.

I finally managed to get hold of a badge and am super excited to get stuck in to finding the puzzles and solving the challenges that are could be embaded within.

So I will attempt to give a runndown of the steps it have taken to find/solve the puzzle(s) and my thought processes behind them.

#### MY First Badge

First things First lets look at the badge and see what we are working with

<< badge-front >>

<< badge-back >>

##### Whats on the badge

what is actually on the badge.

###### Badge Front

On the front of the badge there is a silkscreen of the CovertSwarm logo with the words "YOU DESERVE TO BE HACKED" in the middle.There are also 8 Neopixel RGB LEDs in the sides of the 'arrows' of the covertswarm logo with a couple of capacitors and resistors when the badge is turned on these LEDs are orange, 6 Pushable buttons labeled F, G, A on the top left side and D, C, B on the bottom right.

On the bottom left side there is a {} Chip and on the top right there is an S.A.O

###### Badge Back

On the badge back there is a battery pack holder for 3 AAA batteries with a warning in the top right corner to not use rechargeable batteries.

There is an Arduino nano in the center and a {} chip to the left of it. underneather the arduino there is a piezo speaker and to the right of that there are 8 LEDs with what looks to be a corresponing set of pads for each LED.

###### Other Areas of interest

Underneath the Arduino there is a 'hidden' message that states "Nothing To See here! Go away!"

There is somthing under the Battery pack but its not quite visible with the battery pack on.

<< under the batteries >>

lets get the iron out and get it off :D

<< removing the battery pack >>

There we go.

<< under the hood >>

Printed under the battery pack there is the phrase "TH3FUZZYLLAMA" that might come in handly later.

Also I have found that bridging the pads next to the LEDs on the back of the badge causes them to light up im not sure if this has any other function at this stage.

#### Connecting to the Arduino Nano.

Using the Serial monitor on the Arduino IDE configured with the baudrate of 115200 we get the following output

<< Initial Dashboard image >>

On the printout there is line that says "Reading Device configuration" followed by an array of eight 0s ([00000000]).

Then a Welcome message saying "Your Device is not configured to access..."

This suggests that there may be alternate functions on the Devic


##### Commands