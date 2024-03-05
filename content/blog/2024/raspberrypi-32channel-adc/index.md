---
title: "Creating a 32 Channel ADC for Raspberry PI"
subtitle: "My first entry into create a Raspberry PI HAT"
date: 2024-03-04T00:00:00Z
toc: false
tags:
  - hardware
  - raspberry pi
draft: true
author: Andrew K
author_email: leighhack@shamrock.org.uk
listing_image: images/finished_hat.jpg
---
Over the last 12 months I had been looking at building a hydroponics set up using the Raspberry PI. I wanted a cost effective and repairable solution for handling soil/moisture measurements. 

There of course many HATs already available which solve many problems, but after quite a bit of research found that the HATs available severly restricted the capability of the PI and increased costs should I ever want to scale up.

## Starting simple

I initially started very simply by looking at some of the solutions available and found several options, the simplest was this module [Gravity: I2C ADS1115 16-Bit ADC Module
](https://thepihut.com/products/gravity-i2c-ads1115-16-bit-adc-module-arduino-raspberry-pi-compatible)

{{< image src="images/adc_i2c.jpg" width="150" height="200" title="">}}

It is not too expensive, although buying multiple soon adds up. It can service 4 analogue inputs and you can put up to 4 ( two I2C bus on the Raspberry PI and two per bus ).

I did also purchase this sensor [Gravity: Analog Waterproof Capacitive Soil Moisture Sensor](https://thepihut.com/products/gravity-analog-waterproof-capacitive-soil-moisture-sensor) 

{{< image src="images/moisture_sensor.jpg" width="150" height="200" title="">}}




