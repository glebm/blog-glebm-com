###
# Blog settings
###

Time.zone = 'Europe/Madrid'

activate :syntax

activate :blog do |blog|
  # blog.prefix = "blog"
  # blog.permalink = ":year/:month/:day/:title.html"
  # blog.sources = ":year-:month-:day-:title.html"
  # blog.taglink = "tags/:tag.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = ":year.html"
  # blog.month_link = ":year/:month.html"
  # blog.day_link = ":year/:month/:day.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/:num"
end

page '/feed.xml', :layout => false

### 
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
# 
# With no layout
# page "/path/to/file.html", :layout => false
# 
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
# 
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do
  def blog_article_comments(article = current_article)
    disqus_comments(id: article.slug, url: data.blog.root_url[0..-2] + url_for(article), title: article.title)
  end

  def disqus_comments(opts = {})
    opts = {
      site_id: 'blog-glebm',
    }.merge(opts)
    vars = {
      disqus_shortname: opts[:site_id],
      disqus_identifier: opts[:id],
      disqus_title: opts[:title],
      disqus_url: opts[:url]
    }
  <<-HTML
  <div id="disqus_thread"></div>
    <script type="text/javascript">
      #{vars.map {|k,v| "var #{k} = #{v.to_json};" if v.present? }.compact * "\n"}
      (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
      })();
    </script>
    <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
    <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
  HTML
  end

  def google_analytics_account_id
    'UA-43451052-1'
  end

  def google_analytics_js
    ('<script type="text/javascript">' + <<-JS + '</script>').html_safe
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      ga('create', '#{google_analytics_account_id}', 'glebm.com');
      ga('send', 'pageview');
    JS
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css
  
  # Minify Javascript on build
  activate :minify_javascript
  
  # Enable cache buster
  activate :cache_buster
  
  # Use relative URLs
  activate :relative_assets

  set :relative_links, true
  
  # Compress PNGs after build
  # First: gem install middleman-smusher
  require 'middleman-smusher'
  activate :smusher
  
  # Or use a different image path
  # set :http_path, "/Content/images/"
end

# Better errors
use BetterErrors::Middleware
BetterErrors.application_root = __dir__

