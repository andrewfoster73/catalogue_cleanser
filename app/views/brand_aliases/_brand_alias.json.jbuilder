# frozen_string_literal: true

json.extract!(brand_alias, :id, :brand_id, :alias, :confirmed, :count, :created_at, :updated_at)
json.url(brand_alias_url(brand_alias, format: :json))
