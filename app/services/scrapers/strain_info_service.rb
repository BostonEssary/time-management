require "net/http"
require "uri"
require "nokogiri"

module Scrapers
  class StrainInfoService
    def initialize(url)
      @url = url
    end

    def call
      response = fetch_page
      doc = Nokogiri::HTML(response.body)

      name = doc.css(".heading--l.mb-xs")
      thc = doc.at_css('[data-testid="THC"]')&.text
      strain = doc.css(".inline-block.text-xs.px-sm.rounded.font-bold.text-default.bg-white.border.border-light-grey.py-0")
      sensations = doc.css(".flex.flex-col.gap-sm.border.border-light-grey.rounded.text-xs.p-lg")
      description = doc.css(".jsx-ab29da9b1f387cb")

      {
        name: name&.text,
        thc: thc[/\d+/],
        strain: strain&.text.downcase,
        sensations: sensations&.text,
        description: description&.text
      }
    end

    private

    def fetch_page
      uri = URI(@url)
      Net::HTTP.get_response(uri)
    end
  end
end
