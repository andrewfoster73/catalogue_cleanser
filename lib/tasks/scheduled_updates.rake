# frozen_string_literal: true

namespace :scheduled_updates do
  desc 'Collect stats for how the products are being used in P+ from the vw_product_usage_counts view'
  task usage: :environment do
    puts "Starting scheduled_updates:usage: #{Time.zone.now}"
    Tasks::GatherUsageStatistics.new.call
    puts "Finished scheduled_updates:usage: #{Time.zone.now}"
  end

  desc 'Collect pricing information for the products being used in P+ from the vw_product_pricing view'
  task pricing: :environment do
    puts "Starting scheduled_updates:pricing: #{Time.zone.now}"
    Tasks::GatherPricingStatistics.new.call
    puts "Finished scheduled_updates:pricing: #{Time.zone.now}"
  end

  desc 'Check and fix issues for products'
  task discover_and_fix_issues: :environment do
    puts "Starting scheduled_updates:discover_issues: #{Time.zone.now}"
    count = 0
    Product.includes(:product_translations).find_each do |product|
      product.discover_and_fix_issues!
      count += 1
      puts "Inspected #{count} products" if (count % 1000).zero?
    end
    puts "Finished scheduled_updates:discover_issues: #{Time.zone.now}"
  end

  desc 'Check for any newly created central catalogue products in P+ and add to the cleanser'
  task add_new_products: :environment do
    puts "Starting scheduled_updates:add_new_products: #{Time.zone.now}"
    puts "Finished scheduled_updates:add_new_products: #{Time.zone.now}"
  end
end
