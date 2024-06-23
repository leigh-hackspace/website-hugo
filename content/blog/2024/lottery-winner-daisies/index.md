---
title: "Making Stage Props for the Lottery Winners"
subtitle: ""
date: 2024-06-23T07:40:38Z
tags:
    - CNC
    - Electronics
    - Pi Pico
draft: false
author: Kian Ryan
author_email: kian@orangetentacle.co.uk
listing_image: images/on_stage.jpg
---

Before Christmas, a group of musicians walked in to the space to talk about designing stage props for their upcoming UK tour.

Up front I'm going to be honest, I had briefly heard of the [Lottery Winners](https://www.thelotterywinners.co.uk/) but 
had no sense of how big the band had become.  [The Lottery Winners](https://en.wikipedia.org/wiki/The_Lottery_Winners) are a local band made good, with a Number 1 album -
 [Anxiety Replacement Therapy](https://en.wikipedia.org/wiki/Anxiety_Replacement_Therapy), and had performed last year at Glastonbury.  They're kind of a big deal.  They asked if we 
could make some stage props for them, giant daisies to be lit with stage lights for their Manchester O2 Apollo gig.

We had been doing work with the CNC recently and I've made a few pieces for stage previously so agreed to draft up some ideas.  
While the band focused on their tour, we worked on designing the props, working with their lighting designer to come up 
with a design compatible with the lights that would be used on stage.

{{< image src="images/fusion_1.jpg" title="Model design in Fusion 360" width="400x" class="is-pulled-left" >}}

{{< image src="images/test_fit.jpg" title="Test fit on head and lighting stand" width="400x" class="is-pulled-right" >}}

Using Fusion 360, we designed a model to be cut on our Shapeoko XXL, and performed some test cuts on 5mm acrylic.  
The outer shape was cut from 5mm opaque white 
and the inner shape from 3mm opaque yellow.  They were bonded using Tensol 70. Using some generic angle brackets, we 
tested the fit on the sample spot head and adjusted the design a bit, the band were happy with the design.

{{< clearfix >}}

{{< youtube UqzpV7Pt8ho >}}


Then the band asked if we could design a portable lighting pack to use on their other tour dates.

We needed a one-size fits all solution.  The same daisies would need to be used for all tour dates, so we needed a system 
that would allow for switching between the portable packs, and the standing lamps.  We agreed to use the same mounting 
hardware - a lighting stand and angle bracket, and switch out the lighting for a portable USB powered LED system.  We also 
needed a system that could be easily charged on tour - regular LiPo battery packs USB charging were ideal, and could be 
replaced on tour if needed.

{{< image src="images/light_pack.jpg" title="Lighting Pack Light Ring and Mount" width="400x" class="is-pulled-left" >}}

We used a [Plasma 2040 board from Pimoroni](https://shop.pimoroni.com/products/plasma-2040?variant=39410354847827) combined with [these WS2812B RGB rings from Cool Components](https://coolcomponents.co.uk/products/241-led-172mm-complete-ring-ws2812b-5050-rgb-led-with-integrated-drivers-adafruit-neopixel-compatible).  We couldn't use all the rings, nor could we power all the LEDs at the same time, so with a bit of careful maths, we worked 
out how many LEDs we could drive from the Plasma and the power supply.  3D printed housings in PETG were attached with magnets 
to the back of a select number of the daisies, allowing the lighting packs to be attached and removed.

Some simple Micropython allowed us to to design a few different lighting patterns controllable from the onboard buttons 
of the Plasma 2040.  I'm quite pleased with the results.

{{< clearfix >}}

{{< youtube EGnIsF4EzsA >}}

For final stage dressing, and to hide cabling, we made green wrap sleeves sleeves for the lighting stands with hook and loop 
closings and an over the top loop to hang from the top of the stand.

These were shipped in two batches, first batch to the band on tour, and then a final delivery to the band at the 
O2 Apollo Manchester.  They very kindly offered us tickets to come and watch, and we made an evening to see the props and the band, 
on stage.

{{< clearfix >}}

{{< image src="images/on_stage.jpg" title="Lottery Winners and Daisies on Stage in Manchester" class="middle" >}}

Leigh Hackspace is open to commissions, and we're also keen on teaching people the skills to make for themselves.

Our [Summer of Making](), has a range of skills that can help get you started, or if 
you have a project in mind, please [come and talk to us](mailto:directors@leighhack.org).

