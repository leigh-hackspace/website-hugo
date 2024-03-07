---
title: "How to get 120 disks into a single chassis"
subtitle: "Building a NAS from an old chassis"
date: 2024-03-04T00:00:00Z
toc: false
tags:
  - hardware
  - nas 
  - low Power
  - cost effective
  - large storage
draft: true
author: Andrew K
author_email: leighhack@shamrock.org.uk
listing_image: images/IMG_2905.jpg
---
As it turns out this is a little more complicated than I expected, even when you start with a larger chassis. My drive to do this, a combination of power requirements, storage space and actually can it be done!

# The Chassis

I have several of these from an older project

{{< image src="images/IMG_2991.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}
{{< image src="images/IMG_2992.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}
{{< image src="images/IMG_2993.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

These are 4RU in height, wide and deep enough to sit on a 19" rack shelf and cabinet and are quite old now, >10 years. They were bought for a project which did not get much passed the 
development stage.

They came from here [BackBlaze](https://www.backblaze.com/blog/petabytes-on-a-budget-how-to-build-cheap-cloud-storage/) and I believe you can still order the chassis although no longer sold as a working solution, such that you have to outfit them yourself.

I have put them on ebay on more than one occasion but never got the price I thought they were worth, so just kept them. In all seriousness I probably should have sold them, however I have 3 that were fitted out and 2 empty chassis. There are some covers missing from one, but I digress a litle.

If you open the large cover you find it has a location for 3 1/2 45 disks, see the link above, it goes into plenty of detail.

{{< image src="images/IMG_2994.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

The drives sit in the grid and the vibration of the disks spinning is dampened by some rubber bands, you can see a couple in the picture.

The drives are hot swappable and plug directly into a PCB, of which there are 9, each controlling 5 drives. The controller cards are actually just SATA port expanders, and in comparison to many port expanders work relatively well. 

{{< image src="images/IMG_2996.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}
{{< image src="images/IMG_2997.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

Unfortunately these can not be re-used in this project as we need the locations they are in to put new disks, and more of them. One thing these do provide are the screw locations for the underneath. To be discussed more later.

{{< image src="images/IMG_2998.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

## Starting from empty

I stripped out all the port expanders and all wiring to go with them and you can see it here, so just an empty chassis

I left the nylon posts in place as they are threaded and allow the nylon screws, they were holding in the port exanpders, to be used.

If you do have one of these chassis and need the nylon posts they are

{{< image src="images/IMG_2999.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

The screws are

{{< image src="images/IMG_3001.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

Both of these are still available to buy.

{{< image src="images/s-l1600.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

## What components do I have

I am going to reuse the motherboard and as many components, fans, cables etc as possible. The motherboard is a supermicro X9SAE-V. 

{{< image src="images/IMG_3010.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

It has 6 PCI slots , on board HDMI and dual GigE, it is old, but will at least get things going.

After boot it shows the CPU is an old i5

This is not going to set the world on fire with CPU capabilities but should be enough to make it work without spending too much money. This is after all a project rather than anything to be used in production (yet!)

So at this point we have a working motherboard, a case, locations for a PSU and drive bay location.

{{< image src="images/IMG_3009.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

We also have 3 of these

Nothing amazing, but simple 4 port SATA controllers.

# Comparing drive sizes

Next I started to look at the size of the drives. I wanted to move away from spinny disks, power, noise, heat the primary factors but also fully loaded is very heavy!

So to keep things compact SSD form factor 2 1/2 is the way to go.

{{< image src="images/IMG_3005.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}
{{< image src="images/IMG_3004.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

Let's compare the sizes

{{< image src="images/IMG_2497.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

I created a 3d printed flat platform that the drives could stand on, just to test out how many seemed reasonable

# Cabling

At this point I realized the cabling would not fit under the platform, so any new location for the drives would either need to be custom with driver chip (like the previous items) or just connectors with drivers elsewhere, but also with the SSDs being smaller (hence shorter) there is now more room to move things upwards, as it turns out about 35mms of room.

I then 3d printed a mask, that would allow me to use the nylong screws into the positions in the chassis but also allow me to add additional holes for anything I wanted to attach, so removing the need to match holes but allow me to extend upwards

{{< image src="images/IMG_3011.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

# Drive capacity

Now to get more drives into the chassis, I initially went for 10 drives , instead of 5 per location. This then required the use of port expanders, so I bought a few of these.

As it turns they are little rubbish. Not because they do not work, or that they are insanely slow but if you buy them from anywhere the heatsink is stuck in place with some kind of double sided heat resistance tape, which transfers little heat to the heatsink. This causes them to restart regularly when in use, rendering them next to useless.

{{< image src="images/IMG_3012.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

If you remove the heatsink, apply heat and it will come off

Then if you put it back with heat transfer epoxy, it will stop restarting, but remains incredibly slow!

But I did push on and get it going

{{< image src="images/IMG_2719.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

I got some custom PCBs made from PCBWay

{{< image src="images/IMG_2575.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

Nothing clever, just locators for the connectors , nothing active. Then then came up with a design to have the port expanders underneath, so two per location, giving 10 drives.

{{< image src="images/IMG_2721.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

and then with the PCB in place As you can see, it kind of fits ? 

{{< image src="images/IMG_2752.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

So in my wisdom I thought I could fit more connectors on the PCB, so I went for 14 drives per PCB

Two rows of 7, I would have two port expanders underneath and using some method not determined find a location for a 3rd one. If I have 9 slots, 14 x 9 = 126 , so I get to my goal with a few to spare!
