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

