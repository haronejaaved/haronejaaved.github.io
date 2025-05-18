require 'nokogiri'

Jekyll::Hooks.register :documents, :post_render do |doc|
  next unless doc.output_ext == ".html"
  doc.output = add_target_blank_to_pdf_links(doc.output)
end

Jekyll::Hooks.register :pages, :post_render do |page|
  next unless page.output_ext == ".html"
  page.output = add_target_blank_to_pdf_links(page.output)
end

def add_target_blank_to_pdf_links(html)
  doc = Nokogiri::HTML::DocumentFragment.parse(html)
  doc.css('a[href$=".pdf"]').each do |a|
    a.set_attribute('target', '_blank')
    a.set_attribute('rel', 'noopener')
  end
  doc.to_html
end
