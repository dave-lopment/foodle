require 'rails_helper'

describe Category do
  it "should be valid with normal attributes" do
    category = build(:category)
    expect(category).to be_valid
  end

  it "should be invalid when name is nil" do
    category = build(:category, name: nil)
    expect(category).not_to be_valid
  end

  it "should be invalid when name is blank" do
    category = build(:category, name: '  ')
    expect(category).not_to be_valid
  end

  it "should be invalid if name too long" do
    category = build(:category, name: 'a'*33)
    expect(category).not_to be_valid
  end

end
