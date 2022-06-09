# frozen_string_literal: true

json.extract!(item_pack, :id, :name, :canonical, :created_at, :updated_at)
json.url(item_pack_url(item_pack, format: :json))
