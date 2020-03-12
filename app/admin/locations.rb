ActiveAdmin.register Location do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  index do
    column :city
    column :country
    column :longitude
    column :latitude
    actions
  end
  #
  # or
  #
  # permit_params do
  #permitted = [:user_id, :name, :content, :state]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end