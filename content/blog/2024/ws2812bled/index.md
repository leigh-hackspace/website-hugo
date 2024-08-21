---
title: "WS2812B LEDs"
subtitle: "Building a solution to make them flash!"
date: 2024-08-21T00:00:00Z
toc: false
tags:
  - 2812b
  - led
  - cost effective
draft: false
author: Andrew K
author_email: leighhack@shamrock.org.uk
listing_image: images/IMG_3496.jpg
---
I wanted to understand how to make WS2812 LEDs work but also within the Hackspace I found some PICs. I had used something similar many years ago, but this was a completely new learning curve!

# 2812 LEDS and how they work

There are many many write ups about how 2812 LEDs work, so rather cover much of that I will just outline the basics to get things going.

The [WS2812B DataSheet](/images/WS2812B.pdf) outlines the timings, but to make life easier the basics are as follows :

A simple bit shift register configuration , each LED can have 3 colours, order as green, red and blue. Each colour has 8 bits for brightness.

In order to send the correct configuration the following timings apply :

A total of 1us per bit should be used, but see the observation below.

To send a 0, a signal should be held high for between 0.250us (250ns) and 0.550us (550ns), and then low for between 0.700us(700ns) and 1us (1000ns)
To send a 1, a signal should be held high for between 0.650us (650ns) and 0.950us (950ns), and then low for between 0.300us(300ns) and 0.450us (450ns)

In order for the LEDs to show the applied configuration the signal should be held low for ~50us.

An observation that can be made is the low part of the signal can be much longer than the specification as it will only reset (so show the LED configuration) with a long delay.

To make one LED show GREEN, the following would be sent, with the correct timing.

1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 <50us>

# The PICs and Programmer

I found some interesting development tools in the Hackspace and decided to go down the route of attempting to use them.

{{< bgallery width="90" >}}
{{< fimage src="images/IMG_3500.jpg" width="300" height="200" float="inline-block">}}
{{< fimage src="images/IMG_3498.jpg" width="300" height="200" float="inline-block">}}
{{< /bgallery >}}

This was immediately hit by a brick wall, that the PIC programmer is now considered so old it is no longer supported by any of the actual development tools. I could install Windows XP and get it working but that brings many more problems than I wanted.

# An up to date Programmer

I decided to get a PIC Kit 5 programmer, and as it happens they were on sale so 1/2 price.

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3494.jpg" width="500" height="400" float="inline-block">}}
{{< /bgallery >}}

You can also get a slightly different approach using a programmer from here [USBProg2](http://www.embedinc.com/products/usbprog2/)

The PIC Kit programmer does integrate seamlessly into all the PIC IDE tools, whereas the USBProg2 is very manual, but can still use the output from the PIC IDE tools, so the choice is to the reader.

# MPLAB X IDE

I installed [MPLAB X IDE](https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide) which was a little painful as there was some random 'free' license I had to get and then the tool asked if other elements needed to be installed. I am not going through the installation of this. I discovered lots and lots of YouTube/Maker Space tutorials on it which is for the reader to go through.

It did recognize my PIC Kit 5 which is now has a selected programmer.

One element of setting up the programmer that does warrant mentioning is the cabling that comes with it is poor. I have put together some breadboard jumper cables and a cable tie to keep it neat. You can buy and additional interface but at the time of writing was more than the programmer which seems odd.

I ended up with

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3495.jpg" width="500" height="400" float="inline-block">}}
{{< /bgallery >}}

It is a little hackey and I may do something better in the future but for my purposes right now, works!

# Choose a PIC

After a little bit of research I decided to use a PIC16F1613. It is a relatively simple part and has all the parts needed to get things going quickly. It has a built in clock, 16k of programmable space, 2k of RAM and perfectly capable of doing what I wanted.

When I set up the MPLab X IDE with the part I ended up with a configuration screen as follows

{{< bgallery width="80" >}}
{{< fimage src="images/mplabxbaseinstall.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}

As you can see from the screen shot above, the internal clock is set to 16Mhz and I have set RC0 as an output pin. You do need to be careful with the PIN selection as some of the RA pins are needed for programming so staying away from them makes life much easier. I can leave the programmer connected while testing the output!

# First experiments with the PIC

In order to figured out what we need to do with the PIC I used an Oscilloscope and connected it to the output of the PIC (pin 10/RC0).

The scope was a UTD2026C as pictured.

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3501.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}

The default code created by the MPLAB X IDE for a new project includes a file called main.c. In this file there is a function called main(void). It is shown below 

```
int main(void)
{
    SYSTEM_Initialize();
}
```

There may be other lines within your output, but should be commented out and be grey.

In order to toggle the output pin on and off the following code can be used

```
    LATCbits.LATC0 = 0;
```

If you set it to 0, the output is off, if you set it to 1, the output is on.

To determine how fast we can toggle the pin on/off we first need to add some code to the main(void) so it would become

```
int main(void)
{
    SYSTEM_Initialize();
	while (1)
	{
		LATCbits.LATC0 = 1;
		LATCbits.LATC0 = 0;
	}
}
```

By the default the pin is off, so we first enable the output and then disable the output, the PIC then just does this continuously.

The output from the Oscilloscope is shown

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3482.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}

With the scope set to 200ns per segment you can see the rise/fall of the output is ~250ns. This is immediately within the timing for sending a 0. However we also need to look at the gap to the next rise/fall to make sure we are not exceeding 50us.

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3483.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}

The gap between two rise and falls is 2000ns (2us) so does fall within out 50us delay.

We now need to determine how to keep the pin high for longer. There are various ways to do this, however the simplest is to just set the pin high again, so our code now changes to

```
int main(void)
{
    SYSTEM_Initialize();
	while (1)
	{
		LATCbits.LATC0 = 1;
		LATCbits.LATC0 = 1;
		LATCbits.LATC0 = 0;
	}
}
```

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3503.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}

This is really close and gives ~500ns. We need at least 550ns to make sure we are within tolerance of the specifications.

Then we changed to

```
int main(void)
{
    SYSTEM_Initialize();
	while (1)
	{
		LATCbits.LATC0 = 1;
		LATCbits.LATC0 = 1;
		LATCbits.LATC0 = 1;
		LATCbits.LATC0 = 0;
	}
}
```

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3502.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}

This provided the output we need for a 1 bit set, it is approx 750ns. 

Now we have both ways to set for a long (one) and a short(zero), for the output.

To make life much simpler to set these I created two functions (placed before the main(void) function).

```
void longPulse(void)
{
    LATCbits.LATC0 = 1; 
    LATCbits.LATC0 = 1;
    LATCbits.LATC0 = 1;
    LATCbits.LATC0 = 0;
}

void shortPulse(void)
{
    LATCbits.LATC0 = 1;
    LATCbits.LATC0 = 0;
}
```

# Make a LED a different colour

Now it appears we have the timing correct we need to try and set the different colours for the first LED. It is important to remember that the LED colours are green, red, blue, so we will try them in order one at a time. This also sets a very long delay of 50ms, well beyond the 50us required in order to trigger the configuration to be delayed.

```
int main(void)
{
    SYSTEM_Initialize();
	while (1)
	{
		// Green 8 bits set to 1
		longPulse();longPulse();longPulse();longPulse();
		longPulse();longPulse();longPulse();longPulse();

		// Red all bits set to 0
		shortPulse();shortPulse();shortPulse();shortPulse();
		shortPulse();shortPulse();shortPulse();shortPulse();

		// Blue all bits set to 0
		shortPulse();shortPulse();shortPulse();shortPulse();
		shortPulse();shortPulse();shortPulse();shortPulse();
		
		__delay_ms(50);
	}
}
```

This then gives us the output on a LED of green

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3480.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}

I then cycled through the different options, so red

```
int main(void)
{
    SYSTEM_Initialize();
	while (1)
	{
		// Green 8 bits set to 0
		shortPulse();shortPulse();shortPulse();shortPulse();
		shortPulse();shortPulse();shortPulse();shortPulse();

		// Red all bits set to 1
		longPulse();longPulse();longPulse();longPulse();
		longPulse();longPulse();longPulse();longPulse();

		// Blue all bits set to 0
		shortPulse();shortPulse();shortPulse();shortPulse();
		shortPulse();shortPulse();shortPulse();shortPulse();
		
		__delay_ms(50);
	}
}
```

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3484.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}

Now finally blue

```
int main(void)
{
    SYSTEM_Initialize();
	while (1)
	{
		// Green 8 bits set to 0
		shortPulse();shortPulse();shortPulse();shortPulse();
		shortPulse();shortPulse();shortPulse();shortPulse();

		// Red all bits set to 0
		shortPulse();shortPulse();shortPulse();shortPulse();
		shortPulse();shortPulse();shortPulse();shortPulse();

		// Blue all bits set to 1
		longPulse();longPulse();longPulse();longPulse();
		longPulse();longPulse();longPulse();longPulse();
		
		__delay_ms(50);
	}
}
```

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3485.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}

# Limitations of a PIC

I was then interested in making a 144 LED strip working with different colours. In modern computing you can just memory and allocate it based on your needs, and in this case would be 3 bytes x 144 which is 432 bytes. However with the PIC chosen it only has 2k of RAM of which most - 1500 bytes - is used when initializing the program and other variables needed.

In order to cope with the lack of memory I decided that a small buffer of 72 bytes would suffice, which is 24 LEDs, which can then be replicated across the number of LEDs required.

The code I came up with was as follows

```
void longPulse(void)
{
    LATCbits.LATC0 = 1; 
    LATCbits.LATC0 = 1;
    LATCbits.LATC0 = 1;
    LATCbits.LATC0 = 0;
}
void shortPulse(void)
{
    LATCbits.LATC0 = 1;
    LATCbits.LATC0 = 0;
}
void ws_sendsingle_byte(unsigned char byte)
{
    if ( byte & 0b10000000) { longPulse(); }
    else { shortPulse(); }
    if ( byte & 0b01000000) { longPulse(); }
    else { shortPulse(); }
    if ( byte & 0b00100000) { longPulse(); }
    else { shortPulse(); }
    if ( byte & 0b00010000) { longPulse(); }
    else { shortPulse(); }
    if ( byte & 0b00001000) { longPulse(); }
    else { shortPulse(); }
    if ( byte & 0b00000100) { longPulse(); }
    else { shortPulse(); }
    if ( byte & 0b00000010) { longPulse(); }
    else { shortPulse(); }
    if ( byte & 0b00000001) { longPulse(); }
    else { shortPulse(); }
}
int main(void)
{
    SYSTEM_Initialize();
     
    int ledCount = 144;
    int ledCountMaxMem = 72;

    int ledCountCol = ledCount * 3;
    char ledCountArray[72];
      
    // init srand
    srand(40);
    
    // clear all LEDs
    for ( int o = 0 ; o < ledCount*3; o++)
    {
       ws_sendsingle_byte( 0b00000000 );
    }
    __delay_ms(50);
	
	while(1)
    {
        for ( int l = 0 ; l < ledCountMaxMem ; l+=3 )
        { 
           ledCountArray[(l)] = (rand()&0x0f);
           ledCountArray[(l)+1] = (rand()&0x0f);
           ledCountArray[(l)+2] = (rand()&0x0f);
        }
        int d = 0;
        for ( int o = 0 ; o < ledCountCol; o++)
        {
            ws_sendsingle_byte( ledCountArray[d] );
            d++;
            if ( d > ledCountMaxMem-1 )
               d = 0;
        }   
        __delay_ms(50);
    }
}
```
This code uses a 72 byte array to handle any number of LEDs. The colours do repeat but it does give the impression of randomness. As the routine does one less than the byte size, it is an odf number so shifts the repeating pattern by one byte, thus ensuring no obvious repeating pattern.

The output can be seen here

{{< bgallery width="60" >}}
{{< fimage src="images/IMG_3504.jpg" width="600" height="500" float="inline-block">}}
{{< /bgallery >}}
