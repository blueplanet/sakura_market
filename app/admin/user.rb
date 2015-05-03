ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation
  actions :all, except: [:new, :create]

  index do
    selectable_column
    id_column
    column :email
    column :nick_name
    column :avatar do |user|
      image_tag user.avatar_url(:thumb)
    end
    actions
  end

  show do
    attributes_table do
      row :nick_name
      row :avatar do
        image_tag user.avatar_url(:thumb)
      end
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.inputs "Profile", for: [:profile, f.object.profile] do |profile|
        profile.input :nick_name
        profile.input :avatar
      end
    end
    f.actions
  end
end
