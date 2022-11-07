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
      Audited.audit_class.as_user("task-initialise-item-sell-packs-#{id}") do
        names.each do |name|
          ItemSellPack.find_or_create_by!(
            name: name,
            canonical: true
          ).tap { |pack| pack.update!(data_source: :import) }
        end
      end
    end

    private

    def names
      YAML.load_file(Rails.root.join('lib/assets/item_sell_packs/en.yml')).values
    end
  end
end
