task fetch: :environment do
  Rate.create source: 'PayPal', from: 'USD', to: 'PLN', value: Curates::Fetchers::Paypal.current_rate('USD', 'PLN')
end
