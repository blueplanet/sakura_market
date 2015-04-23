ActiveAdmin.register Product do
  index do
    selectable_column
    id_column
    column :name
    column :image do |product|
      div do
        image_tag product.image_url if product.image?
      end
    end
    column :price, class: 'price'
    column :description
    column :display_no
    column :created_at
    column :updated_at
    actions
  end

  permit_params :name, :image, :image_cache, :price, :description, :display_no
end
