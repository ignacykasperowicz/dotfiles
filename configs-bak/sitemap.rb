Property.find_each do |property|
  sitemap = SitemapWriter.new(SitemapGenerator::Sitemap)

  SitemapGenerator::Sitemap.default_host = root_url(host: property.primary_domain)
  SitemapGenerator::Sitemap.compress = false
  SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/#{property.id}"
  SitemapGenerator::Sitemap.create do
    sitemap.set_commercial_endpoints_for(property) ||
      sitemap.set_rent_endpoints_for(property)
  end
end
