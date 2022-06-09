# frozen_string_literal: true

json.extract!(item_measure_alias, :id, :item_measure_id, :alias, :confirmed, :created_at, :updated_at)
json.url(item_measure_alias_url(item_measure_alias, format: :json))
