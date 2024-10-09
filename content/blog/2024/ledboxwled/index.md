---
title: "LED Box WLED"
subtitle: "Building a control box for WS2812Bs"
date: 2024-10-02T00:00:00Z
toc: false
tags:
  - 2812b
  - led
  - cost effective
  - WLED
  - esp32
draft: true
author: Andrew K
author_email: leighhack@shamrock.org.uk
listing_image: images/IMG_3606.jpg
---
I wanted to build a control box for 2 LED strips of WS2812s. This is for a display in a bedroom, but I also wanted it to be controllable from mobile/desktop, along with multiple colours and brightness controls!

# How to break it down into components

First I needed to work out the different components I needed and how they would be put together, to make sure they fit in the location I wanted but also portable enough if I ever wanted to take them away.

- ESP32 - Simple and effectively using [WLED](https://kno.wled.ge/)
- Two LED strips to be used 
- Two LED diffusers. They are aluminium with a diffusing cover. They are readily available on Amazon/Ebay/Other locations.
- An enclosure for the ESP32 and allow the LED strips to plug in
- 2 x 3 Pin sockets and plugs 
- 1 x PSU socket for a 5v power supply
- A PSU that can plug into the enclosure.

# Components 

Enclosure

{{< bgallery width="90" >}}
{{< fimage src="images/blankenclosure.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

# Male/Female 3 pin DIN connectors and 2.1mm PSU connector

These were placed in the honeycomb to create a simpler picture

{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3607.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

The 3 pin connectors were chosen to connect the LEDs so each one had a +v, -v and data line.

# ESP32 Terminal adaptor for the enclosure

To keep things as simple as possible I used a ESP32 terminal adaptor and stuck this to the inside of the enclosure.

{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3614.jpg" width="300" height="200" float="inline-block">}}
{{< fimage src="images/IMG_3603.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

# Drilled some holes for the connectors

{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3580.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

# Created a cable to plug into the enclosure and to WS2812B LED strip

I got hold of 2 x 3 pin JST extension cable and by using one half created a cable to connect to the LED strip and enclosure

{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3585.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

Then attached to the LED strip

{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3600.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

To tidy things up I then used some heat shrink around the new cable.

{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3601.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

# Some soldering

As the terminal adaptor could take two ESP32 sizes, and I had the smaller of the two, I can use breadboard cables to solder all the positions and then just plug into the terminals I needed.

{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3581.jpg" width="300" height="200" float="inline-block">}}
{{< fimage src="images/IMG_3604.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

# Install WLED

If you following the installation procedure found [here](https://kno.wled.ge/basics/install-binary/) it sets up all the elements you need and then you can configure to use the GPIO pins you need.

# All set up and working

You can use the WLED interface to change colours and enable patterns

{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3605.jpg" width="300" height="200" float="inline-block">}}
{{< fimage src="images/IMG_3606.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

# Finally Installed and Working
  
All installed for the location. The LEDs and diffuser has been cut to the correct length.
  
{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3663.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}