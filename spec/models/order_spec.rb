require 'spec_helper'

describe Order do
  it { should respond_to :min_day }
  it { should respond_to :max_day }

  describe '#delivery_day' do
    subject { Order.new }
    before do
      subject.delivery_day = subject.min_day - 1
      subject.valid?
    end

    it { should be_invalid }
    it { expect(subject.errors.messages).to include :delivery_day }
  end
end
