module Tools
  class StrainCreator < RubyLLM::Tool
    description "Gets data via scraper and makes new Flower Object based on data"
    param :name, desc: "Used for the name attribute on the Flower model"
    param :thc, desc: "Used for the THC attribute on the Flower model"
    param :strain, desc: "Used for the strain attribute on the Flower model"
    param :description, desc: "used for the desciption attribute on the Flower model. Should only be 2-3 sentences"


    def execute(name:, thc:, strain:, description:)
      Rails.logger.info("Attributes: #{name}, #{thc}, #{strain}, #{description}")
      Flower.create!(name:, thc:, strain:, description:)
    end
  end
end
