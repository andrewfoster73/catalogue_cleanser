# frozen_string_literal: true

namespace :initialisation do
  task start: :environment do
    # Brands
    puts "Starting initialisation:start:brands: #{Time.zone.now}"
    Tasks::InitialiseBrands.new.call
    puts "Finished initialisation:start:brands: #{Time.zone.now}"

    # Item Measures
    puts "Starting initialisation:start:item_measures: #{Time.zone.now}"
    Tasks::InitialiseItemMeasures.new.call
    puts "Finished initialisation:start:item_measures: #{Time.zone.now}"

    # Item Packs
    puts "Starting initialisation:start:item_packs: #{Time.zone.now}"
    Tasks::InitialiseItemPacks.new.call
    puts "Finished initialisation:start:item_packs: #{Time.zone.now}"

    # Item Sell Packs
    puts "Starting initialisation:start:item_sell_packs: #{Time.zone.now}"
    Tasks::InitialiseItemSellPacks.new.call
    puts "Finished initialisation:start:item_sell_packs: #{Time.zone.now}"

    # Products
    puts "Starting initialisation:start:products: #{Time.zone.now}"
    Tasks::InitialiseProducts.new.call
    puts "Finished initialisation:start:products: #{Time.zone.now}"
  end
end
