# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  name          :string
#  tel           :string
#  zipcode       :string
#  address       :string
#  delivery_day  :date
#  delivery_time :string
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#

require 'spec_helper'

describe Order do
  it { should respond_to :min_day }
  it { should respond_to :max_day }
  it { should respond_to :cart }
  it { should respond_to :items }

  subject(:order) { build :order }

  describe '#delivery_day_limit' do
    shared_examples_for 'invalid delivery_day' do
      it { should be_invalid }
      it { expect(subject.errors.messages).to include :delivery_day }
    end

    context 'delivery_day < min_day' do
      before do
        subject.delivery_day = subject.min_day - 1
        subject.valid?
      end

      it_behaves_like 'invalid delivery_day'
    end

    context 'min_day < delivery_day < max_day' do
      context 'and, is weekend' do
        before do
          subject.delivery_day = (subject.min_day..subject.max_day).to_a.find { |day| day.wday.in? [0, 6] }

          subject.valid?
        end

        it_behaves_like 'invalid delivery_day'
      end

      context 'and, not weekend' do
        before do
          subject.delivery_day = (subject.min_day..subject.max_day).to_a.find { |day| !day.wday.in?([0, 6]) }

          subject.valid?
        end

        it { should be_valid }
      end
    end

    context 'max_day < delivery_day' do
      before do
        subject.delivery_day = subject.max_day + 1
        
        subject.valid?
      end

      it_behaves_like 'invalid delivery_day'
    end
  end

  describe '#postage_amount' do
    subject { order.postage_amount }

    let(:cart) { }

    context '4個の場合' do
      before do
        allow(order).to receive_message_chain(:cart, :items)
          .and_return FactoryGirl.create_list(:cart_item, 4)
      end

      it { should eq 600 }
    end

    context '6個の場合' do
      before do
        items = []
        items << FactoryGirl.create(:cart_item)
        items << FactoryGirl.create(:cart_item, quantity: 2)
        items << FactoryGirl.create(:cart_item, quantity: 3)

        allow(order).to receive_message_chain(:cart, :items).and_return(items)
      end

      it { should eq 1200 }
    end
  end

  describe '#set_default_address' do
    let(:cart) { create(:cart) }
    let(:order) { build(:order, cart: cart) }

    context 'デフォルトアドレスが保存されてない場合' do
      it 'デフォルトアドレスが新規される' do
        expect {
          order.save!
        }.to change(DefaultAddress, :count).by(1)
      end
    end

    context 'デフォルトアドレスが既に保存されている場合' do
      before { order.user.default_address = FactoryGirl.create(:default_address) }

      it 'デフォルトアドレスが変更されない' do
        expect {
          order.save!
        }.not_to change(DefaultAddress, :count)
      end
    end
  end
end
