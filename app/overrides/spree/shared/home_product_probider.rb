Deface::Override.new(:virtual_path => "spree/shared/_products",
                     :name => "home_product_probider",
                     :insert_after => "code[erb-loud]:contains('product.name')",
                     :text => "<%= link_to truncate(product.provider.name, :length => 50), main_app.provider_path(product.provider), :title => product.provider.name %>")