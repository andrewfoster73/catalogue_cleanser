# frozen_string_literal: true

json.extract!(item_measure, :id, :name, :canonical, :created_at, :updated_at)
json.url(item_measure_url(item_measure, format: :json))
