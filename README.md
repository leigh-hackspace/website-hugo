# Leigh Hackspace Website - Hugo Edition

Hugo version: 0.122

## Dev Mode

To run the site locally you can do the following:

* Download [Hugo extended edition](https://github.com/gohugoio/hugo/releases/) (named hugo_extended).
* Check out repo
* Run `hugo serve -D --gc -w -F` (add -F to show content with future dates) or `make serve` (if you have `make` installed)
* Go to `http://localhost:1313/` to view the local instance.

The site will be updated in real-time with any changes made to the site.

## Making Changes

All changes to the website must be done on a branch and pushed through the GitHub pull requests workflow. If you have any questions about this process then contact the [Tech Infrastructure](https://wiki.leighhack.org/membership/useful_contacts/#tech-infrastructure) people.

## Deployment

Branches are automatically deployed to [https://web-test.leighhack.org](https://web-test.leighhack.org) with subfolders for each of the branches in the repository. Once merged into `main` it'll be deployed out to the live website.

## Common Tasks

### New Blog Post

* Download and install Hugo
* Run `hugo new blog/<year>/name-of-post`, and a new folder will be created in the year folder with a `index.md` with the post.
* Update the `author` and `author_email` values
* Add a `subtitle`
* If you've posted the blog elsewhere, add the `original_url` value to link to your original post URL.
* Place any images in the folder that was created for your post.
* Set `listing_image` to the image you'll want on the blog listing page ([https://www.leighhack.org/blog/](https://www.leighhack.org/blog/))
* Run Dev Mode (above), or `make serve` and view your post. 

### Updating Membership Plans

The membership plan data is held in a YAML file, this is used by the Hackspace API and other tools as well.

* Edit [data/memberships.yaml](data/memberships.yaml), following the format of existing entries.
* Links are standard URIs and can support any of the normal formats (mailto:, etc).
  