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

require 'rails_helper'

describe Order do
  it { should respond_to :min_day }
  it { should respond_to :max_day }
  it { should respond_to :cart }
  it { should respond_to :items }

  subject(:order) { build :order }

  describe '#fee_amount' do
    subject { order.fee_amount }
    let(:item) { build :cart_item, quantity: 1 }
    before do
      order.items.clear
      order.items << item
    end

    context 'total_amount < 10_00' do
      before { item.product.price = 1_000 }
      it { should eq 300 }
    end

    context '10_000 < total_amount < 30_000' do
      before { item.product.price = 20_000 }
      it { should eq 400 }
    end

    context '30_000 < total_amount < 100_000' do
      before { item.product.price = 50_000 }
      it { should eq 600 }
    end

    context '100_000 < total_amount' do
      before { item.product.price = 200_000 }
      it { should eq 1000 }
    end
  end

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
          subject.delivery_day = (subject.min_day..subject.max_day).to_a.find { |day| !day.workday? }
          subject.valid?
        end

        it_behaves_like 'invalid delivery_day'
      end

      context 'and, not weekend' do
        before do
          subject.delivery_day = (subject.min_day..subject.max_day).to_a.find(&:workday?)
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
