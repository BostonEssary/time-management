module Maintenance
  class ScrapeStrainInfoTask < MaintenanceTasks::Task
    attribute :url_content, :string

    def collection
      [ url_content ].compact
    end

    def process(url)
      raise ArgumentError, "URL cannot be blank" if url.blank?
      result = Scrapers::StrainInfoService.new(url).call
      sens = result[:sensations]
      effects = derive_effects(sens)
      flower = create_flower(result)

      Rails.logger.info("Effects: #{effects}")
      Rails.logger.info("New Flower: #{flower}")
    end

    def derive_effects(sens)
      chat = RubyLLM.chat
      effect_tool = Tools::DeriveEffects.new

      chat.with_tool(effect_tool)
      response = chat.ask(effects_prompt(sens))
      response.content
    end

    def create_flower(result)
      chat = RubyLLM.chat
      strain_tool = Tools::StrainCreator.new

      chat.with_tool(strain_tool)
      response = chat.ask(strain_prompt(result))
      response.content
    end

    def effects_prompt(sens)
      "Match this effect data from the scrapper: #{sens} to effects in the database. Do not return anything but a comma seperated list of the effect names. No other information or explanation is needed. Anything other than a comma seperated list with invalidate the response."
    end

    def strain_prompt(result)
      "Create a flower object with these results: #{result}. When doing the description, summarize the provided description to be 2-3 sentences and only provide important information."
    end
  end
end
