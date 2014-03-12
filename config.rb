require 'lib/sass_css_import'
require 'lib/date_time_helpers'
helpers DateTimeHelpers

Time.zone = 'Europe/Madrid'

activate :syntax

# Blog settings
activate :blog do |blog|
  # blog.prefix  = 'blog'
  blog.permalink         = ':year/:month/:day/:title'
  blog.sources           = ':year-:month-:day-:title'
  blog.taglink           = 'tags/:tag.html'
  blog.layout            = 'article_layout'
  blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250

  blog.year_link         = ':year.html'
  blog.month_link        = ':year/:month.html'
  blog.day_link          = ':year/:month/:day.html'

  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/:num"

  blog.tag_template      = 'tag.html'
  blog.calendar_template = 'calendar.html'
  blog.default_extension = '.html.markdown.erb'
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
activate :automatic_image_sizes

activate :autoprefixer, browsers: ['last 2 versions', 'ie >= 9']

# Methods defined in the helpers block are available in templates
helpers do
  #= absolutize image_tag and article URLs
  def image_tag(*args)
    super(*args).sub /src=['"](.*?)['"]/, "src='#{root_url}\\1'"
  end

  def main_class(val = nil)
    if val
      @main_class = Array(@main_class) + [val]
    else
      @main_class || 'animated fade-in'
    end
  end

  def article_url(article = current_article)
    root_url + article.url
  end

  def article_image_url(img)
    root_url + article_image_path(path)
  end

  def article_image_path(img)
    article = current_article || current_resource.metadata[:article]
    File.join(article.path.sub(/\.\w+$/, ''), img)
  end

  # image in article subfolder
  def article_image_tag(*args)
    image_tag article_image_path(args.shift), *args
  end

  #= layout helpers
  def glyphicon(*keys)
    attr         = keys.extract_options!
    attr[:class] = (['glyphicon'] + keys.map { |k| "glyphicon-#{ERB::Util.html_escape(k)}" }).uniq.compact * ' '
    %Q(<i #{attr_to_s attr}></i>).strip.html_safe
  end

  def fa(*keys)
    attr         = keys.extract_options!
    attr[:class] = (['fa'] + keys.map { |k| "fa-#{ERB::Util.html_escape(k)}" }).uniq.compact * ' '
    %Q(<i #{attr_to_s attr}></i>).strip.html_safe
  end

  # {a: 1, b: 2} => 'a=1 b=2'
  # escapes values
  def attr_to_s(hash)
    hash.map { |k, v| %(#{k}='#{v.html_safe? ? v : ERB::Util.html_escape(v)}') } * ' '
  end

  #= url helpers
  # site root without / at the end
  def root_url
    if environment == :development
      'http://localhost:4567'
    else
      data.urls.root
    end
  end

  def atom_feed_url
    "#{root_url}/feed.xml"
  end

  def suggest_edit_article_url(article)
    src_path = "source/#{article.path}.markdown.erb"
    "#{data.urls.source}/blob/master/#{src_path}"
  end

  # other helpers
  def blog_article_comments(article = current_article, opts = {})
    opts = {id: article.slug.sub(/\.html$/, ''), url: article_url(article), title: article.title}.merge(opts)
    disqus_comments(opts)
  end

  def disqus_comments(opts = {})
    return nil unless data.disqus.site_id
    opts = {
        site_id: data.disqus.site_id,
    }.merge(opts)
    vars = {
        disqus_shortname:  opts[:site_id],
        disqus_identifier: opts[:id],
        disqus_title:      opts[:title],
        disqus_url:        opts[:url]
    }
    <<-HTML
    <div id="disqus_thread"></div>
    <script type="text/javascript">
      #{vars.map { |k, v| "var #{k} = #{v.to_json};" if v.present? }.compact * "\n"}
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
    data.google_analytics.ua
  end

  def google_analytics_js
    return nil unless google_analytics_account_id
    ('<script type="text/javascript">' + <<-JS + '</script>').html_safe
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      ga('create', '#{google_analytics_account_id}', '#{URI(data.urls.root).host}');
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

