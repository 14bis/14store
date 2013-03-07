Spree::Role.class_eval do
  self.const_set( "ADMIN", self.find_by_name("admin") )
  self.const_set( "PROVIDER", self.find_by_name("provider") )
  self.const_set( "USER", self.find_by_name("user") )
end