require 'rails_helper'

describe Article do
  it "expect not to be valid when name is blank" do
    article = FactoryGirl.build(:article, name: ' ')
    expect(article).not_to be_valid
  end

  it "expect not to be valid when no price" do
    article = FactoryGirl.build(:article, price: ' ')
    expect(article).not_to be_valid
  end

  it "expect not to be valid when price less than 0" do
    article = FactoryGirl.build(:article, price: '-50')
    expect(article).not_to be_valid
  end
end
