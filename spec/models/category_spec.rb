require 'rails_helper'

describe Category do
  it "should be invalid when no name" do
    category = build(:category, name: '  ')
    expect(category).not_to be_valid
  end

  it "should be invalid if name too long" do
    category = build(:category, name: 'a'*33)
    expect(category).not_to be_valid
  end
end
