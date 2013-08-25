### Forking

After cloning your fork run:

    # remove all existing posts:
    rm -f source/2*.markdown.erb
    rm -rf source/images/2*/
    git add -u
    git commit -m "remove @glebm's posts"
    
You must change the following files with your data:

* `data/disqus.yml` -- remove or change disqus key
* `data/google_analytics.yml` -- remove or change analytics account id
* `source/CNAME` -- remove file or change to your CNAME (this is for gh-pages)

The rest of the settings are in other files in `data/`. See `config.rb` for advanced configuration.
  
To update to the latest upstream with:
  
    # add upstream -- only need to do this once 
    git remote add upstream https://github.com/glebm/blog-glebm-com
    # pull upstream changes, and apply your changes on top
    git pull --rebase upstream/master


### Workflow

* `middleman` to start development server
* `middleman article TITLE` to generate a new article
* `rake build` to test build
* `rake publish` to publish (builds and pushes to gh-pages branch on origin)


#### Syntax Highlighting

In the article's .markdown.erb:

    <% code 'c' do %>
    if (~1) {
      void 0;
    }
    <% end %>

* `rake syntax:theme[theme_name]` -- to set the theme (defaults to thankful_eyes)
* `rake syntax:themes` -- to get the list of themes

Syntax highlighting is provided by [rouge][rouge]

[rouge]: https://github.com/jayferd/rouge
