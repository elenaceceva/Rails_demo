ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :user_id, location_attributes: [:city, :country, :latitude, :longitude ]
  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs  do
      f.input :user_id
      f.input :title
      f.input :description
      f.fields_for :location_attributes do |ff|
        ff.input :city
        ff.input :country
        ff.input :latitude
        ff.input :longitude
      end
    end
    f.actions
  end

  index do
    column :title
    column :description
    column :user_id
    actions
  end

  show do
    attributes_table :title, :description, :user_id
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