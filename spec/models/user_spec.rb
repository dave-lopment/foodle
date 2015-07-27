require 'spec_helper'

describe User do
  it 'expect not to be valid' do
    user = build(:user, name: '')
    expect(user).not_to be_valid
  end
end
