Deface::Override.new(:virtual_path => "spree/shared/_products",
                     :name => "home_product_trial_class",
                     :add_to_attributes => "ul#products > li",
                     :attributes => {:class => "<%= if product.have_trial_period? then 'trial' end %>"})

