# frozen_string_literal: true

json.extract!(item_sell_pack_alias, :id, :item_sell_pack_id, :alias, :confirmed, :created_at, :updated_at)
json.url(item_sell_pack_alias_url(item_sell_pack_alias, format: :json))
