# == Schema Information
#
# Table name: journals
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  image      :string
#

class Journal < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy

  validates :title, presence: true, length: { in: 4..50 }
  validates :body, presence: true, length: { in: 4..1000 }

  default_scope { order(updated_at: :desc) }

  delegate :nick_name, :email, to: :user

  mount_uploader :image, ImageUploader
end
