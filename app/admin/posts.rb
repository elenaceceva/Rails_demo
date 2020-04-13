ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :user_id, :picture, :tag_names, location_attributes: [:city, :country, :latitude, :longitude ]
  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs  do
      f.input :user_id
      f.input :title
      f.input :description
      f.input :picture, :as => :file
      f.fields_for :location_attributes do |ff|
        ff.input :city
        ff.input :country
        ff.input :latitude
        ff.input :longitude
      end
      f.inputs 'Tags' do
      f.text_field :tag_names
      end
      end
    f.actions
  end

  index do
    column :title
    column :description
    column :user_id
    column :location
    column :tags
    image_column :picture, style: :thumb
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :user_id
      row :location
      image_row :picture
      row :tags
    end
  end
end
