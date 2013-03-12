Spree::Country.class_eval do
  def self.available_countries
    [ Spree::Country.find_by_iso_and_name('BR', 'Brazil'),
      Spree::Country.find_by_iso_and_name('US', 'United States') ]
  end
end