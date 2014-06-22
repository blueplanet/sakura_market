require 'spec_helper'

describe Order do
  it { should respond_to :min_day }
  it { should respond_to :max_day }

  subject(:order) { Order.new }

  describe '#delivery_day' do
    before do
      subject.delivery_day = subject.min_day - 1
      subject.valid?
    end

    it { should be_invalid }
    it { expect(subject.errors.messages).to include :delivery_day }
  end


  describe '#postage' do
    subject { order.postage(items) }

    context '4個の場合' do
      let(:items) { FactoryGirl.create_list(:cart_item, 4) }
      it { should eq 600 }
    end

    context '6個の場合' do
      let(:items) do
        items = []
        items << FactoryGirl.create(:cart_item)
        items << FactoryGirl.create(:cart_item, quantity: 2)
        items << FactoryGirl.create(:cart_item, quantity: 3)
      end

      it { should eq 1200 }
    end
  end

  describe '#set_default_address' do
    let(:order) { build(:order) }

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
