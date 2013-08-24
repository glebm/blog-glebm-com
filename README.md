### Workflow

* `middleman` to start development server
* `middleman article TITLE` to generate a new article
* `rake build` to test build
* `rake publish` to publish (builds and pushes to gh-pages branch on origin)

### Forking

When forking, change the following files to your data:

* `data/*.yml` (esp. disqus.yml and google_analytics.yml)
* `source/CNAME` -- remove, or change contents to your CNAME (this is for gh-pages)

After cloning your fork run:

    # remove all existing posts:
    rm -f sources/2*.markdown.erb 
    git add -u
    git commit -m "remove glebm's posts"
  
To update to the latest upstream with:
  
    # add upstream -- only need to do this once 
    git remote add upstream https://github.com/glebm/blog-glebm-com
    # pull upstream changes, and apply your changes on top
    git pull --rebase upstream/master
