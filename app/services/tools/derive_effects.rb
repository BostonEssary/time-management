module Tools
  class DeriveEffects < RubyLLM::Tool
    description "Returns a comma seperated list of effect names that match to the effects in the scraper data. When using this tool, you should only return a comma seperated list of the effects that match."
    param :effects_from_scraper

    def initialize
      @db_effect_names = Effect.all.pluck(:name)
    end

    def execute(effects_from_scraper:)
      { effects_from_scraper:, db_effect_names: @db_effect_names }
    end
  end
end
