# Set the host name for URL creation
SitemapGenerator::Sitemap.sitemaps_path = '/var/www/greatpass/shared/public' if Rails.env.production?

SitemapGenerator::Sitemap.default_host = "https://greatpass.io"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # Add the search page
  add items_search_path, changefreq: 'daily'

  # Add all item pages
  Item.find_each do |item|
    add item_path(item_slug: item.url_slug), lastmod: item.updated_at
  end
end
