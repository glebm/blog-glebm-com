### Workflow

* `middleman` to start development server
* `middleman article TITLE` to generate a new article
* `rake build` to test build
* `rake publish` to publish (builds and pushes to gh-pages branch on origin)

### Forking

When forking, change the following files to your data:

* data/*.yml (esp. disqus.yml and google_analytics.yml)
* source/CNAME -- remove, or change contents to your CNAME (this is for gh-pages)
