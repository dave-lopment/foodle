require 'spec_helper'

describe User do
  it 'expect not to be valid' do
    user = build(:user, name: '')
    expect(user).not_to be_valid
  end
  it 'expect postal code length equal to 5'
  it 'expect email_address to be unique'
  it 'expect street not to be nil or blank'
  it 'expect city not to be nil or blank'
end
