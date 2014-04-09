require 'spec_helper'

describe Subscription do
  before do
  	@subscribed_tag=build_stubbed(:tag)
  	@user=build_stubbed(:user)
  	@subscription=build_stubbed(:subscription)
  	@subscription.tag=@subscribed_tag
  	@subscription.user=@user
  end
  subject { @subscription }
  it { should be_valid }

end
