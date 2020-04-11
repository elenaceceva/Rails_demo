ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment

  permit_params :email, :password, :nickname, :firstname, :lastname, :picture ,location_attributes: [:city, :country, :latitude, :longitude ]
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form(:html => { :multipart => true }) do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :email
      f.input :password
      f.input :nickname
      f.input :firstname
      f.input :lastname
      f.input :picture, :as => :file
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
    column :location
    image_column :picture, style: :thumb
    actions
  end


  show do
    attributes_table do
      row :email
      row :nickname
      row :firstname
      row :lastname
      row :location
      image_row :picture
    end
  end
end