task fetch: :environment do
  rate = Rate.create source: 'PayPal', from: 'USD', to: 'PLN', value: Curates::Fetchers::Paypal.current_rate('USD', 'PLN')
  puts "Fetched #{rate.inspect}"
end

task :ping do
  require 'curates'
  value = Curates::Fetchers::Paypal.current_rate('USD', 'PLN')
  puts "Current value: #{value}"
end
