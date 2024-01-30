# Leigh Hackspace Website - Hugo Edition

Hugo version: 0.122

## Dev Mode

To run the site locally you can do the following:

* Download [Hugo extended edition](https://github.com/gohugoio/hugo/releases/) (named hugo_extended).
* Check out repo
* Run `hugo serve -D --gc -w -F` (add -F to show content with future dates)
* Goto `http://localhost:1313/`

The site will be updated in realtime with any changes made to the site.

## New Blog Post

* Download and install Hugo
* Run `hugo new blog/<year>/name-of-post/index.md`, and a new file will be created in the right folder.
* Update the `author` and `author_email` values
* Add a `subtitle`
* Run Dev Mode (above), or `make serve` and view your post. 