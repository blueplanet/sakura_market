module UsersHelper
  def avatar_image(profile)
    if profile.avatar?
      image_tag profile.avatar_url(:thumb), class: 'profile-avatar'
    else
      content_tag :span, '', class: 'glyphicon glyphicon-user profile-avatar'
    end
  end
end
