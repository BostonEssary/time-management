class ProductScraperService
  def initialize
    @base_url = "https://www.leafly.com"
  end

  def get_product_page(link)
    response = Net::HTTP.get(URI(link))
    doc = Nokogiri::HTML(response)
    doc.css("#__next")
    product_details = {}

    product_details[:name] = doc.css('[class="Text-sc-e03b5ed0-0 hpOOZX"]').text
    product_details[:brand_details] = doc.css('[id="radix-:R56bimmm:"]').text
    product_details[:product_details] = doc.css('[id="radix-:R4mbimmm:"]').text
    product_details[:thc] = doc.css('[class="Text-sc-e03b5ed0-0 hpOOZX"]').text

    product_details
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
