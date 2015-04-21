# == Schema Information
#
# Table name: default_addresses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  tel        :string
#  zipcode    :string
#  address    :string
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe DefaultAddress do
  describe '#copy_to' do
    let(:default_address ) { FactoryGirl.create :default_address }
    let(:order) { Order.new }
    before { default_address.copy_to order }

    it "プロパティの値がコピーされる" do
      %w(name tel zipcode address).each do |prop|
        expect(order[prop]).to eq default_address[prop]
      end
    end
  end
end
