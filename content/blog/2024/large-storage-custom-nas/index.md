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

{{< image src="images/IMG_2780 (1).jpg" width="150x" class="is-pulled-right" height="200x" title="">}}
{{< image src="images/IMG_2779 (1).jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

So a completed PCB 

It is a very simple design, two locations to power the drives and then pass through connectors for SATA

{{< image src="images/IMG_2762 (1).jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

Then I wired it up with the SATA cables I had

It looks pretty, and did work, 20 drives and a boot drive, so 21 drives.

At this point, which was quite a bit of work, I realized with much distress, it was slower than a snail, at one point I was getting an underwhelming 10Mb/s !!!

# The current status

```
- Three PCBway prototypes ( one not mentioned here was a disaster )
- Multiple port expanders ( 5 in total, after destroying one  )
- Not solving the space problem for an additional 3rd port expander use
- Lots of SATA cabling, testing
- OS install, re-install, RAID testing, multiple controller etc etc
- Very slow performance 
```

# A regroup and what to do next


The final design of the PCB , 2 x 7 slots I was keeping, even if I did not use all the locations, it works, there are air flow cut outs. It also now matches  the mask to connect to the chassis. 

I now need to find a solution to control a large number of disks, without breaking the bank and also consider how would cabling work for all the drives

If you look at this motherboard it is 2 x 1x and 1 x 2x and 3 x 4x PCIE interfacers so options are limited on the number and type of interface cards.

There are multiple SATA cards that provide good 8x SATA interfaces such as this [StarTech](https://www.startech.com/en-gb/cards-adapters/8p6g-pcie-sata-card)

it's a fast card, does the job well, so with 3 of these in I get 24 ports. Alas not getting me close to the 120 I wanted, so no real use.

# Time to go SAS

{{< image src="images/s-l1600 (1).jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

SAS cards are incredibly cheap and relatively quick and compatible with SATA drives, not to be confused with SAS drives ARE NOT compatible with SATA controllers. This one is goes for about $30 and has 2 ports on board.

{{< image src="images/s-l1600 (2).jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

To make the best use out of it you also need to expand the number of ports available, which is where this card comes in.

It is an Intel RES2SV240 RAID card. It is not really a RAID card in this case, but provides 24 ports, of which 4 are inbound and 20 outbound. This card is relatvely good as you can then use SFF8087 cables to SATA ports, keeping the cabling manageable, rather than individual SATA cables

So let's do the maths

- SAS card - 2 physical ports
- Intel RES240 - 20 outbound ports, so based on the LSI card , 2 of these connected per LSI card = 40 ports

So three (3) LSI cards and 6 RES240 cards = 120 ports. We are there.

{{< image src="images/s-l1600 (2).jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

Even better the RES240 cards do not actually need to plug into the motherboard, they just need power and are fitted  with an external power socket!!!

- This is an amazing win.
- I started the build out as follows

{{< image src="images/IMG_2790.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}
{{< image src="images/IMG_2800 (1).jpg" width="150x" class="is-pulled-right" height="200x" title="">}}
{{< image src="images/IMG_2804.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}


Add some drive location testing

{{< image src="images/IMG_2883.jpg" width="150x" class="is-pulled-right" height="200x" title="">}}

It is brilliant what could go wrong!

As it turns out ... there is always something!

When I added an additional 14, the SAS controller only showed 24, but 14 + 14 = 28

It turns out SAS controller cards do not have an unlimited number ports, they can only service 24 drives per card! Some mention 16 , some 32, all the ones I bought that touted different numbers, the upper limit was always 24.

The best we can do with 3 controllers is then 72 drives ( 1 RES240 card + other physical port to 4 drives ). 

Close but not yet 120 drives - ARG!!!!!

