---
title: "Can You Make It Bigger? - A Journey In Building Arcade Cabinets"
subtitle: ""
date: 2024-06-23T07:40:38Z
tags:
    - CNC
    - Electronics
    - Raspberry Pi
draft: false
author: Kian Ryan
author_email: kian@orangetentacle.co.uk
---

Sometimes projects get out of hand, and come around full circle.

This one started out as an idea.

"We want to make a bunch of games with our sponsors, and have a bunch of small arcade cabinets.  But we also want to 
take the cabinets to a bunch of other events."

Okay.  So first thoughts go to the [Picade](https://shop.pimoroni.com/products/picade).  The Picade is a small arcade cabinet 
from [Pimoroni](https://shop.pimoroni.com/).  It's great, I have one. 
It lives upstairs in my second bedroom, and when I need a bit of quiet time, I use it to play Frogger.  I'm a Frogger demon.

But it's not small, and arguably, it's not easy to store.  It's still arcade shaped, and doesn't stack well.

What if we could build an arcade laptop?  Something that could be folded down between events and stored easily?

First iteration was really a Picade in a case, and used a removable stick.  It filled the first attempt at the brief, but 
didn't look "Arcade-y" enough.  Fair.  Can we make it look more like an arcade.

For my early drafts, I sketch, rather than go straight to CAD.  I like to have ideas on paper, or more recently, 
on digital paper, before I start opening up a CAD program.  It won't be perfect, but I'll have some idea of the shape 
of the thing before I start working through something I plan on making.  CAD software can occassionally be unforgiving, 
and it likes to have a plan of what you want to build.  You can vary that plan - but having at least part of that plan up 
front helps.

This conversation goes forwards and backwards until we get to the nub of it.

"You want full size arcade cabinets, don't you?"

So how do we deliver full size arcade cabinets, that are still ultimately, portable and storable.

Another limitation - our CNC has a bed size of 80x80cm.  We never thought this would be a limitation, but turns out 
we're starting to hit it's limits!  We're at least glad we got this one, and not the next size down.

The answer is you do it in bits.  The idea of the case still works, somewhere for all the electronics to live.  Monitor, 
Raspberry Pi and controls.  Then we build a separate cabinet for the case to slot in to.  The cabinet slots together 
like flat pack furniture, using furniture bolts and slots for assembly.  At the end of the event, remove the bolts, 
flatten the case and store between events.

Once we were happy with the general idea, we designed the prototype in Fusion 360, and cut the prototype on our Shapeoko XXL. 
The case is cut in 9mm MDF and the cabinet in 18mm MDF.  We refined the design a bit, and the DXF files are now available 
on Github.

To kit the electronics, we used an off-the shelf monitor, connected using M6 bolts to the case, a normally Raspberry Pi 
running RetroArch and a pretty vanilla Picade style setup with an arcade stick and 10 buttons.  The GA241 monitor is powered 
by 12V so by supplying power to the case, and then splitting the power, we can then power the monitor and a buck converter 
to power the Pi.  A single 12V/4A power supply powers the whole rig very adequately.

Electronics:

Cooler Master GA241 23.8" VA Monitor
Raspberry Pi 4
Picade X HAT
Phreak Mods Link EX Groove Quick Release 
Sanwa JLF-TP-8YT Arcade Joystick 
Sanwa OBSN-30 Screw In Japanese Arcade Button 
16mm Metal Illuminated Button
A 5V/3A Buck Converter
2.1mm sockets.

Note on suppliers: We used Arcade World UK for a large amount of this build, but they appear to have disappeared.  Since 
the original build, we've been using [Aracde Express](https://www.arcadexpress.com), a Spanish Company.  Import charges 
may apply when using them.

The Devoxx UK games were built using PyGame - Dan Hardiker came down the weekend before the event and spent the time getting 
the games working on the machines.  There's nothing like a deadline.  Running right up against it, we painted the cabinets 
black and drove them down for setup at the Business Design Centre in London.

They were received well, and performed great for the duration of the event.  Dan and the crew then did exactly what the 
cabinets were designed to do - they removed the electronic cases, removed the bolts, dropped the cabinets flat and packed 
them for the next event.

But we're not quite done.  The event had gone well, but our prototype was still looking ... well, like a prototype.  And 
a Hackspace without an Arcade Cabinet isn't really a Hackspace.  So we recut the side panels to the new profile, gave ours 
a lick of paint, and using a Player-X board, some more components and a trackball, added some extra rizz.  It's already 
been to EMFCamp, where it ran Pico-8 games from Johnathon in the Family Tent, and it'll be making an appearance at the 
Discworld Convention in August.

If you drop by the Hackspace, you're more than welcome to play on it.