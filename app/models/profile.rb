# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  nick_name  :string
#  avatar     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ActiveRecord::Base
  belongs_to :user

  mount_uploader :avatar, AvatarUploader
end
