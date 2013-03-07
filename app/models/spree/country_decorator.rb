Spree::Country.class_eval do
  self.const_set( "AVAILABLE_COUNTRIES", [
      self.find_by_iso_and_name('BR', 'Brazil'),
      self.find_by_iso_and_name('US', 'United States')
    ])
end