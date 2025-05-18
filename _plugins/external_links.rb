Jekyll::Hooks.register [:pages, :posts], :post_render do |doc|
  next unless doc.output_ext == ".html"

  # Use Nokogiri to modify HTML
  require 'nokogiri'
  doc_html = Nokogiri::HTML::DocumentFragment.parse(doc.output)

  doc_html.css('a').each do |a|
    href = a['href']
    next unless href && href.start_with?('http')
    a.set_attribute('target', '_blank')
    a.set_attribute('rel', 'noopener noreferrer')
  end

  doc.output = doc_html.to_html
end
