# frozen_string_literal: true

json.extract!(item_pack_alias, :id, :item_pack_id, :alias, :confirmed, :created_at, :updated_at)
json.url(item_pack_alias_url(item_pack_alias, format: :json))
