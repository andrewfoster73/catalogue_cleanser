# frozen_string_literal: true

module Tasks
  class InitialiseItemSellPacks < Task
    def initialize(attributes = nil)
      super
      self.description = 'Initialise the ItemSellPacks using the standard list that is shown in P+ ' \
                         'when editing a master product (called Item Sell Pack Name there).'
    end

    protected

    def execute
      names.each do |name|
        ItemSellPack.find_or_create_by!(
          name: name,
          canonical: true
        )
      end
    end

    private

    def names
      YAML.load_file("#{Rails.root}/lib/assets/item_sell_packs/en.yml").values
    end
  end
end
