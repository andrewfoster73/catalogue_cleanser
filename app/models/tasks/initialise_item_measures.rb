# frozen_string_literal: true

module Tasks
  class InitialiseItemMeasures < Task
    def initialize(attributes = nil)
      super
      self.description = 'Initialise the ItemMeasures using the standard list that is shown in P+ ' \
                         'when editing a master product. This actually comes from the ruby-measurement gem.'
    end

    protected

    def execute
      Audited.audit_class.as_user("task-initialise-item-measures-#{id}") do
        names.each do |name|
          ItemMeasure.find_or_create_by!(
            name: name,
            canonical: true
          ).tap { |measure| measure.update!(data_source: :import) }
        end
      end
    end

    private

    def names
      YAML.load_file(Rails.root.join('lib/assets/item_measures/en.yml')).values
    end
  end
end
