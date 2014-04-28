require 'spec_helper'

describe ApplicationHelper do
  describe '#current_cart' do
    subject { helper.current_cart }

    context '未ログインの場合' do
      before { controller.stub(:current_user).and_return(nil) }
      it { should be_nil }
    end

    context 'ログインしている場合' do
      let(:user) { create(:user) }
      before { controller.stub(:current_user).and_return(user) }
      it { should be_a(Cart) }
    end
  end
end
