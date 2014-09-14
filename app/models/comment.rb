class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :journal

  default_scope { order(created_at: :desc).includes(:user) }
end
