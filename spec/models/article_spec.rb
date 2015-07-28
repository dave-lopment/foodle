require 'rails_helper'

describe Article do
  it "expect normal article to be valid" do
    article = build(:article)
    expect(article).to be_valid 
  end

  it "expect not to be valid when name is blank" do
    article = build(:article, name: '    ')
    expect(article).not_to be_valid
  end

  it "expect not to be valid when no price" do
    article = build(:article, price: '')
    expect(article).not_to be_valid
  end

  it "expect not to be valid when price less than 0" do
    article = build(:article, price: -50)
    expect(article).not_to be_valid
  end

  it "expect price to have correct format (number.xx)" do
    article = build(:article, price: 10.123)
    expect(article).not_to be_valid
  end
end
