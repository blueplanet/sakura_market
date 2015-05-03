# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :default_address, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :goods, dependent: :delete_all
  has_many :good_journals, through: :goods, source: :journal

  before_create { build_profile nick_name: email }

  delegate :nick_name, :avatar, :avatar?, :avatar_url, to: :profile
end
