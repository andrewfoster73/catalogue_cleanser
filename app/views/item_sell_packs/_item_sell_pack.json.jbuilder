# frozen_string_literal: true

json.extract!(item_sell_pack, :id, :name, :canonical, :created_at, :updated_at)
json.url(item_sell_pack_url(item_sell_pack, format: :json))
