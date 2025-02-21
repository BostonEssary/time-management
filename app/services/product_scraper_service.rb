class ProductScraperService
  def initialize(url)
    @url = url
  end

  def get_product_details
    response = Net::HTTP.get(URI(@url))
    doc = Nokogiri::HTML(response)
    # get expandable-container expandable-container__no-button
    expandable_container = doc.css(".expandable-container.expandable-container__no-button")
    # get the text of the expandable container
    expandable_container_text = expandable_container.text

    expandable_container_text
  end
end
