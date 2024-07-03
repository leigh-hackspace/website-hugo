# Leigh Hackspace Website - Hugo Edition

Hugo version: 0.124.1

## Contributing

Looking for something to contribute to the website? Check out the ["Good First Issues"](https://github.com/leigh-hackspace/website-hugo/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) tag in the Issues section for tasks that are simple, but need doing.

All changes to the website must be done on a branch and pushed through the GitHub pull requests workflow. If you have any questions about this process then contact the [Tech Infrastructure](https://wiki.leighhack.org/membership/useful_contacts/#tech-infrastructure) people.

### Build the site locally

To build the site locally you can do the following:

* Download [Hugo extended edition](https://github.com/gohugoio/hugo/releases/) (named hugo_extended).
* Check out repo (`git clone https://github.com/leigh-hackspace/website-hugo`)
* Run `hugo serve -D --gc -w -F` (add -F to show content with future dates) or `make serve` (if you have `make` installed)
* Go to `http://localhost:1313/` to view the local instance.

The site will be updated in real-time with any changes made to the site files.

## Deployment

Branches are automatically deployed to [https://web-test.leighhack.org](https://web-test.leighhack.org) with subfolders for each of the branches in the repository. Once merged into `main` it'll be deployed out to the live website.

## Common Tasks

### How do I add images to posts / What custom shortcodes are available?

We have a few shortcodes that you can use:

#### `image`

`image` adds a image and manages the sizing and formatting. 

```
{{< image src="netatalk.png" width="400x" class="is-pulled-right" title="The Netatalk logo.">}}
```

* `src` - The name of the image file, this can be a PNG, JPEG, or WEBP, the path is relevant to the file you're adding it into.
* `class` - Is a CSS class that'll be applied to the `figure` created to show this image, common ones are `is-pulled-left` and `is-pulled-right`, more can be found in the [Bulma helpers](https://bulma.io/documentation/helpers).
* `title` - This is the title and alt text used for the image.
* `width` - The maximum dimensions of the image, this can be used in a few ways, either defining just the width (`400`), defining scaling to a width `400x`, or a specific width and height (`400x600`). Ideally try to use `400x` to keep image scaling working as expected.

#### `gallery`

`gallery` surrounds a group of image tags and makes a rotating gallery of the images:

```
{{< gallery >}}
{{< image src="network-browser.jpg" title="Mac OS 9.2.2 'Network Browser' showing the 'nas-afp' service available via AFP over AppleTalk.">}}
{{< image src="osx-finder.png" title="Mac OS X 10.4 Finder showing the 'nas-afp' service available via AFP over TCP/IP.">}}
{{< image src="sonoma-finder.png" title="macOS Sonoma Finder showing the 'nas-afp' service available via AFP over TCP/IP.">}}
{{< /gallery >}}
```

#### `rawhtml`

`rawhtml` can be used to inject HTML from your Markdown post into the finished page. **It is really not advised to do this, the retro theme will ignore any HTML in these tags**.

For example, this is used on the map page to inject the `div` required to render to OpenLayers map:

```
{{< rawhtml >}}
<div id="map" class="map"></div>
{{</ rawhtml >}}
```

### How to create a new blog post

* Download and install [Hugo](https://github.com/gohugoio/hugo/releases/) (the extended edition)
* Run `hugo new blog/<year>/name-of-post`, and a new folder will be created in the year folder with a `index.md` with the post.
* Update the `author` and `author_email` values
* Add a `subtitle`
* If you've posted the blog elsewhere, add the `original_url` value to link to your original post URL.
* Place any images in the folder that was created for your post.
* Set `listing_image` to the image you'll want on the blog listing page ([https://www.leighhack.org/blog/](https://www.leighhack.org/blog/))
* Run Dev Mode (above), or `make serve` and view your post. 

### How to update the membership plans

The membership plan data is held in a YAML file, this is used by the Hackspace API and other tools as well.

* Edit [data/memberships.yaml](data/memberships.yaml), following the format of existing entries.
* Links are standard URIs and can support any of the normal formats (mailto:, etc).
  
