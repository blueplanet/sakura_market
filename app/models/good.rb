class Good < ActiveRecord::Base
  belongs_to :journal
  belongs_to :user
end
