ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment

  permit_params :email, :password, :nickname, :firstname, :lastname, :location_id, location_attributes: [:city, :country, :latitude, :longitude ]
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :email
      f.input :password
      f.input :nickname
      f.input :firstname
      f.input :lastname
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
    column :email
    column :nickname
    column :firstname
    column :lastname
    actions
  end

  show do
    attributes_table :email, :nickname, :firstname, :lastname
  end
end