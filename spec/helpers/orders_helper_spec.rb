require 'spec_helper'

describe OrdersHelper do
  let(:today) { Date.new 2014, 5, 22 }

  it { expect(helper.business_days_after(3)).to eq 5 }
  it { expect(helper.business_days_after(14)).to eq 20 }
end
