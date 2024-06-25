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
listing_image: images/final_cabinet_full.jpg
---

__This one started out as an idea.__

Dan Hardiker from [Devoxx UK](https://www.devoxx.co.uk/) contacted me with an idea:

> _"We want to make a bunch of games with our sponsors, and play them on a bunch of small arcade cabinets.  But we also want to 
> take the cabinets to a some other events."_

I like small, well defined projects, and this one fitted the bill.  We can do this.

_Small, well defined projects._


Okay.  So first thoughts immediately went to the [Picade](https://shop.pimoroni.com/products/picade).  The Picade is a small arcade cabinet 
from [Pimoroni](https://shop.pimoroni.com/).  It's great, I have one. 
It lives upstairs in my second bedroom, and when I need a bit of quiet time, I use it to play Frogger.  I'm a Frogger demon.

But while it's quite small, it's not easy to store.  It's arcade cabinet shaped, and doesn't pack or stack well.

What if we could build an arcade laptop?  Something that could be folded down between events and stored away easily?

{{< clearfix >}}

{{<image src="images/note-01.png" title="Notebook Sketch 1 - Picade and folding model" width="300x" class="is-pulled-left">}}
{{<image src="images/note-02.png" title="Notebook Sketch 2 - Console and folding case" width="300x" class="is-pulled-left">}}
{{<image src="images/fusion_design_1.jpg" title="Fusion 360 - Initial working concept for folding case" width="300x" class="is-pulled-left">}}

{{< clearfix >}}

When I start a project, I sketch, rather than go straight to CAD.  I like to have ideas on paper, or more recently, 
on digital paper, before I start opening up a CAD program.  It won't be perfect, but I'll have some idea of the shape 
of the thing before I start working through something I plan on making.  CAD software can occassionally be unforgiving, 
and it likes to have a plan of what you want to build.  You can vary that plan - but having at least part of that plan up 
front helps.

We start with a "Picade in a case".  10" screen, Raspberry Pi 4, and an arcade console with a removable stick to allow the case 
to be closed.  Technically it works, and I take it to the team.  It fills the portable part, but doesn't look "Arcade-y" enough.
Fair.  Can we make it look more like an arcade cabinet.

{{< clearfix >}}

{{<image src="images/note-03.png" title="Notebook Sketch 1 - Picade and folding model" width="400x" class="is-pulled-left">}}
{{<image src="images/note-04.png" title="Notebook Sketch 2 - Console and folding case" width="400x" class="is-pulled-left">}}

{{< clearfix >}}

This conversation goes forwards and backwards for a few iterations where we play with bartop designs, etc until we hit 
what they _really_ want.

> "You want full size arcade cabinets, don't you?"

So how do we deliver full size arcade cabinets, that are still ultimately, _portable_ and _storable_.

The answer is you do it in parts.  The idea of "all the bits in the case" still works, somewhere for all the electronics to live.  Monitor, 
Raspberry Pi and controls.  Then we build a separate cabinet for the case to slot in to.  Because our CNC bed is 80cm square, 
the cabinet is split in 2, giving a total height of 1.6m.  Added benefit - if you want a bartop cabinet for some events, you just use 
the top half.  The cabinet slots together like flat pack furniture, using slots and furniture bolts for assembly.  At the 
end of the event, remove the bolts, flatten the case and store between events.


Once we were happy with the general idea, we designed the prototype in Fusion 360, and cut the prototype on our Shapeoko XXL. 
The electronics case is cut from 9mm MDF and the cabinet from 18mm MDF.  The console and display frame are cut from 5mm acrylic. 
Assembly of the electronics case is done with glue, with the console and surround mounted using M3 bolts and self tapping inserts.

{{< clearfix >}}

{{<image src="images/fusion_design_2.jpg" title="Fusion 360 Design - Arcade Cabinet Final" width="300x" class="is-pulled-left">}}
{{<image src="images/cutting_cases.jpg" title="Cutting a side panel on the Shapeoko XXL" width="300x" class="is-pulled-left">}}
{{<image src="images/prototype_case.jpg" title="Testing the prototype - Cat for scale" width="300x" class="is-pulled-left">}}

{{< clearfix >}}

[An archive of the Fusion 360 project is available on Github.](https://github.com/leigh-hackspace/arcade-cabinet)

To kit the electronics, we used an off the shelf monitor - a Cooler Master GA241, a Raspberry Pi 4
running RetroArch, an Sanwa JLF arcade stick modified with a Link EX Groove Quick Release and 10 buttons. The GA241 monitor is powered 
by 12V, which allows us to nicely split a single 12V/4A power supply for monitor and Pi (using a buck converter).

> Note on suppliers: We used Arcade World UK for a large amount of this build, but they appear to have disappeared.  Since 
> the original build, we've been using [Arcade Express](https://www.arcadexpress.com), a Spanish Company.  Import charges 
> may apply when using them.

{{< clearfix >}}

{{<image src="images/wiring_loom.jpg" title="Wiring up the power for the test case" width="400x" class="is-pulled-left">}}
{{<image src="images/wiring_up_case.jpg" title="Testing a nearly finished electronics case" width="400x" class="is-pulled-left">}}

{{< clearfix >}}


The Devoxx UK games were built using [PyGame](https://www.pygame.org/) - [Dan Hardiker](https://twitter.com/dhardiker) came down the weekend before the 
event and spent time getting the games working on the machines.  There's nothing like a deadline.  Running right up 
against it, we painted the cabinets black and drove them down for setup at the Business Design Centre in London.

{{< clearfix >}}

{{<image src="images/primed_cases.jpg" title="Priming upper cabinets for painting" width="300x" class="is-pulled-left">}}
{{<image src="images/case_production_line.jpg" title="Lining up finished cases for wiring" width="300x" class="is-pulled-left">}}
{{<image src="images/loading_cabinets.jpg" title="Loading up flattened cabinets ready for transport" width="300x" class="is-pulled-left">}}

{{< clearfix >}}


They were received well, and performed great for the duration of the event.  Dan and the crew then did exactly what the 
cabinets were designed to do - they removed the electronic cases, removed the bolts, dropped the cabinets flat and packed 
them for the next event.

{{< clearfix >}}

{{<image src="images/cabinets_lined_up.jpg" title="Arcade cabinets assembled" width="400x" class="is-pulled-left">}}
{{<image src="images/cabinets_played.jpg" title="Arcade cabinets being played" width="400x" class="is-pulled-left">}}

{{< clearfix >}}

But we're not quite done.  The event had gone well, but our prototype was still looking ... well, like a prototype.  And 
a Hackspace without an Arcade Cabinet isn't really a Hackspace.  So we recut the side panels to the same profile as the Devoxx cabinets, 
gave ours a lick of paint, and using a Player-X board, some more components and a trackball, added some extra rizz for two player action and more game modes.  

{{< clearfix >}}

{{<image src="images/final_cabinet_full.jpg" title="Our final cabinet - full length shot" width="400x" class="is-pulled-left">}}
{{<image src="images/final_cabinet_console.jpg" title="Up close shot of two player console and trackball" width="400x" class="is-pulled-left">}}

{{< clearfix >}}

It's already been to [Elecromagnetic Field](https://www.emfcamp.org/), where it was used to run [Pico-8](https://www.lexaloffle.com/pico-8.php) games from [Johan Peitz](https://johanpeitz.itch.io/) in the Family Tent, and it'll be making an appearance at the 
[International Discworld Convention](https://dwcon.org/) in August, playing the original Discworld point and click games using [ScummVM](https://www.scummvm.org/).

If you drop by the [Hackspace](/index.md), you're more than welcome to play on it.

Leigh Hackspace is open to commissions, and we're also keen on teaching people the skills to make for themselves.

Our [Summer of Making]({{< ref "/blog/2024/summer-of-making/index.md" >}}), has a range of skills that can help get you started, or if 
you have a project in mind, please [come and talk to us](mailto:directors@leighhack.org).