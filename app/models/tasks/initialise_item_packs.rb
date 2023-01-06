# frozen_string_literal: true

module Tasks
  class InitialiseItemPacks < Task
    def initialize(attributes = nil)
      super
      self.description = 'Initialise the ItemPacks using the standard list that is shown in P+ ' \
                         'when editing a master product (called Item Pack Name there).'
    end

    protected

    def execute
      names.each do |name|
        ItemPack.find_or_create_by!(
          name: name,
          canonical: true,
          data_source: :import
        )
      end
    end

    private

    def names
      YAML.load_file(Rails.root.join('lib/assets/item_packs/en.yml')).values
    end
  end
end
