---
title: "The Hackbots Project II"
subtitle: "Making Simple Robots That Anyone Can Build (Pt. 2)"
date: 2024-03-18T07:40:38Z
tags:
    - Rasberry Pi Pico
    - Robots
    - Electronics
draft: false
author: Paul Williams
author_email: phyushin@gmail.com
listing_image: images/hackbot.jpg
---

## Continuing the Bot Building Process
So, we'll continue from where we left on last a little while ago with our bot building blog [posts][1]. 
We'd got to the MK IV if memory serves... Next on the list of things to do is to make our bot interface page nice and pretty.

## Enter, CSS
Because we're using a very simple webserver on the [Raspbery Pi Pico W][2] and because the code handily returned from our `generateHTML()` function is effectively the page that's served by the websever; we know this is a good place to add a little customisation for our robot - make our page a little _prettier_.

## CodePen
When prototyping, it's always much more satisfying to see the changes happen quickly, as opposed to editing our `generateHTML()` function, uploading to the bot, connecting to our bot, visiting the url... it's a lot of steps - so, to make this a bit easier we're going to use a nice tool called [CodePen][3], our first step is to rip out the HTML from the `generateHTML()` function and paste it into the HTML window, like so:
{{< image src="images/codepen_screenshot.png" title="HTML & CSS editor windows above, results below">}}
The result of the code is shown underneath the HTML and CSS editor windows, We've made a couple of modifications from our original `generateHTML()` function to make it easier to work with CSS:

```python
html = f"""
    <!--Snip-->
    <style>{style}</style>
    <!--Snip-->"""
return html
```

The above code is snipped to keep things simple, but what it does is use python's [_string format_][5] functionality to add the variable `style` with the the style we read into the variable from the `style.css` file (more on that a little later).

We've also moved `generateHTML()` into its own file (`html.py`) and used parameters to drop in from the main program; we import the function into `main.py` by adding the following code to the top of our `main.py`:

```python
from html import generateHTML
```

This allows us to call `generateHTML()` like we did previously, it's just tidied away in its own file now... We've also added the following code to the beginning of the function - which will allow us to use an _exteral_ style sheet (see I told you more on that later):
```python
style = ""
with open("./style.css","r") as f:
    style = f.read()
```
Now, once we're done with making the code look _pretty_ in CodePen we can just drop the code from the _CSS_ window into the `style.css` file and it will make the controller page all nice and pretty too! Great Stuff!

## Paletton
A good place to grab some colours that go well together is [Paletton][3], For the purposes of this guide however we're only going to pick a primary colour but don't let that stop you from adding a little extra _flare_, pick a colour you like the look of like so:
{{< image src="images/paletton1.png" title="Paletton Colour Picker">}}

Then, once you're happy with your colourcscheme - go to the export and select _as CSS_:
{{< image src="images/export_as_css.png" title="Export - listing colours that go well together">}}
Don't worry if the export doesn't work, as all the relevant colour information (Hex values) can be grabbed right off this page too!
You should end up with something like this in your `style.css` file:
```css
:root{
    --color-primary-0 :  #679933 ;
    --color-primary-1 :  #C0E699 ;
    --color-primary-2 :  #90BF60 ;
    --color-primary-3 :  #437313 ;
    --color-primary-4 :  #274D00 ;
    --color-white     :  #ffffff ;
    --color-black     :  #000000 ;
}
button {
    width:175px;
    height:100px;
    background-color: var(--color-primary-0);
    color: var(--color-white);
    font-size:25pt
}
```
Where the `:root` _selector_ contains the variable namnes used for the colours - you don't have to do it exactly like this but it's done here for clarity.

## The generateHTML() function
Once you're finished, you should end up with something like this in your `generateHTML()` function:

```python
def generateHTML():
    style = ""

        with open("./style.css","r") as f:
            style = f.read()
        
        html = f"""<!DOCTYPE html>
        <html>
            <head> 
                <title>Hackspace Bot</title> 
                <style>
                    {style}
                </style>
            </head>
            <body>
                <div>
                    <form action="" method="post">
                    <table class="controller">
                    <tr>
                        <td></td>
                        <td>
                            <button type="submit" formaction="forwards">&#8593</button>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><button type="submit" formaction="left">&#8592</button></td>
                        <td>
                            <button type="submit" formaction="stop">Stop</button>
                        </td>
                        <td>
                            <button type="submit" formaction="right">&#8594</button>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <button type="submit" formaction="backwards" >&#8595</button>
                        </td>
                        <td></td>
                    </tr>
                    </table>
                </div>
                """
        # this bit is for debugging we can remove in finished branch
        html = html + f"""
                <div>
                <table>
                    <tr>
                        <td>SSID</td>
                        <td>PASSWORD</td>
                        <td>IP</td>
                    </tr>
                    <tr>
                        <td>{ssid}</td>
                        <td>{password}</td>
                        <td>{ap.ifconfig()}</td>
                    </tr>
                </table>
                </div>
                </form>
        </body>
            </html>
        """
        return html
```

_Note: we already have the external stylesheet file `stlye.css` generated_ which the code opens and reads the contents into the `style` variable, this, in turn is replaced using python's _format string_ functionality we talked about earlier. We write the code in this way as it allows us to easily change the _style_ of our buttons simply by replacing the colours in the `style.css`

## Finally, secrets.py
The `secrets.py` file is where we, well... store our secrets - sounds pretty obvious right? 
The benefit of doing it this way is that we only need to make changes to the one file and they'll be reflected everywhere, which is a common theme in programming sometimes referred to as the [DRY Principle][6]. 

Our `secrets.py` should look something like this:

```python
secrets = {
    'ssid': 'Hackbots_Demo',
    'pw': 'Really_Insecure_Password!',
    }
```

That's it just a simple [python dictionary][7] in a file! The beauty of this approach is that we can import this file (much like we did with the `html.py`) and access the settings easily, a brief example is shown below:

```python
from secrets import secrets # This imports the `secrets.py` code as `secrets` into the current file
### We can then read the values into variables
### using the 'key' from the dictionary like so:
ssid = secrets['ssid']
password = secrets['pw']
```

Using this approach allows us to make changes to the configuration easily simply by changing the values in the dictionary and saving it to the device. which will help later on!

Once we've saved our configuration and other files, pushed them to the [Pico W][2] we can visit the url (by default it's `http://192.168.4.1`) and we'll see the page we designed earlier all nice and pretty!

Thanks for reading! - Stay tuned for part 3 where we'll go through the wiring up and building of the bot.
PW

[1]: https://www.leighhack.org/blog/2024/the-hackbots-project/ "Original Hackbot Adventures"
[2]: https://www.raspberrypi.com/documentation/microcontrollers/raspberry-pi-pico.html "Raspberry Pi Pico"
[3]: https://codepen.io/pen/ "CodePen"
[4]: https://paletton.com/ "Paletton"
[5]: https://docs.python.org/3/tutorial/inputoutput.html#formatted-string-literals "Format Strings"
[6]: https://en.wikipedia.org/wiki/Don't_repeat_yourself "DRY programming" 
[7]: https://docs.python.org/3/tutorial/datastructures.html#dictionaries "Python Dictionary"