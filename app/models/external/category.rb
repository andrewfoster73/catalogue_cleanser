# frozen_string_literal: true

module External
  # Connects to external Goods::Category class
  class Category < External::ApplicationRecord
    self.table_name = :goods_categories

    belongs_to :parent, class_name: 'External::Category'
    has_many :children,
             -> { order(:name) },
             class_name: 'External::Category',
             foreign_key: :parent_id,
             dependent: nil,
             inverse_of: :parent

    scope :roots, -> { where(parent_id: nil).order(:name) }

    def to_s
      name
    end
  end
end
