class Journal < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :goods

  validates :title, presence: true, length: { in: 4..50 }
  validates :body, presence: true, length: { in: 4..1000 }

  default_scope { order(updated_at: :desc) }

  mount_uploader :image, ImageUploader
end
