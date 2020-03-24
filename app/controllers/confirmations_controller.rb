class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    #sign_in(resource) # In case you want to sign in the user
    confirmation_getting_started
  end
end