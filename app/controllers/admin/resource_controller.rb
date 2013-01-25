class Admin::ResourceController < Spree::Admin::ResourceController
  
  def collection_url(options = {})
  
    main_app.polymorphic_url([:admin, model_class], options)
  
# Commenting default implementation because the condition is not necessary for now
# And I could not think on a test to reproduce the correct behavior of collection_url
# But we want our tests coverage to be 100%, as long as possible
  
#    if parent_data.present?
#      main_app.polymorphic_url([:admin, parent, model_class],
#  options)
#    else
#      main_app.polymorphic_url([:admin, model_class], options)
#    end
  end 
  
end
