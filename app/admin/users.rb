ActiveAdmin.register User do
  permit_params :email, :password, :nickname, :firstname, :lastname, :picture,
                location_attributes: [:city, :country, :latitude, :longitude]

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
      image_row :picture, style: :thumb
    end
  end
end