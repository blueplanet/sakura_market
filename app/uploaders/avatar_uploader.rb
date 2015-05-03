class AvatarUploader < ImageUploader
  version :thumb do
    process resize_to_fit: [200, 150]
  end
end
