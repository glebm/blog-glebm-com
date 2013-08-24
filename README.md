### Workflow

* `middleman` to start development server
* `middleman article TITLE` to generate a new article
* `rake build` to test build
* `rake publish` to publish (builds and pushes to gh-pages branch on origin)

### Forking 

After cloning your fork run:

    # remove all existing posts:
    rm -f source/2*.markdown.erb 
    git add -u
    git commit -m "remove @glebm's posts"
    
You must change the following files with your data:

    * `data/disqus.yml` 
    * `data/google_analytics.yml`
    * `source/CNAME` -- remove, or change contents to your CNAME (this is for gh-pages)

The rest of the settings are in other files in `data/`. See `config.rb` for advanced configuration.
  
To update to the latest upstream with:
  
    # add upstream -- only need to do this once 
    git remote add upstream https://github.com/glebm/blog-glebm-com
    # pull upstream changes, and apply your changes on top
    git pull --rebase upstream/master
