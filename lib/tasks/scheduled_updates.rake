# frozen_string_literal: true

namespace :scheduled_updates do
  task usage: :environment do
    puts "Starting scheduled_updates:usage: #{Time.zone.now}"
    Tasks::GatherUsageStatistics.new.call
    puts "Finished scheduled_updates:usage: #{Time.zone.now}"
  end

  task discover_issues: :environment do
    puts "Starting scheduled_updates:usage: #{Time.zone.now}"
    count = 0
    Product.includes(:product_translations).find_each do |product|
      product.discover_and_fix_issues!
      count += 1
      puts "Inspected #{count} products" if (count % 1000).zero?
    end
    puts "Finished scheduled_updates:usage: #{Time.zone.now}"
  end
end
