class ProductScraperService
  def initialize
    @base_url = "https://www.leafly.com"
  end

  def get_pre_roll_product_links
    url = "https://www.leafly.com/products/cannabis/prerolls"
    identifier = '[data-testid="product-card-horizontal"]'
    product_links = []

    response = Net::HTTP.get(URI(url))
    doc = Nokogiri::HTML(response)
    doc.css(identifier).each do |pre_roll|
      product_links << @base_url + pre_roll.css("a").attr("href").value
    end

    product_links
  end

  def get_product_details(url)
    second_identifier = '[class="expandable-container expandable-container__no-button"]'

    response = Net::HTTP.get(URI(url))
    doc = Nokogiri::HTML(response)

    doc.css(second_identifier).each_with_index do |product, index|
      # Split by line breaks and remove empty lines
      formatted_text = product.text.split(/\n/).reject(&:empty?)

      puts "\n=== Product Section ==="
      formatted_text.each do |line|
        puts line.strip
      end
      puts "==================\n"
    end
  end
end
