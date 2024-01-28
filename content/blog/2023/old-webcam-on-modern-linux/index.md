---
title: "Using an old webcam on modern Linux"
subtitle: "Andrew works on re-using an ancient webcam"
date: 2023-06-28T08:28:12+01:00
draft: false
toc: false
tags: 
  - linux
  - webcam
  - raspberry pi
author: Andrew Williams
author_email: andy@tensixtyone.com
listing_image: camera.png
---

{{< image src="camera.png" width="400x" class="is-pulled-right" title="The Trust WB-1200P, a webcam from the early days of USB devices.">}}

Linux is known for its good hardware support of even ancient pieces of kit. From time to time the kernel devs deprecate drivers and architectures that are no longer supported, but for the most part, you can pick up an old piece of hardware and get it running on a major release or two from the current mainline.

Yesterday I attempted this. At [Leigh Hackspace](https://leighhack.org) we wanted a webcam on our out-of-band access box so we could look at the status of the rack without visiting the space. After having a dig around our electronics area I found a box of old [Trust WB-1200P](https://www.trust.com/en/product/13405-mini-webcam-wb-1200p) webcams, they're from 2009 and barely scrape out at 0.1 megapixels, but they should be good enough to see the blinkenlights in the rack to see if we have an issue (e.g. a server doesn't have power).

I grab one, plug it into the Raspberry Pi running the latest, Debian 11, Raspian and it has detected and loaded drivers! It _worked_?

The Trust WB-1200P is a re-badged [Pixart Imaging Inc.](https://www.pixart.com) PAC207, a pre-UVC (USB Video Class) webcam that is part of the `gspca` driver set in the kernel. Support for it is included in the current kernel release, and it supports V4L2 (Video for Linux v2). But, getting it to load a driver is only the first step of the battle. Pre-UVC devices are known for having their special quirks and issues, usually related to the pixel formats, video formats, and resolutions they output. 

While backward-compatible kernel drivers are there, application support moves on. Most of the V4L2 tools I attempted to use would either throw an error, crash or cause the driver to spit out some errors into `dmesg`

```
[39011.323706] gspca_main: set alt 0 err -32
[39011.323771] pac207 1-1.2:1.0: submit int URB failed with error -2
[39181.529143] Transfer to device 5 endpoint 0x5 frame 1542 failed - FIQ reported NYET. Data may have been lost.
[39191.828144] Transfer to device 5 endpoint 0x5 frame 1601 failed - FIQ reported NYET. Data may have been lost.
[39450.446323] gspca_main: set alt 0 err -22
[39454.058295] gspca_main: pac207-2.14.0 probing 093a:2468
```

Most applications expect 'YUV' or Motion JPEG, which are common on the standardised UVC devices but neither is supported on this camera. I attempted to Google the camera's model to try and find some more information, then tried Github to see if anything caught my eye.

```c
#define V4L2_PIX_FMT_SPCA508  v4l2_fourcc('S', '5', '0', '8') /* YUVY per line */
#define V4L2_PIX_FMT_SPCA561  v4l2_fourcc('S', '5', '6', '1') /* compressed GBRG bayer */
#define V4L2_PIX_FMT_PAC207   v4l2_fourcc('P', '2', '0', '7') /* compressed BGGR bayer */
#define V4L2_PIX_FMT_MR97310A v4l2_fourcc('M', '3', '1', '0') /* compressed BGGR bayer */
#define V4L2_PIX_FMT_JL2005BCD v4l2_fourcc('J', 'L', '2', '0') /* compressed RGGB bayer */
```

The first thing to stand out from the file is `V4L2_PIX_FMT_PAC207`; That so happens to have the same name as the model of the webcam. In this case, the PAC207 has its special pixel format that the application you wish to use needs to understand and handle.

Further digging using this value directed me to a configuration file for [Motion](https://motion-project.github.io), a relatively old but well-maintained application for motion detection and streaming webcams:

```shell
# V4L2_PIX_FMT_MJPEG then motion will by default use V4L2_PIX_FMT_MJPEG.
# Setting v4l2_palette to 2 forces motion to use V4L2_PIX_FMT_SBGGR8
# instead.
# V4L2_PIX_FMT_SGRBG8  : 5  'GRBG'
# V4L2_PIX_FMT_PAC207  : 6  'P207'
# V4L2_PIX_FMT_PJPG    : 7  'PJPG'
```

As it turns out Motion does exactly what I needed it to do; stream a camera over HTTP so we can look at it remotely. A win-win. I installed Motion, added `v4l2_palette 6` to the configuration file, started up the daemon and hit the URL, it loaded and.... showed a green image and more `dmesg` errors.

As it turns out, not everything is still compatible. the `pac207` driver is a V4Lv1 type driver rather than V4L2 which the application supports. Thankfully, the V4L2 developers provide a compatibility library that can be loaded using `LD_PRELOAD` to fix the major issues. `LD_PRELOAD` allows you to pre-load a library into an application and is commonly used to override functionality or patch issues in applications. In this case, the library we'll be providing is a bit of code to allow V4L2 to use V4L1 devices and code.

First, we need to install the package `libv4l-0` library on Debian, which provides the compatibility library, then using a `systemd` service override I was able to insert the environment variable into the startup:

**/etc/systemd/system/motion.service.d/overrides.conf**
```
[Service]
Environment=LD_PRELOAD=/usr/lib/arm-linux-gnueabihf/libv4l/v4l1compat.so
```

Run `systemctl daemon-reload`, restart the service and...

{{< image src="stream.jpeg" title="A blurry image from the webcam">}}

OK, the camera is 0.1 megapixels, and probably not focused correctly as it doesn't have autofocus, but it is working at last. 
