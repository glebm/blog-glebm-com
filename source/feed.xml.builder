xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title data.blog.title
  xml.subtitle data.blog.subtitle
  xml.id "#{root_url}/"
  xml.link "href" => "#{root_url}/"
  xml.link "href" => atom_feed_url, "rel" => "self"
  xml.updated blog.articles.first.date.to_time.iso8601 unless blog.articles.empty?
  xml.author { xml.name data.author.name }

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article_url(article)
      xml.id "#{root_url}/#{article.url}"
      xml.published article.date.to_time.iso8601
      xml.updated article.date.to_time.iso8601
      xml.author { xml.name data.author.name }
      # xml.summary article.summary, "type" => "html"
      current_resource.add_metadata article: article
      xml.content article.body, "type" => "html"
      current_resource.add_metadata article: nil
    end
  end
end